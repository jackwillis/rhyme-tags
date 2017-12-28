module Main exposing (main)

import Array
import Dialog
import Document exposing (Document)
import Document.Example as Example exposing (Example)
import Document.Parser as Parser
import Document.View as Document
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (on, onInput, onClick)
import Json.Decode as Json
import String.Extra as String


type alias Model =
    { text : String
    , parseResult : Result (List Parser.Error) Document
    , inputRows : Int
    , selectedExample : Maybe Int
    , showHelpDialog : Bool
    }


blankModel : Model
blankModel =
    { text = ""
    , parseResult = Ok (Document [])
    , inputRows = 2
    , selectedExample = Just 0
    , showHelpDialog = True
    }


setText : String -> Model -> Model
setText text model =
    let
        lineCount =
            String.countOccurrences "\n" text

        numRows =
            Basics.max 20 (lineCount + 2)
    in
        { model
            | text = text
            , parseResult = text |> Parser.parse
            , inputRows = numRows
        }


initText : String
initText =
    Example.helpText |> .body


init : ( Model, Cmd Msg )
init =
    ( blankModel |> setText initText, Cmd.none )


type Msg
    = UpdateText String
    | SelectExample (Maybe Int)
    | LoadExample
    | OpenHelpDialog
    | CloseHelpDialog


exampleSelector : (Maybe Int -> msg) -> Html msg
exampleSelector tagger =
    let
        optionFor : Int -> Example -> Html a
        optionFor n example =
            option [ value (toString n) ] [ text example.title ]

        options : List (Html a)
        options =
            Example.all
                |> Array.indexedMap optionFor
                |> Array.toList

        decoder : Json.Decoder msg
        decoder =
            Html.Events.targetValue
                |> Json.map String.toInt
                |> Json.map Result.toMaybe
                |> Json.map tagger
    in
        select [ on "change" decoder ] options


displayParseResult : Result (List Parser.Error) Document -> Html a
displayParseResult result =
    case result of
        Err errors ->
            displayErrors errors

        Ok document ->
            Document.view document


displayErrors : List Parser.Error -> Html a
displayErrors errors =
    let
        displayError : Parser.Error -> Html a
        displayError error =
            li [] [ text (error |> toString) ]
    in
        div []
            [ h3 [] [ text "Errors:" ]
            , ul [] (errors |> List.map displayError)
            ]


helpDialog : Model -> Html Msg
helpDialog model =
    let
        config =
            { closeMessage = Just CloseHelpDialog
            , containerClass = Nothing
            , header = Just (h3 [] [ text "Help" ])
            , body = Just (text ("gfdfgd."))
            , footer = Just (text "Dd")
            }
    in
        Dialog.view
            (if model.showHelpDialog then
                Just config
             else
                Nothing
            )


view : Model -> Html Msg
view model =
    div [ id "wrapper" ]
        [ header []
            [ h1 []
                [ text "rhyme-tags" ]
            ]
        , div [ id "columns" ]
            [ div [ id "input-column" ]
                [ textarea
                    [ id "input"
                    , onInput UpdateText
                    , value model.text
                    , rows model.inputRows
                    , autocomplete False
                    ]
                    []
                ]
            , div [ id "output-column" ]
                [ div [ id "output" ]
                    [ displayParseResult model.parseResult ]
                ]
            ]
        , model |> helpDialog
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateText text ->
            ( model |> setText text, Cmd.none )

        SelectExample num ->
            ( { model | selectedExample = num }, Cmd.none )

        LoadExample ->
            let
                maybeExample : Maybe Example
                maybeExample =
                    model.selectedExample
                        |> Maybe.andThen (\num -> Example.all |> Array.get num)
            in
                case maybeExample of
                    Just example ->
                        ( model |> setText example.body, Cmd.none )

                    Nothing ->
                        ( model |> setText "Unable to load example.", Cmd.none )

        OpenHelpDialog ->
            ( { model | showHelpDialog = True }, Cmd.none )

        CloseHelpDialog ->
            ( { model | showHelpDialog = False }, Cmd.none )


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }
