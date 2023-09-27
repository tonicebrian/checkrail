module Checkrail where

import Checkrail.Client
import Checkrail.Extractor
import Checkrail.Purescript (generatePurescriptClient)
import Control.Lens
import Data.Aeson qualified as Aeson
import Data.Either.Combinators (eitherToError, mapLeft)
import Data.OpenApi
import Data.Text.IO as T
import Data.Yaml qualified as Yaml
import System.FilePath
import Prelude

data FileFormat
  = Yaml
  | JSON
  deriving (Show, Read, Enum, Bounded)

data Target
  = ClientStub
  | ServerStub
  deriving (Show, Read, Enum, Bounded)

data Language
  = Haskell
  | Purescript
  deriving (Show, Read, Enum, Bounded)

generate :: FilePath -> FileFormat -> Language -> IO ()
generate openApiFile fileFormat lang = do
  parsedOpenApi <- case fileFormat of
    JSON -> (Aeson.eitherDecodeFileStrict openApiFile :: IO (Either String OpenApi))
    Yaml -> (Yaml.decodeFileEither openApiFile :: IO (Either Yaml.ParseException OpenApi)) <&> mapLeft show
  openApi <- eitherToError (mapLeft userError parsedOpenApi)
  let client = mkClient openApi
  case lang of
    Haskell -> generateHaskell client
    Purescript -> T.putStrLn (generatePurescriptClient client)

generateHaskell :: Client -> IO ()
generateHaskell _ = error "Not implemented yet"
