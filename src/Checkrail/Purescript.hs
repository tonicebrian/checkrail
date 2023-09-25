{-# LANGUAGE PartialTypeSignatures #-}

module Checkrail.Purescript (generatePurescript) where

import Checkrail.Client
import Prelude

generatePurescript :: Client -> IO ()
generatePurescript = undefined -- mapM_ T.putStrLn . builder

-- builder :: Client -> [Text]
-- builder oa = concat $ concatMap (runReader extractor) pathItems
--   where
--     pathItems = oa ^@.. paths . hashMap . itraversed
--
--     -- extractReferences :: Reader OpenApi (Map Text Schema)
--     -- extractReferences = do
--     --  magnify (components . schemas)
--     extractor :: Reader (FilePath, PathItem) [[Text]]
--     extractor = do
--       (_, _) <- ask
--       piParams <- view (_2 . parameters)
--       let operations = [get, put, post, delete]
--       forM operations $ \httpOp ->
--         magnify (_2 . httpOp . _Just) $ do
--           opParams <- view parameters
--           return [renderParamsPathSignature (extractUrlParamTypes oa (piParams <> opParams))]
