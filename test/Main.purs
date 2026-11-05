module Test.Main where

import Prelude
import Data.Map as Map
import Data.Maybe (Maybe(..), isJust, isNothing)
import Deno as Deno
import Deno.DateTime as DateTime
import Deno.Uuid.V4 as UUID
import Effect (Effect)
import Test.Assert (assert, assertEqual)

main :: Effect Unit
main = do
  assertEqual { actual: Map.lookup "PURESCRIPT_DENO_TEST" Deno.env, expected: Just "runtime-fixture" }
  assert $ isJust $ UUID.validate "550e8400-e29b-41d4-a716-446655440000"
  assert $ isNothing $ UUID.validate "not-a-uuid"
  assert $ isNothing $ UUID.validate "6ba7b810-9dad-11d1-80b4-00c04fd430c8"
  let
    leapDay = DateTime.parse "2024-02-29" "yyyy-MM-dd"
    ordinaryDay = DateTime.parse "2023-03-01" "yyyy-MM-dd"
  assertEqual { actual: DateTime.format leapDay "dd/MM/yyyy", expected: "29/02/2024" }
  assert $ DateTime.isLeap leapDay
  assert $ not $ DateTime.isLeap ordinaryDay
