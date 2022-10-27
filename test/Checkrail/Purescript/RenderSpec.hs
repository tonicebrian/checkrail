-- |
module Checkrail.Purescript.RenderSpec where

import Checkrail.Client
import Checkrail.Purescript.Render
import Test.Syd
import Prelude

petStoreClient :: Client
petStoreClient =
  Client
    { clientOperationId = "findPetsByStatus",
      templatedFilePath = "",
      returnType = "FindPetsByStatusResponse",
      paramsInPath = []
    }

spec :: Spec
spec = describe "When rendering an endpoint client" $ do
  it "we get a valid header" $ do
    renderSignature petStoreClient
      `shouldBe` "findPetsByStatus :: MonadAff m => String -> m FindPetsByStatusResponse"

  it "gets proper parameter names with the signature" $ do
    renderFunctionAndParams petStoreClient
      `shouldBe` "findPetsByStatus status"
