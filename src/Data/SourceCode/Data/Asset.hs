module Data.SourceCode.Data.Asset where

import System.IO
import System.Directory
import System.FilePath
import Control.Lens
import Control.Exception

import Data.SourceCode.Data.ParserT
import Data.SourceCode.Data.ParserA
import Data.SourceCode.Data.Types

import Data.SPL


instance Asset ComponentModel where
  initialize  = Product (ComponentModel [] [] [] [] [])
  parserT     = parserSourceCode
  parserA     = parserAssetBase

  export src trg ab (Product prod) = do
    copyIncludedTags trg (view includedTags prod)
    copyPreprocessFiles trg (view preprocessFiles prod)
    copyComponents src trg (view components ab) (view selectedComponents prod)


copyComponents :: FilePath -> FilePath -> [Component] -> [Tag] -> IO ()
copyComponents src trg components selectedComponents = do
  -- let files = [c | c <- components, isSelected selectComponents]
  let files = filter (isSelected selectedComponents) components
  createTargetDirs trg files
  mapM (\(c, fs) -> mapM (\f -> copyFile (src ++ f) (trg ++ f)) fs) files
  bracket
    (openFile (trg ++ "selectedComponents.txt") WriteMode)
    hClose
    (\h -> hPutStr h (concat [c ++ "\n" | (c, fs) <- files]))


isSelected :: [Tag] -> Component -> Bool
isSelected cs (c, p) =
  if c `elem` cs then True else False


createTargetDirs :: FilePath -> [Component] -> IO ()
createTargetDirs trg [] = return ()
createTargetDirs trg ((c, fs):xs) = do
  mapM (\f -> createDirectoryIfMissing True (dropFileName $ trg ++ f)) fs
  createTargetDirs trg xs


copyIncludedTags :: FilePath -> [Tag] -> IO ()
copyIncludedTags trg tags =
  bracket
    (openFile (trg ++ "tags.txt") WriteMode)
    hClose
    (\h -> hPutStr h (concat [t ++ "\n" | t <- tags]))


copyPreprocessFiles :: FilePath -> [FilePath] -> IO ()
copyPreprocessFiles trg ppfiles =
  bracket
    (openFile (trg ++ "ppfiles.txt") WriteMode)
    hClose
    (\h -> hPutStr h (concat [f ++ "\n" | f <- ppfiles]))

--EXPORT
-- 1- cópia dos arquivos no includedFiles
-- 2- remover os arquivos do target do excludedFiles
-- 3- gerar arquivo tags no target, um tag por linha
-- 4- gerar arquivo contendo um nome de arquivo por linha, do _preprocessFiles
