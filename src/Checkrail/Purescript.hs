{-# LANGUAGE PartialTypeSignatures #-}

module Checkrail.Purescript (generatePurescript, builder) where

import Checkrail.Extractor
import Checkrail.Purescript.Render
import Control.Lens
import Control.Monad.Reader
import Data.HashMap.Strict.InsOrd (hashMap)
import Data.OpenApi
import Data.Text (Text)
import qualified Data.Text.IO as T
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
      forM operations $ \httpOp ->
        magnify (_2 . httpOp . _Just) $ do
          opParams <- view parameters
          return [renderParamsPathSignature (extractUrlParamTypes oa (piParams <> opParams))]
