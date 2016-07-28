module Msgs exposing (..)
import Http

-- models
import Models exposing (..)


-- MSG
type Msg 
  = Noop 
  | FetchStarted String
  | RedditFetchSucceed RedditListing
  | RedditFetchFail Http.Error

  | LastItemVisible Bool
