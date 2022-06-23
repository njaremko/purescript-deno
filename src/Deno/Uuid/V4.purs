module Deno.Uuid.V4
  ( validate
  ) where

import Prelude
import Data.Maybe (Maybe(..))
import Deno.Uuid.Type (UUID)
import Unsafe.Coerce (unsafeCoerce)

foreign import _validate :: String -> Boolean

-- | Validate that the passed UUID is an RFC4122 v4 UUID.
validate :: String -> Maybe UUID
validate x = if _validate x then Just $ unsafeCoerce x else Nothing
