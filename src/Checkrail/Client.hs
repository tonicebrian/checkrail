{-# LANGUAGE DuplicateRecordFields #-}

module Checkrail.Client where

import Data.Text
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

data Operation = Operation
  { clientOperationId :: !Text
  }
  deriving (Show, Eq)

type ModuleName = Text

data Field = Field
  { name :: Text,
    required :: Bool
  }
  deriving (Show, Eq)

newtype Definition = Definition Field
  deriving (Show, Eq)

data Client = Client
  { moduleName :: ModuleName,
    operations :: [Operation],
    definitions :: [Definition]
  }
  deriving (Show, Eq)
