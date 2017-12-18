module Types
    exposing
        ( Tag
        , Node(..)
        , Document
        , getText
        , getTag
        , rhymeTags
        )

import List.Extra exposing (unique)


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


rhymeTags : Document -> List Tag
rhymeTags document =
    document.nodes
        |> List.filterMap getTag
        |> unique
