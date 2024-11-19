module Checkrail.ExtractorSpec where

import Checkrail.Extractor
import Checkrail.Fixture
import Test.Hspec
import Prelude

spec :: Spec
spec = beforeAll readOpenApi $ do
  describe "Directly working on the OpenApi data structure" $ do
    it "we can construct a client from the openapi file" $ \oa -> do
      mkClient theModuleName oa `shouldBe` theClient
