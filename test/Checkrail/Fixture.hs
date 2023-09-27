module Checkrail.Fixture where

import Checkrail.Client
import Data.Text as T

theClient :: Client
theClient = Client "SimplePetStore" [Operation "/pet/findByStatus"]

moduleName :: Text
moduleName = "SimplePetStore"
