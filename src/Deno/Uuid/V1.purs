module Deno.Uuid.V1
  ( V1Options
  , generate
  , validate
  ) where

import Prelude
import Data.Function.Uncurried (Fn0, mkFn0)
import Data.Maybe (Maybe(..))
import Deno.Internal (Undefined, maybeToUndefined)
import Deno.Uuid.Type (UUID)
import Unsafe.Coerce (unsafeCoerce)

type V1Options
  = { clockseq :: Maybe Int
    , msecs :: Maybe Int
    , node :: Maybe (Array Int)
    , nsecs :: Maybe Int
    , random :: Maybe (Array Int)
    , rng :: Maybe (Unit -> (Array Int))
    }

type V1Options'
  = { clockseq :: Undefined Int
    , msecs :: Undefined Int
    , node :: Undefined (Array Int)
    , nsecs :: Undefined Int
    , random :: Undefined (Array Int)
    , rng :: Undefined (Fn0 (Array Int))
    }

foreign import _generate :: Undefined V1Options' -> Undefined (Array Int) -> Undefined Int -> UUID

foreign import _validate :: String -> Boolean

validate :: String -> Maybe UUID
validate x = if _validate x then Just $ unsafeCoerce x else Nothing

-- | Generates a RFC4122 v1 UUID (time-based).
generate :: Maybe V1Options -> Maybe (Array Int) -> Maybe Int -> UUID
generate options buf offset = _generate (maybeToUndefined $ map toIntern options) (maybeToUndefined buf) (maybeToUndefined offset)
  where
  toIntern :: V1Options -> V1Options'
  toIntern o =
    o
      { clockseq = maybeToUndefined $ o.clockseq
      , msecs = maybeToUndefined $ o.msecs
      , node = maybeToUndefined $ o.node
      , nsecs = maybeToUndefined $ o.nsecs
      , random = maybeToUndefined $ o.random
      , rng = maybeToUndefined $ map mkFn0 o.rng
      }
