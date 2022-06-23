module Deno.Uuid
  ( isNil
  , validate
  , version
  , nil_uuid
  ) where

import Prelude
import Data.Maybe (Maybe(..))
import Deno.Uuid.Type (UUID)
import Unsafe.Coerce (unsafeCoerce)

-- | Check if the passed UUID is the nil UUID. 
foreign import isNil :: UUID -> Boolean

foreign import _validate :: String -> Boolean

-- | Test a string to see if it is a valid UUID.
validate :: String -> Maybe UUID
validate x = if _validate x then Just $ unsafeCoerce x else Nothing

-- | Detect RFC version of a UUID.
foreign import version :: UUID -> Int

foreign import nil_uuid :: UUID
