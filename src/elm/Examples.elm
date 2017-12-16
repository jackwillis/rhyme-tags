module Examples exposing (thingsYouCanDo, thingsYouCanDoDoc)

import Types exposing (Document, Node(..))


thingsYouCanDo =
    """

Things You Can Do (Excerpt)
by Deltron 3030

Yo, Deltron { thunderforce: }, ain't no { other source: thunderforce }
Of { sunlight: }, two { ton mic: sunlight }, leave you { tongue-tied: sunlight }
Runnin' amok with { technology: } with no { apology: technology }
Shout it out to { my colony: technology } with third { eye physiology: technology }
Millennium past { apocalypse: } is { all I spit: apocalypse }
Make you { swallow it: apocalypse }, your weak style, I'll { abolish it: apocalypse }
With { nuclear rockets: } stay { glued to your optics: nuclear rockets } with sci-fi
{ Unsettlin': } man and { metal blends: unsettlin' }
Underground chillin' with the { mole man: } and his { whole fam: mole man }
Inhibit { bacterial growth: }, { material growth: bacterial growth }
Impenetrable, { incontestable: }, { indigestible: incontestable }
{ Intelligence: }, never let a computer {tell me shit: intelligence}
It's rapping { innovation: }, { penetrating: innovation }
Artificial { life forms: life forms }, who { bite songs: life forms }
I'mma { buy a Vex: }, { lye is next: buy a vex }, then I flip the { biotechs: buy a vex }

""" |> String.trim


thingsYouCanDoDoc : Document
thingsYouCanDoDoc =
    Document
        [ Text { text = "Things You Can Do (Excerpt)by Deltron 3030Yo, Deltron " }
        , Rhyme { tag = "thunderforce", text = "thunderforce" }
        , Text { text = ", ain't no " }
        , Rhyme { tag = "thunderforce", text = "other source" }
        , Text { text = "Of " }
        , Rhyme { tag = "sunlight", text = "sunlight" }
        , Text { text = ", two " }
        , Rhyme { tag = "sunlight", text = "ton mic" }
        , Text { text = ", leave you " }
        , Rhyme { tag = "sunlight", text = "tongue-tied" }
        , Text { text = "Runnin' amok with " }
        , Rhyme { tag = "technology", text = "technology" }
        , Text { text = " with no " }
        , Rhyme { tag = "technology", text = "apology" }
        , Text { text = "Shout it out to " }
        , Rhyme { tag = "technology", text = "my colony" }
        , Text { text = " with third " }
        , Rhyme { tag = "technology", text = "eye physiology" }
        , Text { text = "Millennium past " }
        , Rhyme { tag = "apocalypse", text = "apocalypse" }
        , Text { text = " is " }
        , Rhyme { tag = "apocalypse", text = "all I spit" }
        , Text { text = "Make you " }
        , Rhyme { tag = "apocalypse", text = "swallow it" }
        , Text { text = ", your weak style, I'll " }
        , Rhyme { tag = "apocalypse", text = "abolish it" }
        , Text { text = "With " }
        , Rhyme { tag = "nuclear rockets", text = "nuclear rockets" }
        , Text { text = " stay " }
        , Rhyme { tag = "nuclear rockets", text = "glued to your optics" }
        , Text { text = " with sci-fi" }
        , Rhyme { tag = "unsettlin'", text = "Unsettlin'" }
        , Text { text = " man and " }
        , Rhyme { tag = "unsettlin'", text = "metal blends" }
        , Text { text = "Underground chillin' with the " }
        , Rhyme { tag = "mole man", text = "mole man" }
        , Text { text = " and his " }
        , Rhyme { tag = "mole man", text = "whole fam" }
        , Text { text = "Inhibit " }
        , Rhyme { tag = "bacterial growth", text = "bacterial growth" }
        , Text { text = ", " }
        , Rhyme { tag = "bacterial growth", text = "material growth" }
        , Text { text = "Impenetrable, " }
        , Rhyme { tag = "incontestable", text = "incontestable" }
        , Text { text = ", " }
        , Rhyme { tag = "incontestable", text = "indigestible" }
        , Text { text = "" }
        , Rhyme { tag = "intelligence", text = "Intelligence" }
        , Text { text = ", never let a computer " }
        , Rhyme { tag = "intelligence", text = "tell me shit" }
        , Text { text = "It's rapping " }
        , Rhyme { tag = "innovation", text = "innovation" }
        , Text { text = ", " }
        , Rhyme { tag = "innovation", text = "penetrating" }
        , Text { text = "Artificial " }
        , Rhyme { tag = "life forms", text = "life forms" }
        , Text { text = ", who " }
        , Rhyme { tag = "life forms", text = "bite songs" }
        , Text { text = "I'mma " }
        , Rhyme { tag = "buy a vex", text = "buy a Vex" }
        , Text { text = ", " }
        , Rhyme { tag = "buy a vex", text = "lye is next" }
        , Text { text = ", then I flip the " }
        , Rhyme { tag = "buy a vex", text = "biotechs" }
        ]
