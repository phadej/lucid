-- | This is a module which runs the 'HtmlBenchmarks' module using the different
-- renderers available.
--
module RunHtmlBenchmarks where

import           Criterion.Main
import qualified Data.ByteString.Lazy as LB
import qualified Data.Text.Lazy.Encoding as LT
import qualified Data.Text.Lazy as LT

import qualified Text.Blaze.Renderer.Utf8 as Utf8
import qualified Text.Blaze.Renderer.String as String
import qualified Text.Blaze.Renderer.Text as Text

import           HtmlBenchmarks (HtmlBenchmark (..), benchmarks)

import qualified Blaze.ByteString.Builder.Char.Utf8 as Blaze
import qualified Blaze.ByteString.Builder as Blaze

import           Lucid (execHtml)

-- | Function to run the benchmarks using criterion
--
main :: IO ()
main = defaultMain $ map benchHtml benchmarks
  where
    benchHtml (HtmlBenchmark name f x _) = bgroup name $
        [bench "ByteString"   $ nf (LB.length . Blaze.toLazyByteString . execHtml . f) x
        ]
