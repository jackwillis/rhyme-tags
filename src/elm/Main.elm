module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Markup exposing (ParseResult, parsePoem)


type alias Model =
    { title : String
    , poem : ParseResult
    }


initPoemText : String
initPoemText =
    "{ tekst : tagh }"


init : ( Model, Cmd Msg )
init =
    ( Model "Things You Can Do" (parsePoem initPoemText), Cmd.none )


type Msg
    = UpdateTitle String
    | UpdatePoem String


displayPoem : ParseResult -> Html Msg
displayPoem poem =
    div [] [ text (Basics.toString poem) ]


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Rhyme color-matching tool" ]
        , h2 [] [ text "Poem" ]
        , p [] [ text "Read documentation for rcmt" ]
        , input [ type_ "text", value model.title, onInput UpdateTitle ] []
        , br [] []
        , textarea [ onInput UpdatePoem ] [ text initPoemText ]
        , h2 [] [ text "Settings" ]
        , h2 [] [ text "Output" ]
        , h3 [] [ text model.title ]
        , displayPoem model.poem
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateTitle title ->
            ( { model | title = title }, Cmd.none )

        UpdatePoem text ->
            ( { model | poem = parsePoem text }, Cmd.none )


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
