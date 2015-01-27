{- git-annex difference log, pure functions
 -
 - Copyright 2015 Joey Hess <id@joeyh.name>
 -
 - Licensed under the GNU GPL version 3 or higher.
 -}

module Logs.Difference.Pure (
	allDifferences,
	parseDifferencesLog,
) where

import Data.Monoid
import qualified Data.Map as M

import Common.Annex
import Types.Difference
import Logs.UUIDBased

parseDifferencesLog :: String -> (M.Map UUID Differences)
parseDifferencesLog = simpleMap 
	. parseLog (Just . fromMaybe UnknownDifferences . readish)

-- The sum of all recorded differences, across all UUIDs.
allDifferences :: M.Map UUID Differences -> Differences
allDifferences = mconcat . M.elems
