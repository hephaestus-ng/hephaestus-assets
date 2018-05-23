module Data.SourceCode.Data.Asset where

import System.IO
import Control.Lens
import Control.Exception

import Data.SourceCode.Data.ParserT
import Data.SourceCode.Data.Types

import Data.SPL

instance Asset ComponentModel where
  initialize  = Product (ComponentModel [] [] [] [])
  parserT     = parserTransformation

  export src trg (Product prod) =
    bracket
      (openFile trg WriteMode)
      hClose
      (\h -> hPutStr h (concat [e ++ "\n" | e <- (view includedTags prod)]))
