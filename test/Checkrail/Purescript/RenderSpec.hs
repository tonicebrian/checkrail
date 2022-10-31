-- |
module Checkrail.Purescript.RenderSpec where

import Checkrail.Client
import Checkrail.Extractor
import Checkrail.Purescript.Render
import Checkrail.Utils
import Control.Lens
import Data.Either.Combinators
import Data.HashMap.Strict.InsOrd (hashMap)
import Data.OpenApi
import Data.Yaml as Yaml
import Test.Syd
import Prelude

spec :: Spec
spec = beforeAll readOpenApi $ do
  describe "When rendering an endpoint client" $ do
    itWithOuter "we get the right function signature" $ \oa ->
      let pathParams = oa ^. paths . hashMap . traverse . get . _Just . parameters
          types = extractUrlParamTypes oa pathParams
       in (renderSignature "findPetByStatus" types "FindPetByStatusResponse")
            `shouldBe` "findPetByStatus :: MonadAff m => Maybe String -> m FindPetByStatusResponse"
