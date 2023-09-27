module Checkrail.Fixture
  ( theClient,
    theModuleName,
  )
where

import Checkrail.Client
import Data.Text as T

theModuleName :: Text
theModuleName = "SimplePetStore"

theClient :: Client
theClient = Client theModuleName [Operation "/pet/findByStatus"] []
