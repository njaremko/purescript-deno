# purescript-deno

Deno bindings for Purescript

Implemented:
- [ ] [Std](https://deno.land/std@0.144.0)
  - [x] http 
  - [x] dotenv
  - [x] crypto (basic functionality)
  - [x] fs


# Example Deno web server

## Step 1. Make a `main.purs`
```purescript
module Main
  ( main
  ) where

import Prelude
import Data.Argonaut (stringify)
import Data.Map as Map
import Data.Maybe (Maybe(..), fromMaybe)
import Data.String (Replacement(..), Pattern(..), replace)
import Deno as Deno
import Deno.Dotenv as Dotenv
import Deno.Http (Handler, Response, createResponse, hContentTypeHtml, hContentTypeJson, serveListener)
import Deno.Http.Request (Request)
import Deno.Http.Request as Request
import Effect (Effect)
import Effect.Aff (Aff, launchAff_)
import Effect.Console (log)

main :: Effect Unit
main = do
  log "Let's get cookin 🍝"
  e <-
    Dotenv.configSync $ Just
      $ { export: Just true
        , allowEmptyValues: Nothing
        , defaults: Nothing
        , example: Nothing
        , path: Nothing
        , safe: Nothing
        }
  let
    url = fromMaybe "" $ Map.lookup "APP_URL" $ e

    handler = makeHandler url
  listener <- Deno.listen { port: 3001 }
  launchAff_ $ serveListener listener handler Nothing

makeHandler :: String -> Handler
makeHandler baseUrl req =
  let
    path = replace (Pattern baseUrl) (Replacement "") $ Request.url req
  in
    router path req

router :: String -> Handler
router "/" = indexRoute

router "/example-api" = jsonEcho

router _ = \_req -> pure $ createResponse "Fallthrough!" Nothing

indexRoute :: Request → Aff Response
indexRoute _req =
  let
    payload =
      """
    <html>
      <head></head>
      <body>
        <div>
          Hello World!
        </div>
      </body>
    </html>
    """

    headers = Just $ Map.fromFoldable [ hContentTypeHtml ]

    response_options = Just { headers, status: Nothing, statusText: Nothing }
  in
    pure $ createResponse payload response_options

jsonEcho :: Request → Aff Response
jsonEcho req = do
  payload <- Request.json req
  let
    headers = Just $ Map.fromFoldable [ hContentTypeJson ]

    response_options = Just { headers, status: Nothing, statusText: Nothing }
  pure $ createResponse (stringify payload) response_options

```

## Step 2.
```sh
spago build
```

## Step 3.
```sh
deno eval 'import { main } from "./output/Main/index.js"; main();'
```

## Step 4.
Go to http://localhost:3001
