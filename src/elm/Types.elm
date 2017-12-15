module Types
    exposing
        ( Tag
        , Node(..)
        , Document
        , Work
        , getText
        , getTag
        , rhymeKeys
        , setTitle
        , setText
        )

import List.Extra exposing (unique)


type alias Tag =
    String



-- This data type represents a part of a poem between rhyme boundaries.


type
    Node
    -- This variant represents non-rhyming text.
    = Text { text : String }
      {-

         This variant represents rhyming text, which is marked up like this:

           "{ thrill: spill }"

         This example would be represented as:

           `Rhyme { tag = "spill", text = "thrill" }`

         The 'tag' is an arbitrary string to link that rhyme
         to others in the same group. It can be helpful to
         choose your tag as the first rhyme in that group to appear.

         For example:

             > Yo, Deltron { thunderforce: thunderforce },
             > ain't no { other source: thunderforce }
             > of { sunlight: sunlight },
             > two { ton mic: sunlight },
             > leave you { tongue-tied: sunlight }.

      -}
    | Rhyme { tag : Tag, text : String }


getText : Node -> String
getText node =
    case node of
        Text { text } ->
            text

        Rhyme { text } ->
            text


getTag : Node -> Maybe Tag
getTag node =
    case node of
        Text _ ->
            Nothing

        Rhyme { tag } ->
            Just tag



-- This structure represents a whole poem,
-- made up of Nodes which begin and end at rhyme boundaries.


type alias Document =
    { nodes : List Node }


rhymeKeys : Document -> List Tag
rhymeKeys document =
    document.nodes
        |> List.filterMap getTag
        |> unique


type alias Work =
    { title : String, author : String, text : String }


setTitle : String -> Work -> Work
setTitle title work =
    { work | title = title }


setText : String -> Work -> Work
setText text work =
    { work | text = text }
