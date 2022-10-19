-- |
module Checkrails where

import Control.Lens
import Data.OpenApi
import qualified Data.Yaml as Y
import System.Environment
import System.FilePath
import Text.Pretty.Simple
import Prelude

data Language
  = Haskell
  | Purescript

generate :: FilePath -> Language -> IO ()
generate openApiFile lang = do
  args <- getArgs
  openApi <- Y.decodeFileThrow openApiFile :: IO OpenApi
  mapM_ pPrint (openApi ^.. paths)
