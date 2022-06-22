module Main where

import Prelude
import Data.Argonaut (encodeJson, stringify)
import Data.Map as Map
import Data.Maybe (Maybe(..))
import Data.Tuple (Tuple(..))
import Deno.Http (createResponse, serve)
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
    payload = { error: "🍝" }
  let
    headers = Map.fromFoldable [ Tuple "content-type" "application/json" ]
  launchAff_ $ serve (\_req -> createResponse (stringify $ encodeJson payload) (Just { headers: Just headers, status: Nothing, statusText: Nothing })) Nothing
