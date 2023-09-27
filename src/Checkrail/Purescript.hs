{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}

module Checkrail.Purescript (generatePurescriptClient) where

import Checkrail.Client
import Data.Text as T
import Text.Shakespeare.Text

generatePurescriptClient :: ModuleName -> Client -> Text
generatePurescriptClient mn _ =
  T.intercalate
    "\n"
    [ renderModule mn,
      renderImports,
      "-- EOF",
      ""
    ]

renderModule :: Text -> Text
renderModule moduleName =
  [st|module #{moduleName} where|]

renderImports :: Text
renderImports =
  [st|
import Prelude
|]
