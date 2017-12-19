module DocumentView exposing (displayResult)

import Char
import Dict exposing (Dict)
import Html exposing (Html, div, text, span, ul, li)
import Html.Attributes exposing (class, style)
import Document exposing (Node(..), Document, Tag, tags)
import Data.Palette exposing (ColorString, nthColor)
import DocumentParser exposing (ParseResult)


displayResult : ParseResult -> List (Html a)
displayResult poem =
    case poem of
        Err ( _, _, errors ) ->
            displayErrors errors

        Ok ( _, _, document ) ->
            displayDocument document


displayErrors : List String -> List (Html a)
displayErrors errors =
    let
        displayError : String -> Html a
        displayError err =
            li [] [ text (Basics.toString err) ]
    in
        [ text "Errors: "
        , ul [] (errors |> List.map displayError)
        ]


nthLatinLetter : Int -> Maybe Char
nthLatinLetter n =
    -- Note: 0x249C = '⒜', part of Enclosed Alphanumerics block in Unicode
    -- Expects input in range [1, 26]
    if 0 < n && n <= 26 then
        Just <| Char.fromCode <| 0x249C + (n - 1)
    else
        Nothing


digitsInBase : Int -> Int -> List Int
digitsInBase base value =
    let
        recur : List Int -> Int -> List Int
        recur digits value =
            case value of
                0 ->
                    digits

                _ ->
                    recur ((value % base) :: digits) (value // base)
    in
        recur [] value


removeNothings : List (Maybe a) -> List a
removeNothings =
    List.filterMap identity


base26 : Int -> String
base26 n =
    digitsInBase 26 (n + 1)
        |> List.map nthLatinLetter
        |> removeNothings
        |> String.fromList


displayDocument : Document -> List (Html a)
displayDocument document =
    let
        tagIndices : Dict Tag Int
        tagIndices =
            document
                |> tags
                |> List.indexedMap (\i tag -> ( tag, i ))
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
                    span
                        [ class "rhyme"
                        , style [ ( "color", getColor tag ) ]
                        ]
                        [ Html.text text
                        , span [ class "mark" ] [ Html.text (getMark tag) ]
                        ]
    in
        List.map displayNode document.nodes
