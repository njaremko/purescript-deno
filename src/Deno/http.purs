module Deno.Http where

import Prelude
import Data.Argonaut (Json, decodeJson, encodeJson)
import Data.Either (fromRight)
import Data.Map (Map)
import Data.Map as Map
import Data.Maybe (Maybe)
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Aff.Compat (EffectFnAff, fromEffectFnAff)

-- | A HTTP request object
foreign import data Request :: Type

-- | A HTTP response object
foreign import data Response :: Type

type Handler
  = Request -> Response

-- | A HTTP response object
foreign import data ServeInit :: Type

foreign import _serve :: Handler -> Maybe ServeInit -> EffectFnAff Unit

foreign import _createResponse :: String -> Maybe Json -> Response

foreign import _getCookies :: Json -> Json

foreign import _setCookies :: Json -> Json -> Effect Unit

foreign import _deleteCookie :: Json -> String -> Maybe Json -> Effect Unit

type Options
  = { headers :: Maybe (Map String String)
    , status :: Maybe Int
    , statusText :: Maybe String
    }

type Cookie
  = { domain :: Maybe String
    , expires :: Maybe String
    , httpOnly :: Maybe Boolean
    , maxAge :: Maybe Int
    , name :: String
    , path :: Maybe String
    , sameSite :: Maybe String
    , secure :: Maybe Boolean
    , unparsed :: Maybe (Array String)
    , value :: String
    }

type DeleteCookieAttributes
  = { path :: Maybe String
    , domain :: Maybe String
    }

serve :: Handler -> Maybe ServeInit -> Aff Unit
serve h s = fromEffectFnAff $ _serve h s

getCookies :: Map String String -> Map String String
getCookies j = fromRight Map.empty $ decodeJson $ _getCookies (encodeJson j)

setCookies :: Map String String -> Cookie -> Effect Unit
setCookies j c = _setCookies (encodeJson j) (encodeJson c)

deleteCookie :: Map String String -> String -> Maybe DeleteCookieAttributes -> Effect Unit
deleteCookie headers name attrs = _deleteCookie (encodeJson headers) name (map encodeJson attrs)

createResponse :: String -> Maybe Options -> Response
createResponse body o = _createResponse body (map encodeJson o)
