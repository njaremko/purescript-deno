module Deno.Http.Request
  ( Request
  , body
  , bodyUsed
  , cache
  , credentials
  , destination
  , headers
  , integrity
  , method
  , mode
  , priority
  , redirect
  , referrer
  , referrerPolicy
  , url
  ) where

import Prelude
import Data.Argonaut (Json, decodeJson)
import Data.Either (fromRight)
import Data.Map (Map)
import Web.Streams.ReadableStream (ReadableStream)

-- | A HTTP request object
foreign import data Request :: Type

foreign import body :: forall x. Request -> ReadableStream x

foreign import bodyUsed :: Request -> Boolean

foreign import cache :: Request -> String

foreign import credentials :: Request -> String

foreign import destination :: Request -> String

foreign import _headers :: Request -> Json

headers :: Request -> Map String String
headers req = fromRight mempty $ decodeJson $ _headers req

foreign import integrity :: Request -> String

foreign import method :: Request -> String

foreign import mode :: Request -> String

foreign import priority :: Request -> String

foreign import redirect :: Request -> String

foreign import referrer :: Request -> String

foreign import referrerPolicy :: Request -> String

foreign import url :: Request -> String
