module DocumentView exposing (displayResult, nthLetter)

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


displayDocument : Document -> Html a
displayDocument document =
    let
        tagPalette : Dict Tag ColorString
        tagPalette =
            document
                |> tags
                |> List.indexedMap (\i tag -> ( tag, nthColor i ))
                |> Dict.fromList

        getColor : Tag -> ColorString
        getColor tag =
            tagPalette |> Dict.get tag |> Maybe.withDefault ""

        getMark : Tag -> String
        getMark tag =
            nthLetter 3 |> Maybe.map String.fromChar |> Maybe.withDefault ""

        displayNode : Node -> Html a
        displayNode node =
            case node of
                Text { text } ->
                    Html.text text

                Rhyme { tag, text } ->
                    span [ style [ ( "color", getColor tag ) ] ]
                        [ Html.text text
                        , Html.text (getMark tag)
                        ]
    in
        pre [ class "document" ] (List.map displayNode document.nodes)
