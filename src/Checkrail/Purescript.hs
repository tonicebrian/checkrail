{-# LANGUAGE OverloadedStrings #-}

module Checkrail.Purescript (generatePurescriptClient) where

import Checkrail.Client
import Relude
import Text.EDE

generatePurescriptClient :: ModuleName -> Client -> IO Text
generatePurescriptClient mn _ = do
  r <- eitherParseFile "src/Checkrail/Purescript/client.ede"
  either (error . toText) (pure . toText) $ r >>= (`eitherRender` env)
  where
    env =
      fromPairs
        [ "moduleName" .= mn,
          "imports"
            .= fromPairs
              [ "import1" .= ("foo" :: String),
                "import2" .= ("bar" :: String)
              ]
        ]
