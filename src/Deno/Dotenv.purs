module Deno.Dotenv
  ( ConfigOptions
  , config
  , configSync
  ) where

import Prelude
import Control.Promise (Promise)
import Control.Promise as Promise
import Data.Argonaut (Json, decodeJson)
import Data.Either (fromRight)
import Data.Map (Map)
import Data.Maybe (Maybe)
import Deno.Internal (Undefined, maybeToUndefined)
import Effect (Effect)
import Effect.Aff (Aff)

type ConfigOptions
  = { path :: Maybe String -- | Optional path to .env file. Defaults to ./.env. 
    , export :: Maybe Boolean -- | Set to true to export all .env variables to the current processes environment. Variables are then accessable via Deno.env.get(<key>). Defaults to false.
    , safe :: Maybe Boolean -- | Set to true to ensure that all necessary environment variables are defined after reading from .env. It will read .env.example to get the list of needed variables.
    , example :: Maybe String -- | Optional path to .env.example file. Defaults to ./.env.example.
    , allowEmptyValues :: Maybe Boolean -- | Set to true to allow required env variables to be empty. Otherwise it will throw an error if any variable is empty. Defaults to false.
    , defaults :: Maybe String -- | Optional path to .env.defaults file which defaults to ./.env.defaults.
    }

type ConfigOptions'
  = { path :: Undefined String
    , export :: Undefined Boolean
    , safe :: Undefined Boolean
    , example :: Undefined String
    , allowEmptyValues :: Undefined Boolean
    , defaults :: Undefined String
    }

foreign import _config :: Undefined ConfigOptions' -> Effect (Promise Json)

config :: Maybe ConfigOptions -> Aff (Map String String)
config options = do
  val <- Promise.toAffE $ _config $ maybeToUndefined $ map toIntern options
  pure $ fromRight mempty $ decodeJson val
  where
  toIntern :: ConfigOptions -> ConfigOptions'
  toIntern o =
    { path: maybeToUndefined $ o.path
    , export: maybeToUndefined $ o.export
    , safe: maybeToUndefined $ o.safe
    , example: maybeToUndefined $ o.example
    , allowEmptyValues: maybeToUndefined $ o.allowEmptyValues
    , defaults: maybeToUndefined $ o.defaults
    }

foreign import _configSync :: Undefined ConfigOptions' -> Effect Json

configSync :: Maybe ConfigOptions -> Effect (Map String String)
configSync options = do
  val <- _configSync $ maybeToUndefined $ map toIntern options
  pure $ fromRight mempty $ decodeJson val
  where
  toIntern :: ConfigOptions -> ConfigOptions'
  toIntern o =
    { path: maybeToUndefined $ o.path
    , export: maybeToUndefined $ o.export
    , safe: maybeToUndefined $ o.safe
    , example: maybeToUndefined $ o.example
    , allowEmptyValues: maybeToUndefined $ o.allowEmptyValues
    , defaults: maybeToUndefined $ o.defaults
    }
