module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Markup exposing (ParseResult, parse)
import Helpers exposing (displayResult)
import Examples exposing (thingsYouCanDo)


type alias Model =
    { text : String, result : ParseResult }


init : ( Model, Cmd Msg )
init =
    ( Model thingsYouCanDo (parse thingsYouCanDo), Cmd.none )


type Msg
    = UpdateText String


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
                [ h2 [] [ text "Settings" ]
                , p []
                    [ text "Read "
                    , a [ href "https://github.com/jackwillis/rhyme-tags" ] [ text "usage information" ]
                    , text " for rhyme-tags."
                    ]
                ]
            ]
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateText text ->
            ( { model | text = text, result = parse text }, Cmd.none )


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
