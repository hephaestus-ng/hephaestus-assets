{-# LANGUAGE TemplateHaskell #-}

module Data.SourceCode.Data.Types where

import Control.Lens
import Data.SPL

type Tag      = String
type FilePath = String


data ComponentModel = ComponentModel {
  _files           :: [(Tag, FilePath)]
  _selectedFiles   :: [Tag],  -- copiar filename do source para target
  _includedTags    :: [Tag],
  _preprocessFiles :: [FilePath]
} deriving (Show)
makeLenses ''ComponentModel


-- Transformations

selectComponents :: [Tag] -> Transformation ComponentModel
selectComponents inn _ = fmap $ over (includedFiles) (inn ++)

removeComponents :: [Tag] -> Transformation ComponentModel
removeComponents ex _ = fmap $ over (excludedFiles) (ex ++)

define :: Tag -> Transformation ComponentModel
define t _ = fmap $ over (includedTags) (t :)
