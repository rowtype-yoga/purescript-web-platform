module Web.DOM.Platform
  ( devicePixelRatio
  , observeResize
  , getStyleProperty
  , setStyleProperty
  , innerHTML
  , setInnerHTML
  , isConnected
  , MediaQueryList
  , matchMedia
  , mediaQueryListToEventTarget
  ) where

import Prelude

import Effect (Effect)
import Unsafe.Coerce (unsafeCoerce)
import Web.DOM.Element (Element)
import Web.DOM.Node (Node)
import Web.Event.EventTarget (EventTarget)

foreign import data MediaQueryList :: Type

mediaQueryListToEventTarget :: MediaQueryList -> EventTarget
mediaQueryListToEventTarget = unsafeCoerce

foreign import devicePixelRatio :: Effect Number
foreign import observeResize :: Element -> Effect Unit -> Effect (Effect Unit)
foreign import getStyleProperty :: Element -> String -> Effect String
foreign import setStyleProperty :: Element -> String -> String -> Effect Unit
foreign import innerHTML :: Element -> Effect String
foreign import setInnerHTML :: String -> Element -> Effect Unit
foreign import isConnected :: Node -> Effect Boolean
foreign import matchMedia :: String -> Effect MediaQueryList
