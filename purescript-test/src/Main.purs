module Main
  ( Category
  , FindPetsByStatusResponse(..)
  , Pet
  , Tag
  , main
  ) where

import Prelude
import Affjax (printError)
import Affjax.Node as AN
import Affjax.ResponseFormat as RF
import Affjax.StatusCode as SC
import Data.Argonaut (JsonDecodeError)
import Data.Argonaut.Decode (decodeJson)
import Data.Either (Either(..))
import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Aff.Class (class MonadAff)
import Effect.Class (liftEffect)
import Effect.Console (log)
import Data.Maybe

type Category
  = { id :: Maybe Int
    , name :: Maybe String
    }

type Tag
  = { id :: Maybe Int
    , name :: Maybe String
    }

type Pet
  = { id :: Maybe Int
    , name :: String
    , category :: Maybe Category
    , photoUrls :: Array String
    , tags :: Maybe (Array Tag)
    , status :: Maybe String
    }

data FindPetsByStatusResponse
  = Ok (Array Pet)
  | BadRequest

findPetById :: forall m. MonadAff m => String -> m FindPetsByStatusResponse
findPetById status = pure BadRequest

main :: Effect Unit
main = do
  log "Hoooolas"
  launchAff_ do
    result <- AN.get RF.json "https://petstore3.swagger.io/api/v3/pet/findByStatus?status=available"
    liftEffect
      $ case result of
          Right resp -> case resp.status of
            SC.StatusCode 200 -> case decodeJson resp.body :: Either JsonDecodeError (Array Pet) of
              Right pets -> log "Decodificado perfectamente"
              Left error -> log $ "There was an error " <> show error
            SC.StatusCode 404 -> log $ "Something went wrong"
            statusCode -> log $ "Completely unexpected resul " <> show statusCode
          Left error -> log $ printError error
