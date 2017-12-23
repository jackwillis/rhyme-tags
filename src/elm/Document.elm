module Document
    exposing
        ( Tag
        , Node(Text, Rhyme)
        , Document
        , getText
        , getTag
        , tags
        , indexOfTag
        )

{-| Document is the main data type in rhyme-tags, representing a marked-up poem.

@docs Tag, Node
@docs getText, getTag

@docs Document
@docs tags, indexOfTag

-}

import Dict exposing (Dict)
import List.Extra as List


{-| Use this type alias to avoid confusion between text and tag string values in `Node`s.
-}
type alias Tag =
    String


{-| A `Node` is a segment of a `Document`, capturing data between rhyme boundaries.
-}
type Node
    = Text { text : String }
    | Rhyme { tag : Tag, text : String }


{-| This function is equivalent to a `(.text)` that works on `Node`s.

    Text  { text = "blue"              } |> getText == "blue"
    Rhyme { text = "blue", tag = "you" } |> getText == "blue"

-}
getText : Node -> String
getText node =
    case node of
        Text { text } ->
            text

        Rhyme { text } ->
            text


{-| This function is equivalent to a `(.tag)` that works on `Node`s, but is optional.

    Text  { text = "blue"              } |> getTag == Nothing
    Rhyme { text = "blue", tag = "you" } |> getTag == Just "you"

-}
getTag : Node -> Maybe Tag
getTag node =
    case node of
        Text _ ->
            Nothing

        Rhyme { tag } ->
            Just tag


{-| This structure represents a whole poem. A document is made up of `Node`s, which begin and end at rhyme boundaries.
For example, here is an excerpt from The Coup's "Fat Cats, Bigga Fish", represented as a `Document`:

    fatCats : Document
    fatCats =
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


{-| Returns a list of every unique tag in a document.

    fatCats |> tags == [ "property", "collection" ]

-}
tags : Document -> List Tag
tags document =
    document.nodes
        |> List.filterMap getTag
        |> List.unique


{-| Returns a tag's order of appearance in a document.

    fatCats |> indexOfTag "property"   == Just 0
    fatCats |> indexOfTag "collection" == Just 1
    fatCats |> indexOfTag "cabbage"    == Nothing

-}
indexOfTag : Document -> Tag -> Maybe Int
indexOfTag document tag =
    let
        dict : Dict Tag Int
        dict =
            document
                |> tags
                |> List.indexedMap (\i tag -> ( tag, i ))
                |> Dict.fromList
    in
        Dict.get tag dict
