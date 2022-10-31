-- | Helper module to assemble cohesive pieces of information from OpenApi
module Checkrail.Extractor where

import Control.Lens
import Data.Maybe
import Data.OpenApi
import Prelude

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
