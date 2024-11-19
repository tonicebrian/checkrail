module Checkrail.Purescript.RenderSpec where

import Checkrail.Fixture
import Checkrail.Purescript (generatePurescriptClient)
import Checkrail.Utils (pureGoldenTextFile)
import Test.Hspec
import Prelude

spec :: Spec
spec = describe "When rendering a client" $ do
  it "we get the right code output" $ do
    let obtained = generatePurescriptClient theModuleName theClient
    pureGoldenTextFile "SimplePetStore.purs" obtained
