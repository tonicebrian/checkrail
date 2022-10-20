module Main where

import Checkrails
import qualified Data.Text as T
import Options.Applicative.Simple
import System.FilePath
import Prelude

data Options = Options
  { lang :: Language,
    openApiFile :: FilePath
  }

main :: IO ()
main = do
  (Options {..}, ()) <-
    simpleOptions
      "ver"
      "header"
      "desc"
      ( Options
          <$> option
            auto
            ( long "lang"
                <> short 'l'
                <> value Haskell
                <> showDefault
                <> metavar "LANG"
                <> completeWith (map show [(minBound :: Language) ..])
                <> help
                  ( T.unpack
                      ( "The languange on which generate code. Possible values are: "
                          <> T.intercalate "," (map (T.pack . show) [(minBound :: Language) ..])
                      )
                  )
            )
            <*> strArgument
              (metavar "<OpenApi filename>")
      )
      empty
  generate openApiFile lang
