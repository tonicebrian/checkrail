module Main where

import Checkrails
import Prelude

main :: IO ()
main = do
  generate "openapi.yaml" Purescript
