module Main where

import Prelude
import Data.Argonaut (encodeJson, stringify)
import Data.Map as Map
import Data.Maybe (Maybe(..))
import Data.Tuple (Tuple(..))
import Deno as Deno
import Deno.Http (createResponse, hContentTypeHtml, hContentTypeJson, serveListener)
import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Console (log)

type Resp
  = { error :: String
    }

main :: Effect Unit
main = do
  log "🍝"
  let
    payload = "<html><head></head><body><div>Hello World!</div></body></html>"

    headers = Just $ Map.fromFoldable [ hContentTypeJson ]

    response_options = Just { headers, status: Nothing, statusText: Nothing }
  listener <- Deno.listen { port: 3001 }
  launchAff_ $ serveListener listener (\_req -> createResponse payload response_options) Nothing
