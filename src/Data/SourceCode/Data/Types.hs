{-# LANGUAGE TemplateHaskell #-}
module Data.SourceCode.Data.Types where

import Control.Lens
import Data.SPL
import System.IO

type Tag     = String

type Component = (Tag, [FilePath])

data ComponentModel = ComponentModel {
  _components         :: [Component], -- initiate with parserA
  _selectedComponents :: [Tag], -- copiar filename do source para target
  _removedComponents  :: [Tag],
  _includedTags       :: [Tag],
  _preprocessFiles    :: [FilePath]
} deriving (Show)
makeLenses ''ComponentModel


-- Transformations

selectComponents :: [Tag] -> Transformation ComponentModel
selectComponents inn _ = fmap $ over (selectedComponents) (inn ++)

removeComponents :: [Tag] -> Transformation ComponentModel
removeComponents ex _ = fmap $ over (removedComponents) (ex ++)

define :: Tag -> Transformation ComponentModel
define t _ = fmap $ over (includedTags) (t :)
