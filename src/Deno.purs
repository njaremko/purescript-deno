module Deno
  ( ListenOptions
  , ListenTlsOptions
  , Listener
  , listen
  , listenTls
  , env
  ) where

import Prelude
import Data.Argonaut (Json, decodeJson)
import Data.Either (fromRight)
import Data.Function.Uncurried (Fn0, runFn0)
import Data.Map (Map)
import Effect (Effect)

type ListenOptions
  = { port :: Int
    }

type ListenTlsOptions
  = { port :: Int
    , certFile :: String
    , keyFile :: String
    , alpnProtocols :: Array String
    }

-- | A Deno listener.
foreign import data Listener :: Type

foreign import _listen :: ListenOptions -> Effect Listener

foreign import _listenTls :: ListenTlsOptions -> Effect Listener

foreign import _env :: Fn0 Json

env :: Map String String
env = fromRight mempty $ decodeJson $ runFn0 _env

listen :: ListenOptions -> Effect Listener
listen options = _listen options

listenTls :: ListenTlsOptions -> Effect Listener
listenTls options = _listenTls options
