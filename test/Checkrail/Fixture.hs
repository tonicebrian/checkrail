module Checkrail.Fixture
  ( theClient,
    theModuleName,
  )
where

import Checkrail.Client
import Data.Text as T
import Prelude

theModuleName :: Text
theModuleName = "SimplePetStore"

theClient :: Client
theClient = Client theModuleName operations definitions
  where
    operations = [Operation "/pet/findByStatus"]
    definitions =
      [ Definition
          { name = "Tag",
            fields =
              [ Field {name = "name", required = False},
                Field {name = "id", required = False}
              ]
          }
      ]
