module SimplePetStore where

import Prelude
import Effect (Effect)
import Effect.Console (log)
import Affjax (get, Response)
import Affjax.RequestHeader (RequestHeader)
import Data.Argonaut
import Data.Either (Either(..))
import Effect.Aff (launchAff)
import Affjax.ResponseFormat
