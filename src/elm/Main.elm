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


-- MODEL


type alias Model =
    { -- Data from the left column (editor)
      text : String

    -- Height of editor in rows
    , editorHeight : Int

    -- Data for the right column (view)
    , parseResult : Result (List Parser.Error) Document

    -- Currently open dialog box, if any
    , dialog : DialogState
    }


blankModel : Model
blankModel =
    { text = ""
    , parseResult = Ok (Document [])
    , editorHeight = 20
    , dialog = NoDialog
    }


setText : String -> Model -> Model
setText text model =
    let
        lineCount =
            String.countOccurrences "\n" text

        editorHeight =
            Basics.max 20 (lineCount + 2)
    in
        { model
            | text = text
            , parseResult = Parser.parse text
            , editorHeight = editorHeight
        }


init : ( Model, Cmd Msg )
init =
    ( blankModel |> setText (.body Example.helpText), Cmd.none )



-- MESSAGES


type Msg
    = UpdateText String
    | LoadExample Int
    | OpenDialog DialogState
    | NoOp



-- DIALOG BOXES


type DialogState
    = NoDialog
    | LoadDialog
    | AboutDialog
    | HelpDialog


closeButton : Html Msg
closeButton =
    button
        [ class "btn btn-info", onClick (OpenDialog NoDialog) ]
        [ text "Close" ]


defaultConfig : Dialog.Config Msg
defaultConfig =
    { closeMessage = Just (OpenDialog NoDialog)
    , containerClass = Nothing
    , header = Nothing
    , body = Nothing
    , footer = Just closeButton
    }


exampleSelector : Html Msg
exampleSelector =
    let
        optionFor : Int -> Example -> Html a
        optionFor n example =
            option [ value (toString n) ] [ text example.title ]

        exampleOptions : List (Html a)
        exampleOptions =
            Example.all
                |> Array.indexedMap optionFor
                |> Array.toList

        decoder : Json.Decoder Msg
        decoder =
            Html.Events.targetValue
                |> Json.map String.toInt
                |> Json.map
                    (\res ->
                        case res of
                            Err err ->
                                NoOp

                            Ok num ->
                                LoadExample num
                    )

        -- This is a hack until I get it working with a Bootstrap dropdown, or something
        placeholderOption : Html a
        placeholderOption =
            option
                [ value ""
                , selected True
                , disabled True
                , hidden True
                ]
                [ text "Select an example" ]
    in
        select [ on "change" decoder ] (placeholderOption :: exampleOptions)


helpBody : Html a
helpBody =
    p []
        [ text "Usage information and source code is available on the "
        , a [ href "https://github.com/jackwillis/rhyme-tags" ]
            [ text "project website" ]
        , text "."
        ]


aboutBody : Html a
aboutBody =
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


viewDialog : DialogState -> Html Msg
viewDialog dialog =
    Dialog.view <|
        case dialog of
            LoadDialog ->
                Just
                    { defaultConfig
                        | header = Just <| h3 [] [ text "Load examples" ]
                        , body = Just exampleSelector
                    }

            HelpDialog ->
                Just
                    { defaultConfig
                        | header = Just <| h3 [] [ text "Help" ]
                        , body = Just helpBody
                    }

            AboutDialog ->
                Just
                    { defaultConfig
                        | header = Just <| h3 [] [ text "About rhyme-tags" ]
                        , body = Just aboutBody
                    }

            NoDialog ->
                Nothing



-- VIEW HELPERS


viewParseResult : Result (List Parser.Error) Document -> Html a
viewParseResult result =
    case result of
        Err errors ->
            viewErrors errors

        Ok document ->
            Document.view document


viewErrors : List Parser.Error -> Html a
viewErrors errors =
    let
        displayError : Parser.Error -> Html a
        displayError error =
            li [] [ text (error |> toString) ]
    in
        div []
            [ h3 [] [ text "Errors:" ]
            , ul [] (errors |> List.map displayError)
            ]



-- VIEW


view : Model -> Html Msg
view model =
    div [ id "wrapper" ]
        [ header []
            [ h1 [] [ text "rhyme-tags" ]
            , button [ class "btn", onClick (OpenDialog LoadDialog) ] [ text "load" ]
            , button [ class "btn", onClick (OpenDialog HelpDialog) ] [ text "help" ]
            , button [ class "btn", onClick (OpenDialog AboutDialog) ] [ text "about" ]
            ]
        , div [ id "columns" ]
            [ div [ id "input-column" ]
                [ textarea
                    [ id "input"
                    , onInput UpdateText
                    , value model.text
                    , rows model.editorHeight
                    , autocomplete False
                    ]
                    []
                ]
            , div [ id "output-column" ]
                [ div [ id "output" ]
                    [ viewParseResult model.parseResult ]
                ]
            ]
        , viewDialog model.dialog
        ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateText text ->
            ( model |> setText text, Cmd.none )

        LoadExample num ->
            let
                maybeExample : Maybe Example
                maybeExample =
                    Array.get num Example.all
            in
                case maybeExample of
                    Just example ->
                        ( model |> setText example.body, Cmd.none )

                    Nothing ->
                        ( model |> setText "Unable to load example.", Cmd.none )

        OpenDialog dialog ->
            ( { model | dialog = dialog }, Cmd.none )

        NoOp ->
            ( model, Cmd.none )


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }
