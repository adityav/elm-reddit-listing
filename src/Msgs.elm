module Msgs exposing (..)
import Http

-- models
import Models exposing (..)


-- MSG
type Msg 
  = Noop 
  -- reddit fetching msgs
  | FetchStarted String
  | RedditFetchSucceed RedditListing
  | RedditFetchFail Http.Error
  -- scrolling msgs
  | LastItemVisible Bool
  | SetFilter String
