import           Control.Monad             (void)
import qualified Data.ByteString.Char8     as C
import           Language.Plutus.Contract
import qualified Language.PlutusTx         as PlutusTx
import           Language.PlutusTx.Prelude hiding (pure, (<$>))
import           Ledger                    (Address, Validator, ValidatorCtx, Value, scriptAddress, pubKeyHash)
import qualified Ledger.Constraints        as Constraints
import qualified Ledger.Typed.Scripts      as Scripts
import           Playground.Contract
import qualified Prelude
import           Wallet.Emulator.Wallet    (Wallet, walletPubKey)

randomNum :: Integer
randomNum = toInteger $ fromEnum $ C.last $ C.pack $ show $ walletPubKey $ Wallet 1

secretAns :: Integer
secretAns = 314

validateGuess :: Integer -> Integer -> ValidatorCtx -> Bool
validateGuess actual guess _ = guess == actual || guess == secretAns

data GameDataType
instance Scripts.ScriptType GameDataType where
    type instance DatumType GameDataType = Integer
    type instance RedeemerType GameDataType = Integer

gameAddress :: Address
gameAddress = Ledger.scriptAddress $ Scripts.validatorScript gameInstance

gameInstance :: Scripts.ScriptInstance GameDataType
gameInstance = Scripts.validator @GameDataType
    $$(PlutusTx.compile [|| validateGuess ||])
    $$(PlutusTx.compile [|| Scripts.wrapValidator @Integer @Integer ||])

data LockParams  = LockParams
    { amount :: Value}
    deriving stock (Prelude.Eq, Prelude.Show, Generic)
    deriving anyclass (FromJSON, ToJSON, IotsType, ToSchema, ToArgument)

newtype GuessParams = GuessParams
    { guessNumber :: Integer}
    deriving stock (Prelude.Eq, Prelude.Show, Generic)
    deriving anyclass (FromJSON, ToJSON, IotsType, ToSchema, ToArgument)

lock :: AsContractError e => Contract GameSchema e ()
lock = do
    LockParams amount <- endpoint @"lock" @LockParams
    let tx = Constraints.mustPayToTheScript randomNum amount
    void $ submitTxConstraints gameInstance tx

guess :: AsContractError e => Contract GameSchema e ()
guess = do
    GuessParams guessed <- endpoint @"guess" @GuessParams
    if guessed > randomNum
        then logInfo $ show "It's lower."
        else if guessed < randomNum
            then logInfo $ show "It's higher."
            else logInfo $ show "Correct, you get the ADA."
    
    unspentOutputs <- utxoAt gameAddress
    let tx = collectFromScript unspentOutputs guessed
    void $ submitTxConstraints gameInstance tx

type GameSchema = BlockchainActions
    .\/ Endpoint "lock" LockParams
    .\/ Endpoint "guess" GuessParams

endpoints :: AsContractError e => Contract GameSchema e()
endpoints = lock

mkSchemaDefinitions ''GameSchema

$(mkKnownCurrencies [])