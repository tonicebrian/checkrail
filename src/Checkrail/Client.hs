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

data PathParam = PathParam
  { name :: !Text,
    kind :: !Text
  }
  deriving (Show, Eq)

data Client = Client
  { clientOperationId :: !Text,
    templatedFilePath :: !FilePath,
    returnType :: !Text,
    paramsInPath :: ![PathParam]
  }
  deriving (Show)
