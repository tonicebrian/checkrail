-- |
module Checkrail.ExtractorSpec where

import Checkrail.Extractor
import Checkrail.Purescript (builder)
import Control.Lens
import Control.Monad.Reader
import Data.Either.Combinators (fromRight')
import Data.HashMap.Strict.InsOrd (hashMap)
import Data.OpenApi
import Data.Yaml as Yaml
import Test.Syd
import Text.Pretty.Simple
import Prelude

readOpenApi :: IO OpenApi
readOpenApi = do
  eitherOpenapi <- Yaml.decodeFileEither "test/resources/simple-petstore.yaml" :: IO (Either Yaml.ParseException OpenApi)
  return (fromRight' eitherOpenapi)

spec :: Spec
spec = beforeAll readOpenApi $ do
  describe "From a PathItem element" $ do
    pending "we can extract all path params "
  describe "Directly working on the OpenApi data structure" $ do
    itWithOuter "we can extract all path params " $ \oa -> do
      pPrint (oa ^.. components . schemas)
      builder oa `shouldBe` []
