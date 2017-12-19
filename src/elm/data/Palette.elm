module Data.Palette exposing (Style, nthStyle, defaultStyle)

import Array exposing (Array, fromList, append, get, length)
import Color exposing (Color, rgb)
import Maybe exposing (withDefault)


type alias Style =
    { color : Color, isDark : Bool }


tolQualitative : Array Style
tolQualitative =
    fromList
        [ Style (rgb 51 34 136) True
        , Style (rgb 102 153 204) False
        , Style (rgb 136 204 238) False
        , Style (rgb 68 170 153) False
        , Style (rgb 17 119 51) True
        , Style (rgb 153 153 51) False
        , Style (rgb 221 204 119) False
        , Style (rgb 102 17 0) True
        , Style (rgb 204 102 119) False
        , Style (rgb 170 68 102) True
        , Style (rgb 136 34 85) True
        , Style (rgb 170 68 153) True
        ]


tolRainbow : Array Style
tolRainbow =
    fromList
        [ Style (rgb 120 28 129) True
        , Style (rgb 64 67 153) True
        , Style (rgb 72 139 194) True
        , Style (rgb 107 178 140) False
        , Style (rgb 159 190 87) False
        , Style (rgb 210 179 63) False
        , Style (rgb 231 126 49) False
        , Style (rgb 217 33 32) True
        ]


colorBrewerPinkYellowGreen : Array Style
colorBrewerPinkYellowGreen =
    fromList
        [ Style (rgb 197 27 125) True
        , Style (rgb 222 119 174) False
        , Style (rgb 241 182 218) False
        , Style (rgb 253 224 239) False
        , Style (rgb 230 245 208) False
        , Style (rgb 184 225 134) False
        , Style (rgb 127 188 65) False
        , Style (rgb 77 146 33) True
        ]


allStyles : Array Style
allStyles =
    colorBrewerPinkYellowGreen
        |> Array.append tolQualitative


defaultStyle : Style
defaultStyle =
    Style Color.white False


nthStyle : Int -> Style
nthStyle n =
    let
        index : Int
        index =
            n % length allStyles
    in
        get index allStyles
            |> withDefault defaultStyle
