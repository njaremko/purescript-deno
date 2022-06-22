module Deno.Http.Request where

import Prelude
import Web.Streams.ReadableStream (ReadableStream)

-- | A HTTP request object
foreign import data Request :: Type

foreign import body :: forall x. Request -> ReadableStream x

foreign import url :: Request -> String
