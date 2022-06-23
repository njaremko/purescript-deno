module Deno.Uuid.V5
  ( validate
  , generate
  ) where

import Prelude
import Control.Promise (Promise)
import Control.Promise as Promise
import Data.ArrayBuffer.Types (Uint8Array)
import Data.Maybe (Maybe(..))
import Deno.Uuid.Type (UUID)
import Effect (Effect)
import Effect.Aff (Aff)
import Unsafe.Coerce (unsafeCoerce)

foreign import _validate :: String -> Boolean

foreign import _generate :: String -> Uint8Array -> Effect (Promise UUID)

-- | Validate that the passed UUID is an RFC4122 v5 UUID.
validate :: String -> Maybe UUID
validate x = if _validate x then Just $ unsafeCoerce x else Nothing

-- | Generate a RFC4122 v5 UUID (SHA-1 namespace).
generate :: String -> Uint8Array -> Aff UUID
generate namespace dat = Promise.toAffE $ _generate namespace dat
