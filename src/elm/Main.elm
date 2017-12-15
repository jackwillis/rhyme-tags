module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Markup exposing (ParseResult, parsePoem)
import Helpers exposing (displayPoem)
import Examples exposing (thingsYouCanDo)


type alias Model =
    { text : String, document : ParseResult }


init : ( Model, Cmd Msg )
init =
    ( Model thingsYouCanDo (parsePoem thingsYouCanDo), Cmd.none )


type Msg
    = UpdateText String


view : Model -> Html Msg
view model =
    div [ class "wrapper" ]
        [ h1 [] [ text "rhyme-tags" ]
        , div [ class "columns" ]
            [ div []
                [ h2 [] [ text "Input" ]
                , p [] [ text "(Read documentation for rhyme-tags)" ]
                , textarea [ onInput UpdateText ] [ text model.text ]
                ]
            , div []
                [ h2 [] [ text "Settings" ]
                , h2 [] [ text "Output" ]
                , p [] [ text "(Permalink)" ]
                , div [ class "output" ] [ displayPoem model.document ]
                ]
            ]
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateText text ->
            ( { model | text = text, document = parsePoem text }, Cmd.none )


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
