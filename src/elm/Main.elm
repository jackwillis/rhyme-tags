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


type DialogState
    = NoDialog
    | LoadDialog
    | AboutDialog
    | HelpDialog


type alias Model =
    { text : String
    , parseResult : Result (List Parser.Error) Document
    , inputRows : Int
    , selectedExample : Maybe Int
    , openDialog : DialogState
    }


blankModel : Model
blankModel =
    { text = ""
    , parseResult = Ok (Document [])
    , inputRows = 20
    , selectedExample = Nothing
    , openDialog = NoDialog
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
    | SetOpenDialog DialogState


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


loadExample : Maybe Int -> Maybe Example
loadExample selectedExample =
    case selectedExample of
        Just index ->
            Array.get index Example.all

        Nothing ->
            Nothing


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


defaultDialog : Dialog.Config Msg
defaultDialog =
    { closeMessage = Just (SetOpenDialog NoDialog)
    , containerClass = Nothing
    , header = Nothing
    , body = Nothing
    , footer =
        Just <|
            button
                [ class "btn btn-info", onClick (SetOpenDialog NoDialog) ]
                [ text "Close" ]
    }


displayDialog : DialogState -> Html Msg
displayDialog openDialog =
    Dialog.view <|
        case openDialog of
            LoadDialog ->
                Nothing

            HelpDialog ->
                Just
                    { defaultDialog
                        | header = Just <| h3 [] [ text "Help" ]
                        , body = Just <| help
                    }

            AboutDialog ->
                Just
                    { defaultDialog
                        | header = Just <| h3 [] [ text "About rhyme-tags" ]
                        , body = Just <| about
                    }

            NoDialog ->
                Nothing


help : Html a
help =
    p []
        [ text "Usage information and source code is available on the "
        , a [ href "https://github.com/jackwillis/rhyme-tags" ]
            [ text "project website" ]
        , text "."
        ]


about : Html a
about =
    div []
        [ p []
            [ text "rhyme-tags version "
            , a [ href "https://github.com/jackwillis/rhyme-tags/releases/tag/v0.1.5" ]
                [ text "0.1.5" ]
            , text "."
            ]
        , p []
            [ text "This is free software: you can redistribute it and/or modify it under the terms of the "
            , a [ href "https://www.gnu.org/licenses/gpl-3.0.html" ] [ text "GNU General Public License" ]
            , text " as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version."
            ]
        ]


view : Model -> Html Msg
view model =
    div [ id "wrapper" ]
        [ header []
            [ h1 [] [ text "rhyme-tags" ]
            , button [ class "btn", onClick (SetOpenDialog LoadDialog) ] [ text "load" ]
            , button [ class "btn", onClick (SetOpenDialog HelpDialog) ] [ text "help" ]
            , button [ class "btn", onClick (SetOpenDialog AboutDialog) ] [ text "about" ]
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
        , displayDialog model.openDialog
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateText text ->
            ( model |> setText text, Cmd.none )

        SelectExample num ->
            ( { model | selectedExample = num }, Cmd.none )

        LoadExample ->
            case loadExample model.selectedExample of
                Just example ->
                    ( model |> setText example.body, Cmd.none )

                Nothing ->
                    ( model |> setText "Unable to load example.", Cmd.none )

        SetOpenDialog dialog ->
            ( { model | openDialog = dialog }, Cmd.none )


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }
