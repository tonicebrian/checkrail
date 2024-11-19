module Checkrail.Fixture
  ( theClient,
    theModuleName,
    readOpenApi,
  )
where

import Checkrail.Client
import Data.Either.Combinators
import Data.OpenApi qualified as OA
import Data.Text as T
import Data.Yaml as Yaml
import Prelude

readOpenApi :: IO OA.OpenApi
readOpenApi = do
  eitherOpenapi <- Yaml.decodeFileEither "test/resources/simple-petstore.yaml" :: IO (Either Yaml.ParseException OA.OpenApi)
  return (fromRight' eitherOpenapi)

theModuleName :: Text
theModuleName = "SimplePetStore"

theClient :: Client
theClient = Client theModuleName operations definitions
  where
    operations = [Operation "/pet/findByStatus"]
    definitions =
      [ Definition
          { name = "Tag",
            fields =
              [ Field {name = "id", required = False},
                Field {name = "name", required = False}
              ]
          }
      ]
