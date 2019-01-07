module Data.SourceCode.Data.Asset where

import System.IO
import Control.Lens
import Control.Exception

import Data.SourceCode.Data.ParserT
import Data.SourceCode.Data.Types

import Data.SPL


instance Asset ComponentModel where
  initialize  = Product (ComponentModel [] [] [] [])
  parserT     = parserSourceCode

  export src trg (Product prod) =
    bracket
      (openFile trg WriteMode)
      hClose
      (\h -> hPutStr h (concat [e ++ "\n" | e <- (view includedTags prod)]))


--EXPORT
-- 1- cópia dos arquivos no includedFiles
-- 2- remover os arquivos do target do excludedFiles
-- 3- gerar arquivo tags no target, um tag por linha
-- 4- gerar arquivo contendo um nome de arquivo por linha, do _preprocessFiles


-- copySourceFiles source out [] = return ()
-- copySourceFiles source out (c:cs) =
--  do
--   createOutDir out c
--   copySourceFile source out c
--   copySourceFiles source out cs
--
--
-- createOutDir out c =
--  do
--   print $ "Selected output dir: " ++ out
--   print $ "Selected output component" ++ (snd c)
--   let new = out </> (snd c)
--   let newDir = dropFileName new
--   print new
--   print newDir
--   createDirectoryIfMissing True newDir
