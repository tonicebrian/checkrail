-- |
module Checkrail.Utils where

import Data.Either.Combinators (fromRight')
import Data.OpenApi
import Data.Yaml as Yaml
import Prelude

readOpenApi :: IO OpenApi
readOpenApi = do
  eitherOpenapi <- Yaml.decodeFileEither "test/resources/simple-petstore.yaml" :: IO (Either Yaml.ParseException OpenApi)
  return (fromRight' eitherOpenapi)
