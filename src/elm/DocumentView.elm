module DocumentView exposing (displayResult)

import Char
import Color.Convert exposing (colorToCssRgb)
import Dict exposing (Dict)
import Html exposing (Html, div, text, span, ul, li)
import Html.Attributes exposing (class, style, title)
import Document exposing (Node(..), Document, Tag, tags)
import Data.Palette exposing (Style, nthStyle, defaultStyle)
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


nthLatinLetterEnclosedInACircle : Int -> Maybe Char
nthLatinLetterEnclosedInACircle n =
    -- Note: 65 = 'A' in Unicode
    -- Expects input in range [1, 26]
    if 0 < n && n <= 26 then
        Just <| Char.fromCode <| 65 + (n - 1)
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
        |> List.map nthLatinLetterEnclosedInACircle
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

        getStyle : Tag -> Style
        getStyle tag =
            tagIndices
                |> Dict.get tag
                |> Maybe.map nthStyle
                |> Maybe.withDefault defaultStyle

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
                    let
                        style =
                            getStyle tag
                    in
                        span
                            [ class "rhyme"
                            , Html.Attributes.style
                                [ ( "backgroundColor", style.color |> colorToCssRgb )
                                , ( "color"
                                  , (if style.isDark then
                                        "white"
                                     else
                                        "black"
                                    )
                                  )
                                ]
                            , title ((getMark tag) ++ ": " ++ tag)
                            ]
                            [ Html.text text
                            ]
    in
        List.map displayNode document.nodes
