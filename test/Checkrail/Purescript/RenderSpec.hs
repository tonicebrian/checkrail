-- |
module Checkrail.Purescript.RenderSpec where

import Checkrail.Client
import Checkrail.Purescript.Render
import Data.Either.Combinators
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
  describe "When rendering an endpoint client" $ do
    pending "we get all"
