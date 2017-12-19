module DocumentView exposing (displayResult, toBase, base26)

import Char
import Dict exposing (Dict)
import Html exposing (Html, div, text, span, pre)
import Html.Attributes exposing (class, style)
import Document exposing (Node(..), Document, Tag, tags)
import Data.Palette exposing (ColorString, nthColor)
import DocumentParser exposing (ParseResult)


displayResult : ParseResult -> Html a
displayResult poem =
    case poem of
        Err ( _, _, errors ) ->
            displayErrors errors

        Ok ( _, _, document ) ->
            displayDocument document


displayErrors : List String -> Html a
displayErrors errors =
    div [] [ text ("Errors: " ++ Basics.toString errors) ]


nthLetter : Int -> Maybe Char
nthLetter n =
    -- Note: 0x249C = '⒜', part of Enclosed Alphanumerics block in Unicode
    if 0 <= n && n < 26 then
        Just <| Char.fromCode <| 0x249C + n
    else
        Nothing


toBase : Int -> Int -> List Int
toBase base v =
    let
        go : List Int -> Int -> List Int
        go a v =
            if v == 0 then
                case a of
                  [] -> [ 0 ] -- special case: `toBase n 0` should return `[ 0 ]`.
                  _ -> a
            else
                go ((v % base) :: a) (v // base)
    in
        go [] v


base26 : Int -> String
base26 n =
        toBase 26 n
        |> List.map nthLetter
        |> List.filterMap identity
        |> String.fromList


displayDocument : Document -> Html a
displayDocument document =
    let
        tagIndices : Dict Tag Int
        tagIndices =
            document
                |> tags
                |> List.indexedMap (flip (,))
                |> Dict.fromList

        getColor : Tag -> ColorString
        getColor tag =
            tagIndices
                |> Dict.get tag
                |> Maybe.map nthColor
                |> Maybe.withDefault ""

        getMark : Tag -> String
        getMark tag =
            tagIndices
                |> Dict.get tag
                |> Maybe.map base26
                |> Maybe.withDefault ""

        displayNode : Node -> Html a
        displayNode node =
            case node of
                Text { text } ->
                    Html.text text

                Rhyme { tag, text } ->
                    span [ style [ ( "color", getColor tag ) ] ]
                        [ Html.text text
                        , span [ class "mark" ] [ Html.text (getMark tag) ]
                        ]
    in
        pre [ class "document" ] (List.map displayNode document.nodes)
