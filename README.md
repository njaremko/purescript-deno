# purescript-deno

Deno bindings for Purescript

Implemented:
- [ ] [Std](https://deno.land/std@0.144.0)
  - [x] http 
  - [x] dotenv


# Example Deno web server

## Step 1. Make a `main.purs`
```purescript
module Main
  ( main
  ) where

import Prelude

import Data.Argonaut (stringify)
import Data.Map as Map
import Data.Maybe (Maybe(..))
import Data.String (Replacement(..), Pattern(..), replace)
import Deno as Deno
import Deno.Http (Handler, Response, createResponse, hContentTypeHtml, hContentTypeJson, serveListener)
import Deno.Http.Request (Request)
import Deno.Http.Request as Request
import Effect (Effect)
import Effect.Aff (Aff, launchAff_)
import Effect.Console (log)

main :: Effect Unit
main = do
  log "Let's get cookin 🍝"
  listener <- Deno.listen { port: 3001 }
  launchAff_ $ serveListener listener handler Nothing

handler :: Handler
handler req =
  let
    path = replace (Pattern "http://localhost:3001") (Replacement "") $ Request.url req
  in
    router path req

router :: String -> Request -> Aff Response
router "/" _ =
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

router "/example-api" req = do
  payload <- Request.json req
  let
    headers = Just $ Map.fromFoldable [ hContentTypeJson ]

    response_options = Just { headers, status: Nothing, statusText: Nothing }
  pure $ createResponse (stringify payload) response_options

router _ _ = pure $ createResponse "Fallthrough!" Nothing


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
