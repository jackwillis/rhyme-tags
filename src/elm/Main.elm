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
    | UpdatePoem String


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Rhyme color-matching tool" ]
        , h2 [] [ text "Poem" ]
        , p [] [ text "Read documentation for rcmt" ]
        , input [ type_ "text", value model.work.title, onInput UpdateTitle ] []
        , br [] []
        , textarea [ onInput UpdatePoem ] [ text model.work.text ]
        , h2 [] [ text "Settings" ]
        , h2 [] [ text "Output" ]
        , h3 [] [ text model.work.title ]
        , displayPoem model.document
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateTitle title ->
            ( { model | work = model.work |> setTitle title }, Cmd.none )

        UpdatePoem text ->
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
