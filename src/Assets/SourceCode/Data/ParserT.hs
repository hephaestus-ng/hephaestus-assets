module SourceCode.Data.ParserT where

import Text.Parsec
-- import Text.Parsec.Token hiding (commaSep)
import Text.Parsec.String

import SourceCode.Data.Types
import Data.SPL


-- parseW :: String -> Either String (Transformation ComponentModel)
-- parseW s = let res = parse parserTransformation "" s in
--            case res of
--              Left err -> Left $ show err
--              Right tr -> Right tr

parserTransformation :: Parsec String () (Transformation ComponentModel)
parserTransformation =
  parseSelect <|>
  parseDefine


parseSelect :: Parsec String () (Transformation ComponentModel)
parseSelect =
  string "select" >> many space >> string "("
  >> names >>= \ns -> string ")" >>
  return (selectComponents ns)


parseDefine :: Parsec String () (Transformation ComponentModel)
parseDefine =
  string "define" >> many space >> string "("
  >> parseName >>= \tag -> string ")" >>
  return (define tag)


parseName :: Parsec String () String
parseName =
  string "\"" >> many1 letter >>= \c -> string "\"" >> return c


-- commaSep :: (Parsec String () String) -> Parsec String () [String]
names =
  (parseName >>= \n -> char ',' >> names >>= \ns -> return (n:ns))
  <|>
  (parseName >>= \r -> return [r])
