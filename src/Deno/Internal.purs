module Deno.Internal
  ( Undefined
  , maybeToUndefined
  ) where

import Prelude
import Data.Maybe (Maybe(..))
import Unsafe.Coerce (unsafeCoerce)

foreign import data Undefined :: Type -> Type

foreign import _undefined :: forall x. Undefined x

foreign import _removeUndefinedPairs :: forall x. Undefined x -> Undefined x

maybeToUndefined :: forall a. Maybe a -> Undefined a
maybeToUndefined (Just x) = _removeUndefinedPairs $ unsafeCoerce x

maybeToUndefined Nothing = _undefined
