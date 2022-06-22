module Deno
  ( ListenOptions
  , ListenTlsOptions
  , Listener
  , listen
  , listenTls
  ) where

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

listen :: ListenOptions -> Effect Listener
listen options = _listen options

listenTls :: ListenTlsOptions -> Effect Listener
listenTls options = _listenTls options
