module SourceCode.Data.Asset where

import SourceCode.Data.ParserT
import SourceCode.Data.Types

import Data.SPL

instance Asset ComponentModel where
  initialize  = Product (ComponentModel [] [] [] [])
  parserT     = parserTransformation
