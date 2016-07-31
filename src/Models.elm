module Models exposing (..)
import Date exposing(Date)
import Http

-- App MODEL
type alias Model = 
  { redditListing : RedditListing
  , fetchError : Maybe Http.Error
  , isLoading : Bool
  , filterString : String
  }

-- Reddit link data
type alias RedditLink =
    { author : String
    , domain : String
    , isSelf : Bool
    , numComments : Int
    , permalink : String
    , score : Int
    , thumbnail : Maybe String
    , title : String
    , url : String
    , created_utc : Date
    , id : String
    }

type alias RedditListing =
    {
        data : List RedditLink,
        after : String,
        before : String
    }

emptyListing = RedditListing [] "" ""


mergeListing : RedditListing -> RedditListing -> RedditListing
mergeListing listing newListing =
    { listing |
        data = (listing.data ++ newListing.data),
        after = newListing.after
    }
