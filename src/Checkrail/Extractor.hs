-- | Helper module to assemble cohesive pieces of information from OpenApi
module Checkrail.Extractor where

import qualified Checkrail.Client as C
import Control.Lens
import Control.Monad.Reader
import Data.HashMap.Strict.InsOrd (hashMap)
import Data.OpenApi
import Data.Text (Text)
import qualified Data.Text as T
import System.FilePath
import Prelude
