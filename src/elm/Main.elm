module Main exposing (main)

import Array exposing (Array)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import DocumentParser exposing (ParseResult, parse)
import DocumentView exposing (displayResult)
import Data.Examples exposing (Example, thingsYouCanDo, allExamples)


type alias Model =
    { text : String, result : ParseResult }


init : ( Model, Cmd Msg )
init =
    ( Model thingsYouCanDo.body (parse thingsYouCanDo.body), Cmd.none )


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
            [ div []
                [ h2 [] [ text "Input" ]
                , textarea [ onInput UpdateText ] [ text model.text ]
                ]
            , div []
                [ h2 [] [ text "Output" ]
                , div [ class "output" ] [ displayResult model.result ]
                ]
            , div []
                [ h2 [] [ text "Documentation" ]
                , p []
                    [ text "Read "
                    , a [ href "https://github.com/jackwillis/rhyme-tags" ] [ text "usage information" ]
                    , text " for rhyme-tags."
                    ]
                , h2 [] [ text "Examples" ]
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
