-- |
module Checkrail.Extractor (extractPathParams) where

import qualified Checkrail.Client as C
import Control.Lens
import Control.Monad.Reader
import Data.OpenApi
import System.FilePath
import Prelude

extractPathParams :: PathItem -> Operation -> [C.PathParam]
extractPathParams pi op = map (\n -> C.PathParam n "String") names
  where
    pathParams :: [Param]
    pathParams = ((pi ^. parameters) <> (op ^. parameters)) ^.. traverse . _Inline . filteredBy (in_ . filtered (== ParamPath))

    names = pathParams ^.. folded . name

getAllParams :: Lens' PathItem (Maybe Operation) -> Reader PathItem [Referenced Param]
getAllParams op = do
  piParams <- view parameters
  magnify (op . _Just . parameters) $ do
    opParams <- ask
    return $ piParams <> opParams
