module Deno.Http where

import Prelude
import Control.Promise as Promise
import Data.Argonaut (Json, decodeJson, encodeJson)
import Data.Either (fromRight)
import Data.Map (Map)
import Data.Map as Map
import Data.Maybe (Maybe(..))
import Data.Tuple (Tuple(..))
import Deno (Listener)
import Deno.Http.Request (Request)
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Aff.Compat (EffectFnAff, fromEffectFnAff)
import Unsafe.Coerce (unsafeCoerce)

-- | A HTTP response object
foreign import data Response :: Type

type Handler
  = Request -> Aff Response

type Handler'
  = Request -> Effect (Promise.Promise Response)

mapHandler :: Handler -> Handler'
mapHandler h = \req -> Promise.fromAff $ h req

-- | A HTTP response object
foreign import data ServeInit :: Type

foreign import data Undefined :: Type -> Type

maybeToUndefined :: forall a. Maybe a -> Undefined a
maybeToUndefined (Just x) = unsafeCoerce x

maybeToUndefined Nothing = _undefined

foreign import _undefined :: forall x. Undefined x

foreign import _serveListener :: Listener -> Handler' -> Undefined ServeInit -> EffectFnAff Unit

foreign import _serve :: Handler' -> Undefined ServeInit -> EffectFnAff Unit

foreign import _createResponse :: String -> Undefined Options' -> Response

foreign import _getCookies :: Json -> Json

foreign import _setCookies :: Json -> Cookie' -> Effect Unit

foreign import _deleteCookie :: Json -> String -> Undefined DeleteCookieAttributes' -> Effect Unit

type Options
  = { headers :: Maybe (Map String String)
    , status :: Maybe Int
    , statusText :: Maybe String
    }

type Options'
  = { headers :: Undefined Json
    , status :: Undefined Int
    , statusText :: Undefined String
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

type Cookie'
  = { domain :: Undefined String
    , expires :: Undefined String
    , httpOnly :: Undefined Boolean
    , maxAge :: Undefined Int
    , name :: String
    , path :: Undefined String
    , sameSite :: Undefined String
    , secure :: Undefined Boolean
    , unparsed :: Undefined (Array String)
    , value :: String
    }

type DeleteCookieAttributes
  = { path :: Maybe String
    , domain :: Maybe String
    }

type DeleteCookieAttributes'
  = { path :: Undefined String
    , domain :: Undefined String
    }

serve :: Handler -> Maybe ServeInit -> Aff Unit
serve h s = fromEffectFnAff $ _serve (mapHandler h) (maybeToUndefined s)

serveListener :: Listener -> Handler -> Maybe ServeInit -> Aff Unit
serveListener l h s = fromEffectFnAff $ _serveListener l (mapHandler h) (maybeToUndefined s)

getCookies :: Map String String -> Map String String
getCookies j = fromRight Map.empty $ decodeJson $ _getCookies (encodeJson j)

setCookies :: Map String String -> Cookie -> Effect Unit
setCookies j c = _setCookies (encodeJson j) (toIntern c)
  where
  toIntern :: Cookie -> Cookie'
  toIntern cookie =
    { domain: maybeToUndefined $ cookie.domain
    , expires: maybeToUndefined $ cookie.expires
    , httpOnly: maybeToUndefined $ cookie.httpOnly
    , maxAge: maybeToUndefined $ cookie.maxAge
    , name: cookie.name
    , path: maybeToUndefined $ cookie.path
    , sameSite: maybeToUndefined $ cookie.sameSite
    , secure: maybeToUndefined $ cookie.secure
    , unparsed: maybeToUndefined $ cookie.unparsed
    , value: cookie.value
    }

deleteCookie :: Map String String -> String -> Maybe DeleteCookieAttributes -> Effect Unit
deleteCookie headers name attrs = _deleteCookie (encodeJson headers) name (maybeToUndefined (map toIntern attrs))
  where
  toIntern :: DeleteCookieAttributes -> DeleteCookieAttributes'
  toIntern cookieAttrs =
    { path: maybeToUndefined $ cookieAttrs.path
    , domain: maybeToUndefined $ cookieAttrs.domain
    }

createResponse :: String -> Maybe Options -> Response
createResponse body o = _createResponse body (maybeToUndefined (map toIntern o))
  where
  toIntern :: Options -> Options'
  toIntern opts =
    { headers: maybeToUndefined $ map encodeJson opts.headers
    , status: maybeToUndefined $ opts.status
    , statusText: maybeToUndefined $ opts.statusText
    }

hContentTypeJson :: Tuple String String
hContentTypeJson = Tuple "content-type" "application/json"

hContentTypeHtml :: Tuple String String
hContentTypeHtml = Tuple "content-type" "text/html; charset=UTF-8"
