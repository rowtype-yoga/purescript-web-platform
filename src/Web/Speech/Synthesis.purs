module Web.Speech.Synthesis
  ( NativeSynthesis
  , NativeUtterance
  , NativeVoice
  , VoiceInfo
  , NativeBoundary
  , getSynthesis
  , getVoices
  , voiceInfo
  , newUtterance
  , configureUtterance
  , onStartNative
  , onBoundaryNative
  , onEndNative
  , onErrorNative
  , speakNative
  , cancelNative
  ) where

import Prelude

import Data.Nullable (Nullable)
import Effect (Effect)

foreign import data NativeSynthesis :: Type
foreign import data NativeUtterance :: Type
foreign import data NativeVoice :: Type

type VoiceInfo =
  { name :: String
  , lang :: String
  , localService :: Boolean
  , isDefault :: Boolean
  }

type NativeBoundary =
  { charIndex :: Nullable Number
  , charLength :: Nullable Number
  , name :: Nullable String
  }

foreign import getSynthesis :: Effect (Nullable NativeSynthesis)
foreign import getVoices :: NativeSynthesis -> Effect (Array NativeVoice)
foreign import voiceInfo :: NativeVoice -> VoiceInfo
foreign import newUtterance :: String -> Effect NativeUtterance
foreign import configureUtterance
  :: NativeUtterance
  -> { voice :: Nullable NativeVoice, lang :: String, rate :: Number, pitch :: Number }
  -> Effect Unit

foreign import onStartNative :: NativeUtterance -> Effect Unit -> Effect (Effect Unit)
foreign import onBoundaryNative :: NativeUtterance -> (NativeBoundary -> Effect Unit) -> Effect (Effect Unit)
foreign import onEndNative :: NativeUtterance -> Effect Unit -> Effect (Effect Unit)
foreign import onErrorNative :: NativeUtterance -> (String -> Effect Unit) -> Effect (Effect Unit)
foreign import speakNative :: NativeSynthesis -> NativeUtterance -> Effect Unit
foreign import cancelNative :: NativeSynthesis -> Effect Unit
