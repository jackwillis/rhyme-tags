module Document.View exposing (displayResult)

{-| This module contains the view function `displayResult`,
which builds the contents of the output column,
and its associated helper functions,
notably all functions related to color.

@docs displayResult

-}

import Array exposing (Array, length)
import Char
import Color exposing (Color, rgb, black, white)
import Color.Convert as Convert
import Document exposing (Node(Text, Rhyme), Document, Tag)
import Document.Parser as Parser
import Html exposing (Html, div, text, span, ul, li, h3)
import Html.Attributes exposing (class, style, title)
import Html.Lazy exposing (lazy)


{-| This view generates the contents of the output column.
-}
displayResult : Result (List Parser.Error) Document -> Html a
displayResult result =
    case result of
        Err errors ->
            displayErrors errors

        Ok document ->
            displayDocument document


{-| Displays a list of parser errors.
-}
displayErrors : List Parser.Error -> Html a
displayErrors errors =
    let
        displayError : Parser.Error -> Html a
        displayError err =
            li [] [ text (Basics.toString err) ]
    in
        div []
            [ h3 [] [ text "Errors:" ]
            , ul [] (errors |> List.map displayError)
            ]


type alias ColorScheme =
    { backgroundColor : Color
    , textColor : Color
    }


tolQualitative : Array ColorScheme
tolQualitative =
    Array.fromList
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
    Array.fromList
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
    Array.fromList
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
        Array.get index allSchemes
            |> Maybe.withDefault defaultScheme


toStyleAttribute : ColorScheme -> Html.Attribute a
toStyleAttribute scheme =
    style
        [ ( "backgroundColor", scheme.backgroundColor |> Convert.colorToCssRgba )
        , ( "color", scheme.textColor |> Convert.colorToCssRgba )
        ]


displayDocument : Document -> Html a
displayDocument document =
    let
        indexOf : Tag -> Maybe Int
        indexOf =
            Document.indexOfTag document

        getScheme : Tag -> ColorScheme
        getScheme tag =
            tag
                |> indexOf
                |> Maybe.map nthScheme
                |> Maybe.withDefault defaultScheme

        hoverText : Tag -> String -> String
        hoverText tag text =
            let
                groupName : String
                groupName =
                    tag |> indexOf |> Maybe.withDefault 0 |> toString
            in
                String.concat
                    [ "'"
                    , text
                    , "' is in group "
                    , groupName
                    , " (rhymes with '"
                    , tag
                    , ".')"
                    ]

        displayNode : Node -> Html a
        displayNode node =
            case node of
                Text { text } ->
                    Html.text text

                Rhyme { tag, text } ->
                    span
                        [ class "rhyme"
                        , toStyleAttribute <| getScheme <| tag
                        , title <| hoverText tag text
                        ]
                        [ Html.text text ]

        styledNodes : List (Html a)
        styledNodes =
            document.nodes |> List.map (lazy displayNode)
    in
        div [] styledNodes
