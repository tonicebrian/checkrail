module Checkrail.Purescript.RenderSpec where

import Checkrail.Fixture
import Checkrail.Purescript (generatePurescriptClient)
import Test.Syd
import Prelude

spec :: Spec
spec = describe "When rendering a client" $ do
  it "we get the right code output" $ do
    let obtained = generatePurescriptClient moduleName theClient
    pureGoldenTextFile "test/resources/purescript/src/SimplePetStore.purs" obtained
