module Components.RedditWidget exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Http
import String
import Date
import Task exposing (Task)
import Date.Format
import Models exposing (RedditLink)
import Decoders exposing (decodeNews)

import AppPorts exposing (fetchJsonP)


-- reddit has disabled CORS, nothing works :|
--loadRedditLink : Task Http.Error (List RedditLink)
--loadRedditLink = Http.get decodeNews "http://localhost:8000/r/elm/new.json?raw_json=1"
--loadRedditLink = Http.get decodeNews "http://reddit.com/r/elm/new.json?raw_json=1"
--loadRedditLink = Http.get decodeNews "http://localhost:3000/reddit_resp"

--loadRedditLinks  = fetchJsonP "http://reddit.com/r/elm/new.json"
loadRedditLinks  = fetchJsonP "http://reddit.com/r/elm/new.json?raw_json=1"
loadMoreRedditLinks after = fetchJsonP <| "http://reddit.com/r/elm/new.json?raw_json=1?after=" ++ after 

{-
    Renders reddit row. 
-}
view : RedditLink -> Html a
view model =
    div [ class "panel panel-default" ][
        div [ class "panel-body hover-highlight" ][
            div [ class "col-xs-2" ][
                img [ src (genThumbnail model), alt "an icon", class "timeline-thumbnail img-rounded" ] []
            ],

            div [ class "col-xs-10" ][
                div [ class "row" ][
                    h4 [] [
                        a [ href model.url, target "_blank"][ text model.title ]
                    ]
                ],
                div [ class "row" ][
                    small [][
                        span [][
                            text <| "submitted on " ++ (formatCreatedAt model) ++ " by "
                        ],

                        a [ class "text-muted", href <| genUserUrl model.author, target "_blank" ][
                            text model.author
                        ],

                        div [][
                            a [ class "text-muted", href <| genCommentUrl model, target "_blank" ] [
                                text <| (toString model.numComments) ++ " comments"
                            ]
                        ]
                    ]
                ]
            ]
        ]
    ]


formatCreatedAt model = Date.Format.format "%a %l:%M" model.created_utc

genUserUrl user = "https://www.reddit.com/user/" ++ user
genCommentUrl { permalink } = "https://www.reddit.com/" ++ permalink

-- use either reddit supplied icon or use domain favicon
genThumbnail { domain , thumbnail } =
    let
        url = if domain /= "self.elm" then domain else "reddit.com"
    in
        Maybe.withDefault ("http://" ++ url ++ "/favicon.ico") thumbnail
