{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Rules where

import GHC.Generics
import Data.Text
import Data.Text.IO
import Data.Aeson
import GHC.TypeError (ErrorMessage(Text))
import Data.ByteString

data Person = Person {
      name :: Text
    , age  :: Int
    } deriving (Generic, Show)

instance ToJSON Person where
    -- No need to provide a toJSON implementation.

    -- For efficiency, we write a simple toEncoding implementation, as
    -- the default version uses toJSON.
    toEncoding = genericToEncoding defaultOptions

instance FromJSON Person
    -- No need to provide a parseJSON implementation.

-- test = encode (Person {name = "Joe", age = 12})

-- data Creator = Creator {
-- 			name :: Text
-- 		, version :: Text
-- 		} deriving (Generic, Show)

data Request = Request {
      method :: Text
    , url :: Text
    -- , httpVersion :: Text
    -- , cookies :: [Cookie]
    -- , headers :: [Header]
    -- , queryString :: [QueryString]
    -- , postData :: PostData
    -- , headersSize :: Int
    -- , bodySize :: Int
    } deriving (Generic, Show)

data Content = Content {
      size :: Int
    , mimeType :: Text
    , text :: Maybe Text
    } deriving (Generic, Show)

data Response = Response {
      status :: Int
    , statusText :: Text
    -- , httpVersion :: Text
    -- , cookies :: [Cookie]
    -- , headers :: [Header]
    , content :: Content
    -- , redirectURL :: Text
    -- , headersSize :: Int
    -- , bodySize :: Int
    } deriving (Generic, Show)

data Entry = Entry {
      -- startedDateTime :: Text
    -- , time :: Int
      request :: Request
    , response :: Response
    -- , cache :: Cache
    -- , timings :: Timings
    -- , serverIPAddress :: Text
    -- , connection :: Text
    } deriving (Generic, Show)

data Log = Log {
      version :: Text
    -- , creator :: Creator
    , entries :: [Entry]
    } deriving (Generic, Show)

instance ToJSON Request where
    toEncoding = genericToEncoding defaultOptions

instance FromJSON Request

instance ToJSON Content where
    toEncoding = genericToEncoding defaultOptions

instance FromJSON Content

instance ToJSON Response where
    toEncoding = genericToEncoding defaultOptions

instance FromJSON Response

instance ToJSON Entry where
    toEncoding = genericToEncoding defaultOptions

instance FromJSON Entry

instance ToJSON Log where
    toEncoding = genericToEncoding defaultOptions

instance FromJSON Log

-- data Har = Har {
--       log :: Log
--     } deriving (Generic, Show)

newtype Har
  = Har {log :: Log}
  deriving (Generic, Show)

instance ToJSON Har where
    toEncoding = genericToEncoding defaultOptions

instance FromJSON Har

test = decode "{\"name\":\"Joe\",\"age\":12}" :: Maybe Person

harFile = Data.ByteString.readFile "rules.har" :: IO ByteString

harContent = decodeFileStrict "rules.har" :: IO (Maybe Har)