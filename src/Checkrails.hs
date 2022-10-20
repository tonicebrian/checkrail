-- |
module Checkrails where

import Control.Lens
import qualified Data.Aeson as Aeson
import Data.Either.Combinators (mapLeft)
import Data.OpenApi
import qualified Data.Yaml as Yaml
import System.FilePath
import Text.Pretty.Simple
import Prelude

data FileFormat
  = Yaml
  | JSON
  deriving (Show, Read, Enum, Bounded)

data Language
  = Haskell
  | Purescript
  deriving (Show, Read, Enum, Bounded)

generate :: FilePath -> FileFormat -> Language -> IO ()
generate openApiFile fileFormat lang = do
  openApi <- case fileFormat of
    JSON -> (Aeson.eitherDecodeFileStrict openApiFile :: IO (Either String OpenApi))
    Yaml -> (Yaml.decodeFileEither openApiFile :: IO (Either Yaml.ParseException OpenApi)) <&> mapLeft show
  putStrLn "El resultado es:"
  case openApi of
    Right oa -> case lang of
      Haskell -> generateHaskell oa
      Purescript -> generatePurescript oa
    Left e -> pPrint e

generateHaskell :: OpenApi -> IO ()
generateHaskell _ = putStrLn "Parsed correctly"

generatePurescript :: OpenApi -> IO ()
generatePurescript _ = putStrLn "Parsed correctly"
