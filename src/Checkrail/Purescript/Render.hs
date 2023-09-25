{-# LANGUAGE QuasiQuotes #-}

module Checkrail.Purescript.Render where

import Data.OpenApi
import Data.Text (Text)
import Data.Text qualified as T
import Text.Shakespeare.Text
import Prelude

renderSignature :: Text -> [(OpenApiType, Bool)] -> Text -> Text
renderSignature cOperationId cParams returnType =
  [st|#{cOperationId} :: MonadAff m => #{renderParamsPathSignature cParams} -> m #{returnType}|]

renderParamsPathSignature :: [(OpenApiType, Bool)] -> Text
renderParamsPathSignature params = T.intercalate " -> " (map renderType params)
  where
    renderType :: (OpenApiType, Bool) -> Text
    renderType (kind, isRequired) = (if isRequired then "" else "Maybe ") <> mapTypes kind
      where
        mapTypes = \case
          OpenApiString -> "String"
          OpenApiNumber -> "Number"
          OpenApiInteger -> "Int"
          OpenApiBoolean -> "Boolean"
          _ -> error "Invalid type in a param. Can't generate code"
