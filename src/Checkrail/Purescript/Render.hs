{-# LANGUAGE QuasiQuotes #-}

module Checkrail.Purescript.Render where

import Checkrail.Client
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
