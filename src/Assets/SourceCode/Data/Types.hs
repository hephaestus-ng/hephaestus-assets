{-# LANGUAGE TemplateHaskell #-}

module SourceCode.Data.Types where

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


selectComponents :: [String] -> Transformation ComponentModel
selectComponents s _ = fmap $ over (includedFiles) (s ++)

define :: Tag -> Transformation ComponentModel
define t _ = fmap $ over (includedTags) (t :)
