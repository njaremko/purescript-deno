module Deno.Fs
  ( CopyOptions
  , copy
  , copySync
  , move
  , moveSync
  ) where

import Prelude
import Control.Promise (Promise)
import Control.Promise as Promise
import Data.Maybe (Maybe)
import Deno.Internal (Undefined, maybeToUndefined)
import Effect (Effect)
import Effect.Aff (Aff)

type CopyOptions
  = { overwrite :: Maybe Boolean
    , preserveTimestamps :: Maybe Boolean
    }

type CopyOptions'
  = { overwrite :: Undefined Boolean
    , preserveTimestamps :: Undefined Boolean
    }

foreign import _copy :: String -> String -> Undefined CopyOptions' -> Effect (Promise Unit)

copy :: String -> String -> Maybe CopyOptions -> Aff Unit
copy src dest opts = Promise.toAffE $ _copy src dest (maybeToUndefined $ map toIntern opts)
  where
  toIntern :: CopyOptions -> CopyOptions'
  toIntern o =
    { overwrite: maybeToUndefined $ o.overwrite
    , preserveTimestamps: maybeToUndefined $ o.preserveTimestamps
    }

foreign import _copySync :: String -> String -> Undefined CopyOptions' -> Effect Unit

copySync :: String -> String -> Maybe CopyOptions -> Effect Unit
copySync src dest opts = _copySync src dest (maybeToUndefined $ map toIntern opts)
  where
  toIntern :: CopyOptions -> CopyOptions'
  toIntern o =
    { overwrite: maybeToUndefined $ o.overwrite
    , preserveTimestamps: maybeToUndefined $ o.preserveTimestamps
    }

type MoveOptions
  = { overwrite :: Maybe Boolean
    }

type MoveOptions'
  = { overwrite :: Undefined Boolean
    }

foreign import _move :: String -> String -> Undefined MoveOptions' -> Effect (Promise Unit)

move :: String -> String -> Maybe MoveOptions -> Aff Unit
move src dest opts = Promise.toAffE $ _move src dest (maybeToUndefined $ map toIntern opts)
  where
  toIntern :: MoveOptions -> MoveOptions'
  toIntern o =
    { overwrite: maybeToUndefined $ o.overwrite
    }

foreign import _moveSync :: String -> String -> Undefined MoveOptions' -> Effect Unit

moveSync :: String -> String -> Maybe MoveOptions -> Effect Unit
moveSync src dest opts = _moveSync src dest (maybeToUndefined $ map toIntern opts)
  where
  toIntern :: MoveOptions -> MoveOptions'
  toIntern o =
    { overwrite: maybeToUndefined $ o.overwrite
    }
