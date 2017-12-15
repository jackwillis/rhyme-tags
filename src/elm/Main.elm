module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Markup exposing (ParseResult, parsePoem)
import Helpers exposing (displayPoem)
import Types exposing (Work, Document, setTitle, setText)
import Examples exposing (thingsYouCanDo)


type alias Model =
    { work : Work, document : ParseResult }


init : ( Model, Cmd Msg )
init =
    ( Model thingsYouCanDo (parsePoem thingsYouCanDo.text), Cmd.none )


type Msg
    = UpdateTitle String
    | UpdateText String


view : Model -> Html Msg
view model =
    div [ class "wrapper" ]
        [ h1 [] [ text "rhyme-tags" ]
        , div [ class "columns" ]
            [ div []
                [ p [] [ text "(Read documentation for rhyme-tags)" ]
                , h2 [] [ text "Input" ]
                , input [ type_ "text", value model.work.title, onInput UpdateTitle ] []
                , br [] []
                , textarea [ onInput UpdateText ] [ text model.work.text ]
                ]
            , div []
                [ h2 [] [ text "Settings" ]
                , h2 [] [ text "Output" ]
                , p [] [ text "(Permalink)" ]
                , div [ class "output" ]
                    [ h3 [] [ text model.work.title ]
                    , displayPoem model.document
                    ]
                ]
            ]
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateTitle title ->
            ( { model | work = model.work |> setTitle title }, Cmd.none )

        UpdateText text ->
            ( { model | work = model.work |> setText text, document = parsePoem text }, Cmd.none )


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
