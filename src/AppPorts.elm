port module AppPorts exposing (..)

import Json.Decode exposing (..)

-- listen to scroll events
port lastItemVisible : (Bool -> msg) -> Sub msg
-- start listening to last child of the dom with given Id
port isLastElemVisible : String -> Cmd msg


-- jsonP
port fetchJsonP : String -> Cmd msg

port fetchJsonPSucceed : (Value -> msg) -> Sub msg
port fetchJsonPFail : (Value -> msg) -> Sub msg
