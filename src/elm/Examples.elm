module Examples exposing (Example, thingsYouCanDo, fatCatsBiggaFish, harlemSweeties, allExamples)

import Array exposing (Array)


type alias Example =
    { title : String, body : String }


thingsYouCanDo : Example
thingsYouCanDo =
    Example
        "Things You Can Do"
    <|
        String.trim """

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

"""


fatCatsBiggaFish : Example
fatCatsBiggaFish =
    Example
        "Fat Cats, Bigga Fish"
    <|
        String.trim """

Fat Cats, Bigga Fish (Excerpt)
by The Coup

It's almost 10 o'clock, see, I got a ball of lint for { property: }
So I slip my beanie on { sloppily: property }
And promenade out to take up a { collection: }
I got game like I read the { directions: collection }
I'm wishing that I had an auto{ mobile: }
As I feel the cold wind { rush past: }
But let me state that I'm a hustler { for real: mobile }
So you know I got the stolen { bus pass: rush past }

"""


harlemSweeties : Example
harlemSweeties =
    Example
        "Harlem Sweeties"
    <|
        String.trim """

Harlem Sweeties
by Langston Hughes

Have you dug the { spill: }
Of Sugar { Hill: spill }?
Cast your gims
On this sepia { thrill: spill }:
Brown sugar lassie,
Caramel { treat: },
Honey-gold baby
Sweet enough to { eat: treat }.
Peach-skinned girlie,
Coffee and { cream: },
Chocolate darling
Out of a { dream: cream }.
Walnut tinted
Or cocoa { brown: },
Pomegranate-lipped
Pride of the { town: brown }.
Rich cream-colored
To plum-tinted { black: },
Feminine sweetness
In Harlem’s no { lack: black }.
Glow of the quince
To blush of the { rose: rose }.
Persimmon bronze
To cinnamon { toes: toes }.
Blackberry cordial,
Virginia Dare { wine: }—
All those sweet colors
Flavor Harlem of { mine: wine }!
Walnut or cocoa,
Let me { repeat: treat }:
Caramel, brown sugar,
A chocolate { treat: }.
Molasses taffy,
Coffee and { cream: },
Licorice, clove, cinnamon
To a honey-brown { dream: cream }.
Ginger, wine-gold,
Persimmon, black{ berry: },
All through the spectrum
Harlem girls { vary: berry }—
So if you want to know beauty’s
Rainbow-sweet { thrill: spill },
Stroll down luscious,
Delicious, fine Sugar { Hill: spill }.

"""


allExamples : Array Example
allExamples =
    Array.fromList [ thingsYouCanDo, fatCatsBiggaFish, harlemSweeties ]
