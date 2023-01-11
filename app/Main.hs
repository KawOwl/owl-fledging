module Main where

import qualified MyLib (someFunc)
import LibB
import Rules

main :: IO ()
main = do
  print $ length $ lines LibB.pyRulesString
  print $ length LibB.inferRules
  print $ unlines LibB.additional
  hc <- Rules.harContent
  hf <- Rules.harFile
  print hc
  -- print hf