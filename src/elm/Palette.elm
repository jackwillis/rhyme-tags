module Palette exposing (Color, nthColor)

import Array exposing (Array, fromList, get, length)
import Maybe exposing (withDefault)


type alias Color =
    String


tolQualitative : Array Color
tolQualitative =
    Array.fromList [ "#332288", "#6699cc", "#88ccee", "#44aa99", "#117733", "#999933", "#ddcc77", "#661100", "#cc6677", "#aa4466", "#882255", "#aa4499" ]


allPalettes : Array Color
allPalettes =
    tolQualitative


nthColor : Int -> Color
nthColor n =
    let
        index =
            n % length allPalettes
    in
        get index allPalettes |> withDefault ""
