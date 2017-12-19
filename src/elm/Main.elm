module Main exposing (main)

import Array exposing (Array)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import DocumentParser exposing (ParseResult, parse)
import DocumentView exposing (displayResult)
import Data.Examples exposing (Example, aLongWalk, allExamples)


type alias Model =
    { text : String, result : ParseResult }


init : ( Model, Cmd Msg )
init =
    ( Model aLongWalk.body (parse aLongWalk.body), Cmd.none )


type Msg
    = UpdateText String
    | LoadExample String


exampleOptions : List (Html a)
exampleOptions =
    let
        optionFor n example =
            option [ value (toString n) ] [ text example.title ]
    in
        allExamples
            |> Array.indexedMap optionFor
            |> Array.toList


getExample : String -> Maybe Example
getExample index =
    index
        |> String.toInt
        |> Result.toMaybe
        |> Maybe.andThen (\i -> Array.get i allExamples)


view : Model -> Html Msg
view model =
    div [ class "wrapper" ]
        [ h1 [] [ text "rhyme-tags" ]
        , div [ class "columns" ]
            [ div [ class "output" ]
                [ h2 [] [ text "Output" ]
                , div [] [ displayResult model.result ]
                ]
            , div [ class "input" ]
                [ h2 [] [ text "Input" ]
                , textarea [ onInput UpdateText, value model.text ] []
                ]
            , div [ class "extras" ]
                [ h2 [] [ text "About" ]
                , p []
                    [ a [ href "https://github.com/jackwillis/rhyme-tags" ] [ text "rhyme-tags" ]
                    , text " is free software released under the terms of the GNU General Public License, version 3."
                    ]
                , h2 [] [ text "Load examples" ]
                , select [ onInput LoadExample ] exampleOptions
                ]
            ]
        ]


updateText : String -> Model -> Model
updateText text model =
    { model | text = text, result = parse text }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateText text ->
            ( model |> updateText text, Cmd.none )

        LoadExample num ->
            case (getExample num) of
                Just example ->
                    ( model |> updateText example.body, Cmd.none )

                Nothing ->
                    ( { model | text = "No such example #" ++ num, result = parse "" }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
