module Checkrail.ExtractorSpec where

import Checkrail.Client
import Checkrail.Extractor
import Checkrail.Utils
import Test.Syd
import Prelude

spec :: Spec
spec = beforeAll readOpenApi $ do
  describe "Directly working on the OpenApi data structure" $ do
    itWithOuter "we can construct a client from the openapi file" $ \oa -> do
      mkClient oa
        `shouldBe` [ Operation "/pet/findByStatus"
                   ]
