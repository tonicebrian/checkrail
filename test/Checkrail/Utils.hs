module Checkrail.Utils (pureGoldenTextFile) where

import Data.Text.IO as TIO
import Relude
import Test.Hspec.Golden

pureGoldenTextFile :: FilePath -> Text -> Golden Text
pureGoldenTextFile name expected =
  Golden
    { output = expected,
      encodePretty = show,
      writeToFile = TIO.writeFile,
      readFromFile = TIO.readFile,
      goldenFile = "test/resources/golden/" <> name,
      actualFile = Just ("test/resources/golden/" <> name),
      failFirstTime = False
    }
