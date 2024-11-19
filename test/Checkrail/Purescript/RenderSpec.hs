module Checkrail.Purescript.RenderSpec where

import Checkrail.Fixture
import Checkrail.Purescript (generatePurescriptClient)
import Checkrail.Utils (goldenTextFile)
import Relude
import Test.Hspec

spec :: Spec
spec = describe "When rendering a client" $ do
  it "we get the right code output" $ do
    goldenTextFile "SimplePetStore.purs" (generatePurescriptClient theModuleName theClient)
