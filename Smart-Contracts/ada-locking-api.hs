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

validateGuess :: Integer -> Integer -> ValidatorCtx -> Bool
validateGuess _ _ _ = True

data GameDataType
instance Scripts.ScriptType GameDataType where
    type instance DatumType GameDataType = Integer
    type instance RedeemerType GameDataType = Integer

gameInstance :: Scripts.ScriptInstance GameDataType
gameInstance = Scripts.validator @GameDataType
    $$(PlutusTx.compile [|| validateGuess ||])
    $$(PlutusTx.compile [|| Scripts.wrapValidator @Integer @Integer ||])

data LockParams = LockParam
    {amount :: Value}
    deriving stock (Prelude.Eq, Prelude.Show, Generic)
    deriving anyclass (FromJSON, ToJSON, IotsType, ToSchema, ToArgument)

lock :: AsContractError e => Contract GameSchema e ()
lock = do
    LockParam amount <- endpoint @"lock" @LockParams
    let tx = Constraints.mustPayToTheScript 314 amount
    void $ submitTxConstraints gameInstance tx

type GameSchema = BlockchainActions
    .\/ Endpoint "lock" LockParams
    .\/ Endpoint "guess" ()

endpoints :: AsContractError e => Contract GameSchema e()
endpoints = lock

mkSchemaDefinitions ''GameSchema

$(mkKnownCurrencies [])