module Checkrail.Client where

import Data.Text
import System.FilePath
import Prelude

data PathSegment
  = Segment Text
  | Variable

data HttpAction a
  = Get
  | Post a
  | Put a
  | Delete

data Client = Client
  { clientOperationId :: !Text,
    templatedFilePath :: !FilePath,
    returnType :: !Text
  }
  deriving (Show)
