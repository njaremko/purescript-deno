module Deno.DateTime
  ( Date
  , DifferenceOptions
  , DifferenceUnit
  , difference
  , differenceUnitToString
  , format
  , isLeap
  , parse
  , parseDifferenceUnit
  , toIMF
  , weekOfYear
  ) where

import Prelude
import Data.Array as Array
import Data.Map (Map)
import Data.Map as Map
import Data.Maybe (Maybe(..))
import Data.Tuple (Tuple(..))
import Deno.Internal (Undefined, maybeToUndefined)

foreign import data Date :: Type

foreign import parse :: String -> String -> Date

foreign import format :: Date -> String -> String

foreign import isLeap :: Date -> Boolean

foreign import toIMF :: Date -> String

foreign import weekOfYear :: Date -> Int

newtype InternalDifferenceUnit
  = InternalDifferenceUnit String

derive instance differenceUnitEq :: Eq DifferenceUnit

derive instance differenceUnitOrd :: Ord DifferenceUnit

data DifferenceUnit
  = Milliseconds
  | Seconds
  | Minutes
  | Hours
  | Days
  | Weeks
  | Months
  | Quarters
  | Years

differenceUnitToString :: DifferenceUnit -> String
differenceUnitToString Milliseconds = "milliseconds"

differenceUnitToString Seconds = "seconds"

differenceUnitToString Minutes = "minutes"

differenceUnitToString Hours = "hours"

differenceUnitToString Days = "days"

differenceUnitToString Weeks = "weeks"

differenceUnitToString Months = "months"

differenceUnitToString Quarters = "quarters"

differenceUnitToString Years = "years"

parseDifferenceUnit :: String -> Maybe DifferenceUnit
parseDifferenceUnit "milliseconds" = Just Milliseconds

parseDifferenceUnit "seconds" = Just Seconds

parseDifferenceUnit "minutes" = Just Minutes

parseDifferenceUnit "hours" = Just Hours

parseDifferenceUnit "days" = Just Days

parseDifferenceUnit "weeks" = Just Weeks

parseDifferenceUnit "months" = Just Months

parseDifferenceUnit "quarters" = Just Quarters

parseDifferenceUnit "years" = Just Years

parseDifferenceUnit _ = Nothing

type DifferenceOptions
  = { units :: Maybe (Array DifferenceUnit)
    }

type DifferenceOptions'
  = { units :: Undefined (Array String)
    }

foreign import _difference :: Date -> Date -> Undefined DifferenceOptions' -> Array (Tuple String Int)

difference :: Date -> Date -> Maybe DifferenceOptions -> Map DifferenceUnit Int
difference from to opts =
  Map.fromFoldable
    $ Array.mapMaybe (\(Tuple k v) -> map (\parsedKey -> Tuple parsedKey v) $ parseDifferenceUnit k)
    $ _difference from to (maybeToUndefined (map toInternalDifferenceOptions opts))
  where
  toInternalDifferenceOptions :: DifferenceOptions -> DifferenceOptions'
  toInternalDifferenceOptions o = { units: maybeToUndefined $ map (map differenceUnitToString) o.units }
