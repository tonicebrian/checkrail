{-# LANGUAGE PartialTypeSignatures #-}

module Checkrail.Purescript (generatePurescript, builder) where

import Checkrail.Client
import Checkrail.Purescript.Render
import Control.Lens
import Control.Lens (Magnify (magnify))
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
generatePurescript oa = do
  let pathItems = oa ^@.. paths . hashMap . itraversed
      clients = concatMap clientBuilder pathItems
  mapM_ (T.putStrLn . renderClient) clients

clientBuilder :: (FilePath, PathItem) -> [Client]
clientBuilder (fp, pi) =
  map
    ( \(v, o) ->
        Client
          { clientOperationId = o ^. operationId . _Just,
            templatedFilePath = fp,
            returnType = "",
            paramsInPath = []
          }
    )
    (catMaybes operations)
  where
    operations =
      map
        (\(verb, l) -> fmap (verb,) (pi ^. l . filteredBy (_Just . operationId)))
        [ ("get", get),
          ("post", post),
          ("put", put),
          ("delete", delete)
        ]

    --selector :: ToJSON a => Reader a (HttpAction a)
    selector = undefined

builder ::  OpenApi ->  [Text]
builder oa = concatMap (runReader extractor) pathItems
  where 
    pathItems = oa ^@.. paths . hashMap . itraversed

    extractor :: Reader (FilePath, PathItem) [Text]
    extractor = do 
      (fp, pi) <- ask
      getRes <- magnify (_2 . get) $ do 
        return ["Hoolas"]
      magnify (_2 . get) $ do 
        return $ getRes <> ["Hoolas Segundas"]
