module Decoders exposing (..)

import Json.Decode exposing (..)
import Date

import Models exposing (..)

{-
   Decoders of reddit json value
   I think it is better to use
    package elm-json-extra for this 
-}

decodeRedditLink : Decoder RedditLink
decodeRedditLink =
    object8 RedditLink
        ("author" := string)
        ("domain" := string)
        ("is_self" := bool)
        ("num_comments" := int)
        ("permalink" := string)
        ("score" := int)
        (map (\val -> if val == "" then Nothing else Just val) ("thumbnail" := string))
        ("title" := string)
    `andThen`
    (\f ->
        object3 f
            ("url" := string)
            (map Date.fromTime ("created_utc" := float))
            ("id" := string)
    ) 

{-
    API response decoder. returns a listing
-}
decodeNews : Decoder RedditListing
decodeNews =
    ("data" := object3 RedditListing
        ("children" := (list ("data" := decodeRedditLink)))
        ("after" := oneOf [string, succeed ""])
        ("before" := oneOf [string, succeed ""]))
