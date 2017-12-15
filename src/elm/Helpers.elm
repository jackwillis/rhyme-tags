module Helpers exposing (displayPoem)

import Html exposing (Html, div, text, strong)
import Types exposing (Node(..), Document)
import Markup exposing (ParseResult)


displayPoem : ParseResult -> Html a
displayPoem poem =
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
    div [] (List.map displayNode document.nodes)


displayNode : Node -> Html a
displayNode node =
    case node of
        Text { text } ->
            Html.text text

        Rhyme { tag, text } ->
            strong [] [ Html.text text ]
