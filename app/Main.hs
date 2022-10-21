module Main where

import Checkrail
import qualified Data.Text as T
import Options.Applicative.Simple
import System.FilePath
import Prelude

data Options = Options
  { lang :: Language,
    format :: FileFormat,
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
                      ( "The language for the generated code. Possible values are: "
                          <> T.intercalate "," (map (T.pack . show) [(minBound :: Language) ..])
                      )
                  )
            )
            <*> option
              auto
              ( long "file-format"
                  <> short 'f'
                  <> value Yaml
                  <> showDefault
                  <> metavar "FORMAT"
                  <> completeWith (map show [(minBound :: FileFormat) ..])
                  <> help
                    ( T.unpack
                        ( "Format of the OpenApi file. Possible values are: "
                            <> T.intercalate "," (map (T.pack . show) [(minBound :: FileFormat) ..])
                        )
                    )
              )
            <*> strArgument
              (metavar "<OpenApi filename>")
      )
      empty
  generate openApiFile format lang
