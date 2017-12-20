module DocumentView exposing (displayResult)

import Array exposing (Array, fromList, append, get, length)
import Char
import Color exposing (Color, rgb)
import Color.Convert exposing (colorToCssRgb)
import Dict exposing (Dict)
import Html exposing (Html, div, text, span, ul, li)
import Html.Attributes exposing (class, style, title)
import Document exposing (Node(..), Document, Tag, tags)
import DocumentParser exposing (ParseResult)
import Maybe exposing (withDefault)


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


type alias Style =
    { color : Color, isDark : Bool }


tolQualitative : Array Style
tolQualitative =
    fromList
        [ Style (rgb 51 34 136) True
        , Style (rgb 102 153 204) False
        , Style (rgb 136 204 238) False
        , Style (rgb 68 170 153) False
        , Style (rgb 17 119 51) True
        , Style (rgb 153 153 51) False
        , Style (rgb 221 204 119) False
        , Style (rgb 102 17 0) True
        , Style (rgb 204 102 119) False
        , Style (rgb 170 68 102) True
        , Style (rgb 136 34 85) True
        , Style (rgb 170 68 153) True
        ]


tolRainbow : Array Style
tolRainbow =
    fromList
        [ Style (rgb 120 28 129) True
        , Style (rgb 64 67 153) True
        , Style (rgb 72 139 194) True
        , Style (rgb 107 178 140) False
        , Style (rgb 159 190 87) False
        , Style (rgb 210 179 63) False
        , Style (rgb 231 126 49) False
        , Style (rgb 217 33 32) True
        ]


colorBrewerPinkYellowGreen : Array Style
colorBrewerPinkYellowGreen =
    fromList
        [ Style (rgb 197 27 125) True
        , Style (rgb 222 119 174) False
        , Style (rgb 241 182 218) False
        , Style (rgb 253 224 239) False
        , Style (rgb 230 245 208) False
        , Style (rgb 184 225 134) False
        , Style (rgb 127 188 65) False
        , Style (rgb 77 146 33) True
        ]


allStyles : Array Style
allStyles =
    colorBrewerPinkYellowGreen
        |> Array.append tolQualitative


defaultStyle : Style
defaultStyle =
    Style Color.white False


nthStyle : Int -> Style
nthStyle n =
    let
        index : Int
        index =
            n % length allStyles
    in
        get index allStyles
            |> withDefault defaultStyle


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
