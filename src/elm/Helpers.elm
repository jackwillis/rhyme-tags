module Helpers exposing (displayResult)

import Dict exposing (Dict)
import Html exposing (Html, div, text, strong, pre)
import Html.Attributes exposing (class, style)
import Types exposing (Node(..), Document, Tag, rhymeTags)
import Palette exposing (Color, nthColor)
import Markup exposing (ParseResult)


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


displayDocument : Document -> Html a
displayDocument document =
    let
        tagPalette : Dict Tag Color
        tagPalette =
            document
                |> rhymeTags
                |> List.indexedMap (\i tag -> ( tag, nthColor i ))
                |> Dict.fromList

        getColor : Tag -> Color
        getColor tag =
            tagPalette |> Dict.get tag |> Maybe.withDefault ""

        displayNode : Node -> Html a
        displayNode node =
            case node of
                Text { text } ->
                    Html.text text

                Rhyme { tag, text } ->
                    strong [ style [ ( "color", getColor tag ) ] ] [ Html.text text ]
    in
        pre [ class "document" ] (List.map displayNode document.nodes)
