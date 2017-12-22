module DocumentView exposing (displayResult)

import Array exposing (Array, fromList, append, get, length)
import Char
import Color exposing (Color, rgb, black, white)
import Color.Convert as Convert
import Document exposing (Node(Text, Rhyme), Document, Tag)
import Html exposing (Html, div, text, span, ul, li)
import Html.Attributes exposing (class, style, title)


displayResult : Result (List String) Document -> List (Html a)
displayResult result =
    case result of
        Err errors ->
            displayErrors errors

        Ok document ->
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
    -- Note: 65 = 'A' in Unicode
    -- Expects input in range [1, 26]
    if 0 < n && n <= 26 then
        Just <| Char.fromCode <| 65 + (n - 1)
    else
        Nothing



-- digitsInBase 10 1196 == [1, 1, 9, 6]
-- digitsInBase 16 1196 == [4, 10, 12]
-- digitsInBase  2 1196 == [1, 0, 0, 1, 0, 1, 0, 1, 1, 0, 0]


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
    (n + 1)
        |> digitsInBase 26
        |> List.map nthLatinLetter
        |> removeNothings
        |> String.fromList


type alias ColorScheme =
    { backgroundColor : Color
    , textColor : Color
    }


tolQualitative : Array ColorScheme
tolQualitative =
    fromList
        [ ColorScheme (rgb 51 34 136) white
        , ColorScheme (rgb 102 153 204) black
        , ColorScheme (rgb 136 204 238) black
        , ColorScheme (rgb 68 170 153) black
        , ColorScheme (rgb 17 119 51) white
        , ColorScheme (rgb 153 153 51) black
        , ColorScheme (rgb 221 204 119) black
        , ColorScheme (rgb 102 17 0) white
        , ColorScheme (rgb 204 102 119) black
        , ColorScheme (rgb 170 68 102) white
        , ColorScheme (rgb 136 34 85) white
        , ColorScheme (rgb 170 68 153) white
        ]


tolRainbow : Array ColorScheme
tolRainbow =
    fromList
        [ ColorScheme (rgb 120 28 129) white
        , ColorScheme (rgb 64 67 153) white
        , ColorScheme (rgb 72 139 194) white
        , ColorScheme (rgb 107 178 140) black
        , ColorScheme (rgb 159 190 87) black
        , ColorScheme (rgb 210 179 63) black
        , ColorScheme (rgb 231 126 49) black
        , ColorScheme (rgb 217 33 32) white
        ]


colorBrewerPinkYellowGreen : Array ColorScheme
colorBrewerPinkYellowGreen =
    fromList
        [ ColorScheme (rgb 197 27 125) white
        , ColorScheme (rgb 222 119 174) black
        , ColorScheme (rgb 241 182 218) black
        , ColorScheme (rgb 253 224 239) black
        , ColorScheme (rgb 230 245 208) black
        , ColorScheme (rgb 184 225 134) black
        , ColorScheme (rgb 127 188 65) black
        , ColorScheme (rgb 77 146 33) white
        ]


allSchemes : Array ColorScheme
allSchemes =
    colorBrewerPinkYellowGreen
        |> Array.append tolQualitative


defaultScheme : ColorScheme
defaultScheme =
    ColorScheme white black


nthScheme : Int -> ColorScheme
nthScheme n =
    let
        index : Int
        index =
            n % length allSchemes
    in
        get index allSchemes
            |> Maybe.withDefault defaultScheme


toStyleAttribute : ColorScheme -> Html.Attribute a
toStyleAttribute scheme =
    style
        [ ( "backgroundColor", scheme.backgroundColor |> Convert.colorToCssRgba )
        , ( "color", scheme.textColor |> Convert.colorToCssRgba )
        ]


displayDocument : Document -> List (Html a)
displayDocument document =
    let
        indexOf : Tag -> Maybe Int
        indexOf =
            Document.tagIndex document

        getScheme : Tag -> ColorScheme
        getScheme tag =
            tag
                |> indexOf
                |> Maybe.map nthScheme
                |> Maybe.withDefault defaultScheme

        getMark : Tag -> String
        getMark tag =
            tag
                |> indexOf
                |> Maybe.map base26
                |> Maybe.withDefault ""

        displayNode : Node -> Html a
        displayNode node =
            case node of
                Text { text } ->
                    Html.text text

                Rhyme { tag, text } ->
                    let
                        hoverText : String
                        hoverText =
                            "'" ++ text ++ "' is in group " ++ (tag |> getMark) ++ " (rhymes with '" ++ tag ++ ".')"
                    in
                        span
                            [ class "rhyme"
                            , tag |> getScheme |> toStyleAttribute
                            , title hoverText
                            ]
                            [ Html.text text ]
    in
        document.nodes
            |> List.map displayNode
