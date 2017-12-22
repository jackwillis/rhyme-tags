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

{-| Document is the main data type in rhyme-tags, representing a marked-up poem.

@docs Tag, Node
@docs getText, getTag

@docs Document
@docs tags, tagIndex

-}

import Dict exposing (Dict)
import List.Extra as List


{-| -}
type alias Tag =
    String


{-| -}
type Node
    = Text { text : String }
    | Rhyme { tag : Tag, text : String }


{-| -}
getText : Node -> String
getText node =
    case node of
        Text { text } ->
            text

        Rhyme { text } ->
            text


{-| -}
getTag : Node -> Maybe Tag
getTag node =
    case node of
        Text _ ->
            Nothing

        Rhyme { tag } ->
            Just tag


{-| This structure represents a whole poem. A document is made up of `Node`s, which begin and end at rhyme boundaries.
For example, here is an excerpt from The Coup's "Fat Cats, Bigga Fish", represented as a `Document`:

    Document
        [ Text { text = "It's almost 10 o'clock, see, I got a ball of lint for " }
        , Rhyme
            { tag = "property"
            , text = "property"
            }
        , Text { text = "\nSo I slip my beanie on " }
        , Rhyme
            { tag = "property"
            , text = "sloppily"
            }
        , Text { text = "\nAnd promenade out to take up a " }
        , Rhyme
            { tag = "collection"
            , text = "collection"
            }
        , Text { text = "\nI got game like I read the " }
        , Rhyme
            { tag = "collection"
            , text = "directions"
            }
        ]

-}
type alias Document =
    { nodes : List Node }


{-| -}
tags : Document -> List Tag
tags document =
    document.nodes
        |> List.filterMap getTag
        |> List.unique


{-| -}
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


maybeEqual : Maybe a -> a -> Bool
maybeEqual maybe other =
    maybe |> Maybe.map ((==) other) |> Maybe.withDefault False
