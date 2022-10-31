{-# LANGUAGE QuasiQuotes #-}

module Checkrail.Purescript.Render where

import Checkrail.Client
import Control.Lens
import Data.OpenApi
import Data.Text (Text)
import qualified Data.Text as T
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
          other -> error "Invalid type in a param. Can't generate code"
