module Deno.Log
  ( ConsoleHandlerOptions
  , FileHandlerOptions
  , Handler
  , HandlerOptions
  , LevelName
  , LogConfig
  , LogMode
  , Logger
  , LoggerConfig
  , RotatingFileHandlerOptions
  , WriterHandlerOptions
  , appendLogMode
  , createConsoleHandler
  , createFileHandler
  , createRotatingFileHandler
  , createWriterHandler
  , critical
  , debug
  , error
  , exclusiveCreationLogMode
  , getLogger
  , info
  , setup
  , warning
  , writeLogMode
  ) where

import Prelude
import Control.Promise (Promise)
import Control.Promise as Promise
import Data.Map (Map)
import Data.Map as Map
import Data.Maybe (Maybe)
import Data.Tuple (Tuple)
import Deno.Internal (Undefined, maybeToUndefined)
import Effect (Effect)
import Effect.Aff (Aff)
import Foreign.Object (Object)
import Foreign.Object as Object

foreign import _critical :: String -> Effect Unit

foreign import _debug :: String -> Effect Unit

foreign import _error :: String -> Effect Unit

foreign import _info :: String -> Effect Unit

foreign import _warning :: String -> Effect Unit

foreign import _setup :: LogConfig' -> Effect (Promise Unit)

foreign import _getLogger :: String -> Logger

foreign import _createConsoleHandler :: LevelName -> Undefined ConsoleHandlerOptions' -> Handler

foreign import _createWriterHandler :: LevelName -> Undefined WriterHandlerOptions' -> Handler

foreign import _createFileHandler :: LevelName -> Undefined (FileHandlerOptions' ()) -> Handler

foreign import _createRotatingFileHandler :: LevelName -> Undefined RotatingFileHandlerOptions' -> Handler

createConsoleHandler :: LevelName -> Maybe ConsoleHandlerOptions -> Handler
createConsoleHandler level opt = _createConsoleHandler level (maybeToUndefined $ map toIntern opt)
  where
  toIntern :: ConsoleHandlerOptions -> ConsoleHandlerOptions'
  toIntern o =
    { formatter: maybeToUndefined o.formatter
    }

createWriterHandler :: LevelName -> Maybe WriterHandlerOptions -> Handler
createWriterHandler level opt = _createWriterHandler level (maybeToUndefined $ map toIntern opt)
  where
  toIntern :: WriterHandlerOptions -> WriterHandlerOptions'
  toIntern o =
    { formatter: maybeToUndefined o.formatter
    }

createFileHandler :: LevelName -> Maybe (FileHandlerOptions ()) -> Handler
createFileHandler level opt = _createFileHandler level (maybeToUndefined $ map toIntern opt)
  where
  toIntern :: FileHandlerOptions () -> FileHandlerOptions' ()
  toIntern o =
    { formatter: maybeToUndefined o.formatter
    , filename: o.filename
    , mode: maybeToUndefined o.mode
    }

createRotatingFileHandler :: LevelName -> Maybe RotatingFileHandlerOptions -> Handler
createRotatingFileHandler level opt = _createRotatingFileHandler level (maybeToUndefined $ map toIntern opt)
  where
  toIntern :: RotatingFileHandlerOptions -> RotatingFileHandlerOptions'
  toIntern o =
    { formatter: maybeToUndefined o.formatter
    , filename: o.filename
    , mode: maybeToUndefined o.mode
    , maxBytes: o.maxBytes
    , maxBackupCount: o.maxBackupCount
    }

foreign import data LevelName :: Type

foreign import data Handler :: Type

foreign import data Logger :: Type

newtype LogMode
  = LogMode String

appendLogMode :: LogMode
appendLogMode = LogMode "a"

exclusiveCreationLogMode :: LogMode
exclusiveCreationLogMode = LogMode "x"

writeLogMode :: LogMode
writeLogMode = LogMode "w"

type HandlerOptions r
  = { formatter :: Maybe String
    | r
    }

type ConsoleHandlerOptions
  = HandlerOptions ()

type WriterHandlerOptions
  = HandlerOptions ()

type FileHandlerOptions r
  = HandlerOptions
      ( filename :: String
      , mode :: Maybe LogMode
      | r
      )

type RotatingFileHandlerOptions
  = FileHandlerOptions
      ( maxBytes :: Int
      , maxBackupCount :: Int
      )

type HandlerOptions' r
  = { formatter :: Undefined String
    | r
    }

type ConsoleHandlerOptions'
  = HandlerOptions' ()

type WriterHandlerOptions'
  = HandlerOptions' ()

type FileHandlerOptions' r
  = HandlerOptions'
      ( filename :: String
      , mode :: Undefined LogMode
      | r
      )

type RotatingFileHandlerOptions'
  = FileHandlerOptions'
      ( maxBytes :: Int
      , maxBackupCount :: Int
      )

type LogConfig
  = { handlers :: Maybe (Map String Handler)
    , loggers :: Maybe (Map String LoggerConfig)
    }

type LoggerConfig
  = { handlers :: Maybe (Array String)
    , level :: Maybe LevelName
    }

type LogConfig'
  = { handlers :: Undefined (Object Handler)
    , loggers :: Undefined (Object LoggerConfig')
    }

type LoggerConfig'
  = { handlers :: Undefined (Array String)
    , level :: Undefined LevelName
    }

-- | Get a logger instance. If not specified name, get the default logger.
getLogger :: String -> Logger
getLogger = _getLogger

-- | Log with critical level, using default logger.
critical :: String -> Effect Unit
critical = _critical

-- | Log with debug level, using default logger.
debug :: String -> Effect Unit
debug = _debug

-- | Log with error level, using default logger.
error :: String -> Effect Unit
error = _error

-- | Log with info level, using default logger.
info :: String -> Effect Unit
info = _info

-- | Log with warning level, using default logger.
warning :: String -> Effect Unit
warning = _warning

setup :: LogConfig -> Aff Unit
setup c = Promise.toAffE <<< _setup $ toIntern c
  where
  toIntern :: LogConfig -> LogConfig'
  toIntern o =
    { handlers: maybeToUndefined $ map (\h -> Object.fromFoldable (Map.toUnfoldable h :: Array (Tuple String Handler))) o.handlers
    , loggers: maybeToUndefined $ map (\l -> Object.fromFoldable (Map.toUnfoldable $ map toInternLoggerConfig l :: Array (Tuple String LoggerConfig'))) o.loggers
    }

  toInternLoggerConfig :: LoggerConfig -> LoggerConfig'
  toInternLoggerConfig o =
    { handlers: maybeToUndefined o.handlers
    , level: maybeToUndefined o.level
    }
