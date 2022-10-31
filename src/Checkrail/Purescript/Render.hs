{-# LANGUAGE QuasiQuotes #-}

module Checkrail.Purescript.Render where

import Checkrail.Client
import Control.Lens
import Data.OpenApi
import Data.Text (Text)
import qualified Data.Text as T
import Text.Shakespeare.Text
import Prelude

renderSignature Client {..} =
  [st|#{clientOperationId} :: MonadAff m => String -> String -> m #{returnType}|]

renderFunctionAndParams Client {..} =
  [st|#{clientOperationId} $forall param <- params
      name param|]

renderClient = renderSignature

renderParams :: [Param] -> Text
renderParams params = T.pack . show $ params ^.. traversed . schema . _Just . _Inline . type_ . _Just . to renderType
  where
    renderType :: OpenApiType -> Text
    renderType = \case
      OpenApiString -> "String"
      OpenApiNumber -> "Number"
      OpenApiInteger -> "Int"
      OpenApiBoolean -> "Boolean"
      other -> error "Invalid type in a param. Can't generate code"
