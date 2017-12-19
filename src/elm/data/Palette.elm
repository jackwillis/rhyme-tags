module Data.Palette exposing (ColorString, nthColor)

import Array exposing (Array, fromList, append, get, length)
import Maybe exposing (withDefault)


type alias ColorString =
    String


tolQualitative : Array ColorString
tolQualitative =
    fromList [ "#332288", "#6699cc", "#88ccee", "#44aa99", "#117733", "#999933", "#ddcc77", "#661100", "#cc6677", "#aa4466", "#882255", "#aa4499" ]


tolRainbow : Array ColorString
tolRainbow =
    fromList [ "#781c81", "#404399", "#488bc2", "#6bb28c", "#9fbe57", "#d2b33f", "#e77e31", "#d92120" ]


allPalettes : Array ColorString
allPalettes =
    tolQualitative
        |> append tolRainbow


nthColor : Int -> ColorString
nthColor n =
    let
        index =
            n % length allPalettes
    in
        get index allPalettes |> withDefault ""
