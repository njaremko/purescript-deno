module Deno.Http.Request
  ( Request
  , body
  , bodyUsed
  , cache
  , credentials
  , destination
  , headers
  , integrity
  , json
  , method
  , mode
  , priority
  , redirect
  , referrer
  , referrerPolicy
  , text
  , url
  ) where

import Prelude
import Control.Promise (Promise)
import Control.Promise as Promise
import Data.Argonaut (Json, decodeJson)
import Data.Either (fromRight)
import Data.Map (Map)
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Aff.Compat (EffectFnAff, fromEffectFnAff)
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

foreign import _json :: Request -> Effect (Promise Json)

json :: Request -> Aff Json
json req = Promise.toAffE $ _json req

foreign import _text :: Request -> Effect (Promise String)

text :: Request -> Aff String
text req = Promise.toAffE $ _text req
