{-# LANGUAGE PartialTypeSignatures #-}

module Checkrail.Purescript (generatePurescript, builder) where

import Checkrail.Client
import Checkrail.Purescript.Render
import Control.Lens
import Control.Monad (sequence)
import Control.Monad.Reader
import Data.Aeson
import Data.HashMap.Strict.InsOrd (hashMap)
import Data.Maybe
import Data.OpenApi
import Data.Text (Text)
import qualified Data.Text as T
import qualified Data.Text.IO as T
import Data.Typeable (typeOf)
import Text.Pretty.Simple
import Prelude

generatePurescript :: OpenApi -> IO ()
generatePurescript = mapM_ T.putStrLn . builder

builder :: OpenApi -> [Text]
builder oa = concat $ concatMap (runReader extractor) pathItems
  where
    pathItems = oa ^@.. paths . hashMap . itraversed

    --extractReferences :: Reader OpenApi (Map Text Schema)
    --extractReferences = do
    --  magnify (components . schemas)
    extractor :: Reader (FilePath, PathItem) [[Text]]
    extractor = do
      (fp, pi) <- ask
      piParams <- view (_2 . parameters)
      let operations = [get, put, post, delete]
      forM operations $ \op ->
        magnify (_2 . op . _Just) $ do
          opParams <- view parameters
          -- let pathParams = (piParams <> opParams) ^.. folded . in_ . filtered (== ParamPath)
          return ["Hola"]
