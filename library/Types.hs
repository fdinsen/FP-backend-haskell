{-# LANGUAGE  DeriveGeneric #-}

module Types where

import GHC.Generics
import Data.Aeson (FromJSON, ToJSON)

data User = User
    {username :: String
    ,books :: [Book]
    } deriving (Show, Generic)

data Book = Book
    {title :: String
    ,author :: Author
    } deriving (Show, Generic)

data Author = Author
    {name :: String
    } deriving (Show, Generic)


instance ToJSON User
instance ToJSON Book
instance ToJSON Author
instance FromJSON User
instance FromJSON Book
instance FromJSON Author
