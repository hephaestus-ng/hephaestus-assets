module Data.HelloWorld.Data.Asset where

import Data.HelloWorld.Data.Types
import Data.HelloWorld.Data.ParserT

import Data.SPL

instance Asset HwAsset where
  initialize = Product $ HwAsset { msg = "Hello World" }
  parserT    = hwParser
