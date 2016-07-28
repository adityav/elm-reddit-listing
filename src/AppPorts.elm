port module AppPorts exposing (..)

import Json.Encode exposing (Value)

-- listen to scroll events
port lastItemVisible : (Bool -> msg) -> Sub msg
-- start listening to last child of the dom with given Id
port isLastElemVisible : String -> Cmd msg
-- json P 

port fetchJsonP : String -> Cmd msg

port fetchJsonPSucceed : (Value -> msg) -> Sub msg
port fetchJsonPFail : (Value -> msg) -> Sub msg
