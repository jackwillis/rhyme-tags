module Document
    exposing
        ( Tag
        , Node(Text, Rhyme)
        , Document
        , getText
        , getTag
        , tags
        , tagIndex
        )

import Dict exposing (Dict)
import List.Extra as List


type alias Tag =
    String


type Node
    = Text { text : String }
    | Rhyme { tag : Tag, text : String }


getText : Node -> String
getText node =
    case node of
        Text { text } ->
            text

        Rhyme { text } ->
            text


getTag : Node -> Maybe Tag
getTag node =
    case node of
        Text _ ->
            Nothing

        Rhyme { tag } ->
            Just tag



-- This structure represents a whole poem,
-- made up of Nodes which begin and end at rhyme boundaries.


type alias Document =
    { nodes : List Node }


tags : Document -> List Tag
tags document =
    document.nodes
        |> List.filterMap getTag
        |> List.unique


tagIndex : Document -> Tag -> Maybe Int
tagIndex document tag =
    let
        dict : Dict Tag Int
        dict =
            document
                |> tags
                |> List.indexedMap (\i tag -> ( tag, i ))
                |> Dict.fromList
    in
        Dict.get tag dict
