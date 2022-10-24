{-# LANGUAGE PartialTypeSignatures #-}

module Checkrail.Purescript (generatePurescript) where

import Checkrail.Client
import Checkrail.Purescript.Render
import Control.Lens
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
            returnType = ""
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

processFilePath :: FilePath -> [Referenced Param] -> String
processFilePath fp params = unlines . map show $ pathParams
  where
    -- TODO. We are missing params that are referenced
    pathParams = params ^.. traverse . _Inline . filteredBy (in_ . filtered (== ParamPath))

getAllParams :: Lens' PathItem (Maybe Operation) -> Reader PathItem [Referenced Param]
getAllParams op = do
  piParams <- view parameters
  magnify (op . _Just . parameters) $ do
    opParams <- ask
    return $ piParams <> opParams
