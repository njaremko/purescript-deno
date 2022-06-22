module Deno.Crypto
  ( Algorithm
  , CbcAlgorithm
  , GcmAlgorithm
  , CryptoKey
  , encrypt
  , decrypt
  , sign
  , verify
  , generateKey
  , makeAesCbcAlgorithm
  , makeAesGcmAlgorithm
  ) where

import Prelude
import Control.Promise (Promise)
import Control.Promise as Promise
import Data.ArrayBuffer.Types (ArrayBuffer)
import Data.Maybe (Maybe)
import Deno.Internal (Undefined, maybeToUndefined)
import Effect (Effect)
import Effect.Aff (Aff)

type CryptoKey r
  = { type :: String
    , extractable :: Boolean
    , algorithm :: Algorithm r
    , usages :: Array String
    }

foreign import _generateKey :: forall r. Algorithm r -> Boolean -> Array String -> Effect (Promise (CryptoKey r))

generateKey :: forall r. Algorithm r -> Boolean -> Array String -> Aff (CryptoKey r)
generateKey alg extractable usages = Promise.toAffE $ _generateKey alg extractable usages

type Algorithm r
  = { name :: String | r }

type CbcAlgorithm
  = Algorithm ( iv :: ArrayBuffer )

type GcmAlgorithm
  = Algorithm ( iv :: ArrayBuffer, additionalData :: Undefined ArrayBuffer, tagLength :: Undefined Int )

makeAesCbcAlgorithm :: ArrayBuffer -> CbcAlgorithm
makeAesCbcAlgorithm iv = { name: "AES-CBC", iv }

makeAesGcmAlgorithm :: ArrayBuffer -> Maybe ArrayBuffer -> Maybe Int -> GcmAlgorithm
makeAesGcmAlgorithm iv additionalData tagLength =
  { name: "AES-GCM"
  , iv
  , additionalData: maybeToUndefined additionalData
  , tagLength: maybeToUndefined tagLength
  }

foreign import _encrypt :: forall r. Algorithm r -> CryptoKey r -> ArrayBuffer -> Effect (Promise ArrayBuffer)

encrypt :: forall r. Algorithm r -> CryptoKey r -> ArrayBuffer -> Aff ArrayBuffer
encrypt alg key dat = Promise.toAffE $ _encrypt alg key dat

foreign import _decrypt :: forall r. Algorithm r -> CryptoKey r -> ArrayBuffer -> Effect (Promise ArrayBuffer)

decrypt :: forall r. Algorithm r -> CryptoKey r -> ArrayBuffer -> Aff ArrayBuffer
decrypt alg key dat = Promise.toAffE $ _encrypt alg key dat

foreign import _sign :: forall r. Algorithm r -> CryptoKey r -> ArrayBuffer -> Effect (Promise ArrayBuffer)

sign :: forall r. Algorithm r -> CryptoKey r -> ArrayBuffer -> Aff ArrayBuffer
sign alg key dat = Promise.toAffE $ _sign alg key dat

foreign import _verify :: forall r. Algorithm r -> CryptoKey r -> ArrayBuffer -> ArrayBuffer -> Effect (Promise Boolean)

verify :: forall r. Algorithm r -> CryptoKey r -> ArrayBuffer -> ArrayBuffer -> Aff Boolean
verify alg key sig dat = Promise.toAffE $ _verify alg key sig dat
