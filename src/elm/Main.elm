module Main exposing (main)

import Array exposing (Array)
import ExampleData exposing (Example, aLongWalk, allExamples)
import DocumentParser exposing (ParseResult, parse)
import DocumentView exposing (displayResult)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Model =
    { text : String, result : ParseResult }


init : ( Model, Cmd Msg )
init =
    ( Model aLongWalk.body (parse aLongWalk.body), Cmd.none )


type Msg
    = UpdateText String
    | LoadExample String


exampleSelector : Html Msg
exampleSelector =
    let
        optionFor : Int -> Example -> Html a
        optionFor n example =
            option [ value (toString n) ] [ text example.title ]

        options : List (Html a)
        options =
            allExamples
                |> Array.indexedMap optionFor
                |> Array.toList
    in
        select [ onInput LoadExample ] options


getExample : String -> Maybe Example
getExample index =
    index
        |> String.toInt
        |> Result.toMaybe
        |> Maybe.andThen (\i -> Array.get i allExamples)


view : Model -> Html Msg
view model =
    div [ id "wrapper" ]
        [ header []
            [ h1 []
                [ text "rhyme-tags" ]
            ]
        , div [ id "columns" ]
            [ div [ id "control-column" ]
                [ h2 [] [ text "examples" ]
                , exampleSelector
                , h2 [] [ text "help" ]
                , p []
                    [ text "usage information and source code is available on the "
                    , a [ href "https://github.com/jackwillis/rhyme-tags" ] [ text "project website" ]
                    , text "."
                    ]
                , h2 [] [ text "about" ]
                , p []
                    [ text "rhyme-tags is free software released under the GNU "
                    , a [ href "https://www.gnu.org/licenses/gpl-3.0.en.html" ] [ text "General Public License" ]
                    , text ", version 3."
                    ]
                ]
            , div [ id "data-columns" ]
                [ div [ id "input-column" ]
                    [ textarea
                        [ id "input"
                        , value model.text
                        , onInput UpdateText
                        ]
                        []
                    ]
                , div [ id "output-column" ]
                    [ div [ id "output" ] (displayResult model.result) ]
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
