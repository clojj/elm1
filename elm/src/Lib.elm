module Lib exposing (..)

import List.Extra exposing (select)
import List exposing (map, concatMap, filter)

permutations_ : List a -> List (List a)
permutations_ xs_ =
    case xs_ of
        [] ->
            [ [] ]

        xs ->
            let
                f ( y, ys ) =
                    map ((::) y)  (permutations_ (filter (\x -> x /= y) ys))
            in
                concatMap f (select xs)
