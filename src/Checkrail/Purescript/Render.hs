{-# LANGUAGE QuasiQuotes #-}

module Checkrail.Purescript.Render (renderClient) where

import Checkrail.Client
import Data.Text (Text)
import qualified Data.Text as T
import Text.Shakespeare.Text
import Prelude

renderClient Client {..} = qq
  where
    qq =
      let bar = 23 :: Int
       in [st|
#{clientOperationId} :: MonadAff m => Text -> Text -> m ()
                                   |]
