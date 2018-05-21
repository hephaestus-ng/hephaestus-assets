module HelloWorld.Data.Types where

import Data.SPL

data HwAsset = HwAsset {
  msg :: String
} deriving (Show)

-- Transformation
setMessage :: String -> Transformation HwAsset
setMessage s _ (Product p) = Product $ p { msg = s }
