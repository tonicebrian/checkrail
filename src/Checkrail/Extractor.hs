-- | Helper module to assemble cohesive pieces of information from OpenApi
module Checkrail.Extractor where

-- Comented so we can start easy
--  ( mkClient,
--    mkServer,
--  )

import Checkrail.Client as C
import Control.Lens
import Control.Monad.Reader
import Data.Maybe
import Data.OpenApi
import Data.Text as T
import Prelude

mkClient :: ModuleName -> OpenApi -> Client
mkClient mn oa = Client mn operations definitions
  where
    operations = fmap (\(k, _) -> C.Operation (T.pack k)) apiPaths
    definitions = []
    apiPaths = oa ^@.. paths . itraversed

mkServer :: OpenApi -> Server
mkServer = undefined

class Monoid a => HasDefinitions a where
  definitionsL :: Lens' Components (Definitions a)

instance HasDefinitions Param where
  definitionsL = parameters

instance HasDefinitions Schema where
  definitionsL = schemas

getReferenced :: (HasDefinitions a) => OpenApi -> Referenced a -> a
getReferenced _ (Inline v) = v
getReferenced oa (Ref (Reference idx)) = oa ^. components . definitionsL . ix idx

extractUrlParamTypes :: OpenApi -> [Referenced Param] -> [(OpenApiType, Bool)]
extractUrlParamTypes oa params =
  mapMaybe
    ( \ps ->
        (,) <$> ps ^? typeLens <*> _paramRequired ps
    )
    pathParamsSchemas
  where
    typeLens = schema . _Just . to (getReferenced oa) . type_ . _Just
    pathParamsSchemas :: [Param]
    pathParamsSchemas =
      params
        ^.. folded
          . to (getReferenced oa)
          . filteredBy (in_ . filtered (\pt -> pt == ParamPath || pt == ParamQuery))

componentExtractor :: Reader Components [[Text]]
componentExtractor = do
  magnify schemas processSchema

processSchema :: Reader (Definitions Schema) [[Text]]
processSchema = return []
