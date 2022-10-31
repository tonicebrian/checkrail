-- |
module Checkrail.ExtractorSpec where

import Checkrail.Extractor
import Checkrail.Utils
import Control.Lens
import Data.HashMap.Strict.InsOrd (hashMap)
import Data.OpenApi
import Test.Syd
import Prelude

spec :: Spec
spec = beforeAll readOpenApi $ do
  describe "From a PathItem element" $ do
    pending "we can extract all path params "
  describe "Directly working on the OpenApi data structure" $ do
    itWithOuter "we can extract all path params " $ \oa -> do
      let pathParams = oa ^. paths . hashMap . traverse . get . _Just . parameters
      extractUrlParamTypes oa pathParams `shouldBe` [(OpenApiString, False)]
