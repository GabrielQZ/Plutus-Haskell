
import           Control.Monad             (void)
import           Language.Plutus.Contract
import qualified Language.PlutusTx         as PlutusTx
import           Language.PlutusTx.Prelude hiding (Applicative (..))
import           Ledger                    (Address, ValidatorCtx, scriptAddress)
import qualified Ledger.Constraints        as Constraints
import qualified Ledger.Typed.Scripts      as Scripts
import           Ledger.Value              (Value)
import           Playground.Contract

newtype MyDatum = MyDatum Integer deriving newtype PlutusTx.IsData
PlutusTx.makeLift ''MyDatum

newtype MyRedeemer = MyRedeemer Integer deriving newtype PlutusTx.IsData
PlutusTx.makeLift ''MyRedeemer


validateSpend :: MyDatum -> MyRedeemer -> ValidatorCtx -> Bool
validateSpend _myDataValue _myRedeemerValue _ = error () 


contractAddress :: Address
contractAddress = Ledger.scriptAddress (Scripts.validatorScript starterInstance)

data Starter
instance Scripts.ScriptType Starter where
    type instance RedeemerType Starter = MyRedeemer
    type instance DatumType Starter = MyDatum


starterInstance :: Scripts.ScriptInstance Starter
starterInstance = Scripts.validator @Starter
    $$(PlutusTx.compile [|| validateSpend ||])
    $$(PlutusTx.compile [|| wrap ||]) where
        wrap = Scripts.wrapValidator @MyDatum @MyRedeemer


type Schema =
    BlockchainActions
        .\/ Endpoint "publish" (Integer, Value)
        .\/ Endpoint "redeem" Integer

contract :: AsContractError e => Contract Schema e ()
contract = publish `select` redeem


publish :: AsContractError e => Contract Schema e ()
publish = do
    (i, lockedFunds) <- endpoint @"publish"
    let tx = Constraints.mustPayToTheScript (MyDatum i) lockedFunds
    void $ submitTxConstraints starterInstance tx


redeem :: AsContractError e => Contract Schema e ()
redeem = do
    myRedeemerValue <- endpoint @"redeem"
    unspentOutputs <- utxoAt contractAddress
    let redeemer = MyRedeemer myRedeemerValue
        tx       = collectFromScript unspentOutputs redeemer
    void $ submitTxConstraintsSpending starterInstance unspentOutputs tx

endpoints :: AsContractError e => Contract Schema e ()
endpoints = contract

mkSchemaDefinitions ''Schema

$(mkKnownCurrencies [])
