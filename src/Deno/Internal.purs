module Deno.Internal where

import Data.Maybe (Maybe(..))
import Unsafe.Coerce (unsafeCoerce)

foreign import data Undefined :: Type -> Type

foreign import _undefined :: forall x. Undefined x

maybeToUndefined :: forall a. Maybe a -> Undefined a
maybeToUndefined (Just x) = unsafeCoerce x

maybeToUndefined Nothing = _undefined
