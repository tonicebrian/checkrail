module Checkrail.ExtractorSpec where

import Checkrail.Extractor
import Checkrail.Fixture
import Checkrail.Utils
import Test.Syd
import Prelude

spec :: Spec
spec = beforeAll readOpenApi $ do
  describe "Directly working on the OpenApi data structure" $ do
    itWithOuter "we can construct a client from the openapi file" $ \oa -> do
      mkClient moduleName oa `shouldBe` theClient
