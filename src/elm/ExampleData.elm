module ExampleData exposing (..)

import Array exposing (Array)


type alias Example =
    { title : String, body : String }


thingsYouCanDo : Example
thingsYouCanDo =
    Example
        "Things You Can Do"
    <|
        String.trim """

Title: Things You Can Do (Excerpt)
Author: Deltron 3030
Year: 2000
Origin: Oakland, CA

Yo, Deltron { thunderforce: }, ain't no { other source: thunderforce }
Of { sunlight: }, two { ton mic: sunlight }, leave you { tongue-tied: sunlight }
Runnin' amok with { technology: } with no { apology: technology }
Shout it out to { my: } { colony: technology } with third { eye: my } { physiology: technology }
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

Right into the { wireless: }, your third { eye is hit: wireless } with
{ Psoriasis: wireless }, the { mightiest: wireless }, Deltron { Zero: zero }
{ Traverse: } and { purged: traverse }, the travesties, that tempts your { ear holes: zero }
The area of { distribution: }, lifts the { clueless: distribution }
My flow is like, { liquid oxygen: }, { rip it often with: liquid oxygen }
Specific impulse, { increase: } the { thrust: }, { grease: increase } the { cuts: thrust }
{ Unleash: increase } a { cluster: thrust } of { thoughts: }, I { muster: thrust }
I { talk: thoughts } to { touch ya': thrust }, and { rupture: thrust } { commercial: } { communications: }
{ Convert solar: commercial } { energy: } into { imagery: energy }
In the { mind's eye: }, { blind side: mind's eye } the { contagious: communications }
With radioactive isotopes, to { decay them: communications }
{ Atomic mass: }, they { small as fragments: atomic mass }
{ I magnetize: mag } the { avid lies: mag }, my { radiation: communications } shields
{ Reflect: }, { rejects: reflect } { Decepticons: }
Who take the truth, and { stretch it long: decepticons }, while I { bless the song: decepticons }
{ Next: } { level: } incr{ edible: level }, { metal: level } { melding: }
{ Flex: next }{ ibility: level } and my engine is { never: level } { failing: melding }

"""


harlemSweeties : Example
harlemSweeties =
    Example
        "Harlem Sweeties"
    <|
        String.trim """

Title: Harlem Sweeties
Author: Langston Hughes
Year: 1921
Origin: New York, NY

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
To cinnamon { toes: rose }.
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


realityPoem : Example
realityPoem =
    Example
        "Reality Poem"
    <|
        String.trim """

Title: Reality Poem
Author: Linton Kwesi Johnson
Year: 1979
Origin: London, England

Dis is di age af { reality: }
But some a wi a deal wid { mitalagy: }
Dis is di age af science an' { teknalagy: mitalagy }
But some a wi check fi { antiquity: reality }

W'en wi can't face { reality: }
Wi leggo wi { clarity: }
Some latch aan to { vanity: }
Some hol' { insanity: vanity }
Some get { vision: }
Start preach { relijan: vision }
But dem can't mek { decishan: vision }
W'en it come to we { fite: }
Dem can't mek { decishan: vision }
W'en it comes to wi { rites: fite }

Man
Dis is di age af { reality: }
But some a wi a deal wid { mitalagy: }
Dis is di age af science an' { teknalagy: mitalagy }
But some a wi check fi { antiquity: reality }

Dem one deh gaan outta { line: }
Dem naw live in fi wi { time: line }
Far dem she dem get { sign: line }
An' dem bline dem { eye: line }
To di lite a di worl'
An' gaan search widin
Di dark a dem doom
An' a shout 'bout { sin: }
Instead a fite fi { win: sin }

Man
Dis is di age af { reality: }
But some a wi a deal wid { mitalagy: }
Dis is di age af science an' { teknalagy: mitalagy }
But some a wi check fi { antiquity: reality }

Dis is di age af { decishan: vision }
Soh mek wi leggo { relijan: vision }
Dis is di age af { decishan: vision }
Soh mek we leggo { divishan: vision }
Dis is di age af { reality: }
Soh mek we leggo { mitalagy: }
Dis is di age of science an' { teknalagy: mitalagy }
Soh mek wi hol' di { clarity: }
Mek wi hol' di { clarity: }
Mek wi hol' di { clarity: }

    """


aLongWalk : Example
aLongWalk =
    Example
        "A Long Walk"
    <|
        String.trim """

Title: A Long Walk
Author: Jill Scott
Year: 2000
Origin: Philadelphia, PA

[Verse 1]
You're here, I'm { pleased: ee }, I really dig your compa{ ny: ee }
Your { style: I }, your { smile: I }, your { peace: ee } mentali{ ty: ee }
Lord, have mercy on { me: ee }, I was { blind: I }, now I can { see: ee }
What a king's supposed to { be: ee }, baby, I feel { free: ee }, come on and go with { me: ee }

[Refrain]
Let's take a { long: } { walk: park } around the { park: } after { dark: park }
Find a { spot: long } for us to { spark: park }
Conver{ sation: -ation }, verbal e{ lation: -ation }, stimu{ lation: -ation }
Share our situ{ ations: -ation }, temp{ tations: -ation }, edu{ cation: -ation }, relax{ ation: -ation }
Ele{ vation: -ation }, maybe we can talk about Surah 31:18

[Verse 2]
Your back{ ground: } it { ain't: } squeaky { clean: }, shit
Sometimes we all got to swim up{ stream: clean }
You ain't no { saint: ain't }, we all are { sinners: }
But you put your good foot { down: ground } and make your soul a { winner: sinners }
I respect { that: }, man you're so { phat: that }, and you're all { that: }, plus { supreme: clean }
Then you're { humble: }, man I'm { numb, yo: humble }
Your feeling, I can feel { everything: clean } that you { bring: clean }

[Refrain]
Let's take a { long: } { walk: park } around the { park: } after { dark: park }
Find a { spot: long } for us to { spark: park }
Conver{ sation: -ation }, verbal e{ lation: -ation }, stimu{ lation: -ation }
Share our situ{ ations: -ation }, temp{ tations: -ation }, edu{ cation: -ation }, relax{ ation: -ation }
Ele{ vation: -ation }, maybe we can talk about Reve{ lation: -ation } 3:17

[Bridge]
Or maybe we can see a movie
Or maybe we can see a { play: } on { Saturday: play }
Or maybe we can roll a { tree: ee } and feel the { breeze: ee } and listen to a sympho{ ny: ee }
Or maybe chill and just { be: ee }, or maybe
Maybe we can take a { cruise: roots } and { listen: } to the { Roots: }
Or maybe eat some { passion: listen } { fruit: roots }
Or maybe cry to the { blues: roots }
Or maybe we could just be silent
Come on, come on

[Refrain]
Let's take a { long: } { walk: park } around the { park: } after { dark: park }
Find a { spot: long } for us to { spark: park }
Conver{ sation: -ation }, verbal e{ lation: -ation }, stimu{ lation: -ation }
Share our situ{ ations: -ation }, temp{ tations: -ation }, edu{ cation: -ation }, relax{ ation: -ation }
Ele{ vation: -ation }, maybe we can talk about Psalms in entire{ ty: ee }

[Refrain]
Let's take a { long: } { walk: park } around the { park: } after { dark: park }
Find a { spot: long } for us to { spark: park }
Conver{ sation: -ation }, verbal e{ lation: -ation }, stimu{ lation: -ation }
Share our situ{ ations: -ation }, temp{ tations: -ation }, edu{ cation: -ation }, relax{ ation: -ation }
Ele{ vation: -ation }, maybe we can talk about Psalms in entire{ ty: ee }

[Bridge]
Or maybe we can see a movie
Or maybe we can see a { play: } on { Saturday: play }
Or maybe we can roll a { tree: ee } and feel the { breeze: ee } and listen to a sympho{ ny: ee }
Or maybe chill and just { be: ee }, or maybe
Maybe we can take a { cruise: roots } and { listen: } to the { Roots: }
Or maybe eat some { passion: listen } { fruit: roots }
Or maybe cry to the { blues: roots }
Or maybe we could just be silent
Come on, come on

[Refrain]
Let's take a long walk around the { park: } after { dark: park }
Find a spot for us to { spark: park }
{ Conversation: -ation }, verbal { elation: -ation }, { stimulation: -ation }
Share our { situations: -ation }, { temptations: -ation }, { education: -ation }, { relaxation: -ation }
Ele{ vation: -ation }, { maybe: } { baby: maybe }, maybe we can { save: maybe } the { nation: -ation }
Come on, come on

    """


freightTrain : Example
freightTrain =
    Example
        "Freight Train"
    <|
        String.trim """

Title: Freight Train
Artist: Elizabeth Cotten
Year: 1956
Origin: Chapel Hill, NC

Freight train, freight train, run so { fast: }
Freight train, freight train, run so { fast: }
Please don't tell what train I'm { on: }
They won't know what route I'm { going: on }

When I'm dead and in my { grave: }
No more good times here I { crave: grave }
Place the stones at my head and { feet: }
And tell them all I've gone to { sleep: feet }

When I die, oh bury me { deep: feet }
Down at the end of old Chestnut { Street: feet }
So I can hear Old Number { Nine: }
As she comes rolling { by: nine }

When I die, oh bury me { deep: feet }
Down at the end of old Chestnut { Street: feet }
Place the stones at my head and { feet: }
And tell them all I've gone to { sleep: feet }

Freight train, freight train, run so { fast: }
Freight train, freight train, run so { fast: }
Please don't tell what train I'm { on: }
They won't know what route I'm { going: on }

    """


allExamples : Array Example
allExamples =
    Array.fromList [ aLongWalk, freightTrain, harlemSweeties, realityPoem, thingsYouCanDo ]
