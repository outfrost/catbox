module Catbox.Internal.Function
( Function(..)
, getFile
, getFilePath
, getPandoc
, getText
) where

import Catbox.Internal.Monad
import Catbox.Internal.Types

import Text.Pandoc (Pandoc)
import qualified Data.Map as Map
import qualified Data.Text as T
import qualified Data.Dynamic as Dynamic
import qualified Type.Reflection as Reflection

data Function =
  Function
    { functionName :: Text
    , functionExec :: Map Text Value -> Key -> Catbox Text ()
    }

-------------------------------------------------------------------------------
-- function helpers
-------------------------------------------------------------------------------

getFile :: Text -> Map Text Value -> Catbox Text File
getFile name params =
  case Map.lookup name params of
    Just (CFile v) -> pure v
    Just _ -> throwError ("Cannot convert parameter " <> name <> " to file")
    _ -> throwError ("Cannot find parameter " <> name)

getFilePath :: Text -> Map Text Value -> Catbox Text FilePath
getFilePath name params =
  case Map.lookup name params of
    Just (CFilePath v) -> pure v
    Just _ -> throwError ("Cannot convert parameter " <> name <> " to file path")
    _ -> throwError ("Cannot find parameter " <> name)

getPandoc :: Text -> Map Text Value -> Catbox Text Pandoc
getPandoc name params =
  case Map.lookup name params of
    Just (CPandoc v) -> pure v
    Just _ -> throwError ("Cannot convert parameter " <> name <> " to pandoc")
    _ -> throwError ("Cannot find parameter " <> name)

getText :: Text -> Map Text Value -> Catbox Text Text
getText name params =
  case Map.lookup name params of
    Just (CText v) -> pure v
    Just _ -> throwError ("Cannot convert parameter " <> name <> " to text")
    _ -> throwError ("Cannot find parameter " <> name)