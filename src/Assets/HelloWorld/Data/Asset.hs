module HelloWorld.Data.Asset where

import HelloWorld.Data.Types
import HelloWorld.Data.ParserT

import Data.SPL

instance Asset HwAsset where
  initialize = Product $ HwAsset { msg = "Hello World" }
  parserT    = hwParser
