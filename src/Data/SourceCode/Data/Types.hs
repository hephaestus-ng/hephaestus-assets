{-# LANGUAGE TemplateHaskell #-}

module Data.SourceCode.Data.Types where

import Control.Lens
import Data.SPL

type Tag      = String
type FileName = String


data ComponentModel = ComponentModel {
  _includedFiles   :: [FileName],
  _excludedFiles   :: [FileName],
  _includedTags    :: [Tag],
  _preprocessFiles :: [FileName]
} deriving (Show)
makeLenses ''ComponentModel


-- Transformations

selectComponents :: [String] -> Transformation ComponentModel
selectComponents inn _ = fmap $ over (includedFiles) (inn ++)

removeComponents :: [String] -> Transformation ComponentModel
removeComponents ex _ = fmap $ over (excludedFiles) (ex ++)

define :: Tag -> Transformation ComponentModel
define t _ = fmap $ over (includedTags) (t :)
