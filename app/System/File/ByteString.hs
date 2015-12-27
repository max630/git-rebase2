module System.File.ByteString (
    readFile,
    withFile
  ) where

import Prelude hiding (readFile)

import Control.Exception (throwIO)
import Control.Monad (join)
import Data.ByteString (ByteString)
import Data.Text (unpack)
import Data.Text.Encoding (decodeUtf8')

import qualified Data.ByteString as B
import qualified System.IO as SI

withFile :: ByteString -> SI.IOMode -> (SI.Handle -> IO ()) -> IO ()
withFile p m f = join $ SI.withFile <$> decode p <*> pure m <*> pure f

readFile p = decode p >>= B.readFile

decode :: ByteString -> IO String
decode = either throwIO (pure . unpack) . decodeUtf8'
