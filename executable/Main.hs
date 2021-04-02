-- Compiler directive converting strings to Unicode
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE  DeriveGeneric #-}

module Main where

import Types
import qualified Example as E

import Web.Scotty
import Network.Wai.Middleware.Cors
import Data.Aeson (FromJSON, ToJSON)
import GHC.Generics
import Control.Monad
import Database.HDBC
import Database.HDBC.MySQL

import qualified Data.Text.Lazy as L

-- cabal new-build
-- cabal new-run backend
main :: IO ()
main = do -- IO Monad
    conn <- connectMySQL defaultMySQLConnectInfo {
        mysqlHost     = "db1.example.com",
        mysqlUser     = "scott",
        mysqlPassword = "tiger"
    }
    putStrLn "Starting Server at 4711 ..."
    scotty 4711 $ do -- bruger en ScottyM monad
        middleware $ cors (const $ Just appCorsResourcePolicy)
        get "/hello" $ do -- ActionM monad
            text "Hello World!"
        get "/hello/:name" $ do
            name <- param "name"
            text $ L.pack ("Hello " ++ name ++ "!")
        get "/author" (json E.a1)

        post "/author" $ do
            a5 <- jsonData :: ActionM Author --jsonData skal vide hvad typen skal være
            json a5
        get "/book/" $ do
            json E.u1
        post "/book/add" $ do
            book <- jsonData :: ActionM Book
            text $ L.pack ("{\"msg\":\"Book saved was: " ++ (title book) ++ "!\"}")


appCorsResourcePolicy :: CorsResourcePolicy
appCorsResourcePolicy =
    simpleCorsResourcePolicy
        { corsMethods = ["GET", "POST"]
        , corsRequestHeaders = ["Authorization", "Content-Type"]
        }


-- do indsætter automatisk >>= mellem expressions.
-- Den håndterer altså selv at passere Monaden rundt