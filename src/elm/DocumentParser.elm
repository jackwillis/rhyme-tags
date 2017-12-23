module DocumentParser exposing (parse, Error)

import Combine exposing (ParseErr, ParseOk, Parser, many, string, end, (<$>), (<|>), (<*), (*>), (<*>))
import Combine.Char exposing (char, noneOf)
import Document exposing (Tag, Node(Text, Rhyme), Document)


stringNoneOf : List Char -> Parser s String
stringNoneOf chars =
    String.fromList <$> many (noneOf chars)


rhymeContents : Parser s String
rhymeContents =
    stringNoneOf [ ':', '{', '}' ]


textContents : Parser s String
textContents =
    stringNoneOf [ '{', '}' ]


buildRhyme : String -> String -> Node
buildRhyme text tag =
    let
        trimmedTag =
            tag |> String.trim

        trimmedText =
            text |> String.trim

        tagWithDefault =
            if trimmedTag |> String.isEmpty then
                trimmedText
            else
                trimmedTag

        -- store rhyme tags as case-insensitive, for convenience
        lowerCaseTag =
            tagWithDefault |> String.toLower
    in
        Rhyme
            { tag = lowerCaseTag
            , text = trimmedText
            }


rhyme : Parser s Node
rhyme =
    buildRhyme
        <$> (string "{" *> rhymeContents)
        <*> (string ":" *> rhymeContents <* string "}")


buildText : String -> Node
buildText text =
    Text { text = text }


text : Parser s Node
text =
    buildText <$> textContents


document : Parser s Document
document =
    Document <$> many (rhyme <|> text)


type alias Error =
    String


parse : String -> Result (List Error) Document
parse input =
    case (input |> Combine.parse document) of
        Err ( _, _, errors ) ->
            Err errors

        Ok ( _, _, doc ) ->
            Ok doc
