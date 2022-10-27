-- |
module Checkrail.ExtractorSpec where

import Checkrail.Extractor
import Checkrail.Extractor (extractPathParams)
import Checkrail.Purescript (builder)
import Control.Lens
import Control.Monad.Reader
import Data.Either.Combinators (fromRight')
import Data.HashMap.Strict.InsOrd (hashMap)
import Data.OpenApi
import Data.Yaml as Yaml
import Test.Syd
import Prelude

readOpenApi :: IO OpenApi
readOpenApi = do
  eitherOpenapi <- Yaml.decodeFileEither "test/resources/simple-petstore.yaml" :: IO (Either Yaml.ParseException OpenApi)
  return (fromRight' eitherOpenapi)

spec :: Spec
spec = beforeAll readOpenApi $ do
  describe "From a PathItem element" $
    do
      itWithOuter "we can extract all path params " $ \oa -> do
        let pi = head $ oa ^.. paths . hashMap . traversed
            op = pi ^. get . _Just
        extractPathParams pi op `shouldBe` []
  describe "Directly working on the OpenApi data structure" $ do
    itWithOuter "we can extract all path params " $ \oa -> do
      builder oa `shouldBe` []
