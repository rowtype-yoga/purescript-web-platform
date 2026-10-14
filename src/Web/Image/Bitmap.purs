-- | Worker-safe decoded browser image handles. A bitmap is a Canvas image
-- | source, has immutable intrinsic dimensions, and must be explicitly closed
-- | by the owner that created it.
module Web.Image.Bitmap
  ( ImageBitmap
  , Rasterized
  , create
  , rasterize
  , width
  , height
  , close
  , toCanvasImageSource
  ) where

import Data.Unit (Unit)
import Effect (Effect)
import Graphics.Canvas (CanvasImageSource)
import Promise (Promise)
import Web.File.Blob (Blob)

-- | A PNG data URI produced by a document-side SVG decode. This exists because
-- | Chromium's worker-side `createImageBitmap` rejects SVG Blobs even though
-- | its `<img>` decoder accepts them.
type Rasterized =
  { source :: String
  , width :: Number
  , height :: Number
  }

foreign import data ImageBitmap :: Type

-- | Decode a browser-supported bitmap Blob. The returned Promise rejects on
-- | an unsupported or malformed source.
foreign import create :: Blob -> Effect (Promise ImageBitmap)

-- | Decode an SVG through a document-owned HTML image and rasterize it as a
-- | PNG data URI. Callers choose the output's longest pixel edge; the binding
-- | preserves aspect ratio and imposes no application raster policy. Workers
-- | do not have this DOM image decoder, and callers retain the original SVG
-- | source for portable SVG output.
foreign import rasterize
  :: { maximum :: Number }
  -> Blob
  -> Effect (Promise Rasterized)

foreign import width :: ImageBitmap -> Effect Number
foreign import height :: ImageBitmap -> Effect Number
foreign import close :: ImageBitmap -> Effect Unit
foreign import toCanvasImageSource :: ImageBitmap -> CanvasImageSource
