import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick, on)
import Json.Decode as Decode


main =
  Browser.sandbox { init = init, update = update, view = view }


-- MODEL

type alias Model = {
    counter : Int
    }

init : Model
init =
  { counter = 0 }


-- UPDATE

type Msg =
    Increment
    | Decrement
    | UpdateRating Int
    | UpdateCounter Int

update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment ->
      {model | counter = model.counter + 1}

    Decrement ->
      {model | counter = model.counter - 1}

    UpdateRating r -> Debug.log (String.fromInt r) model

    UpdateCounter c ->
      {model | counter = c}




-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ button [ onClick Decrement ] [ text "-" ]
    , div [] [ text (String.fromInt model.counter) ]
    , button [ onClick Increment ] [ text "+" ]
    , viewRating
    , viewCounter
    ]

viewCounter : Html Msg
viewCounter = Html.node "my-counter" [on "message" decodeCounterUpdated] []

decodeCounterUpdated : Decode.Decoder Msg
decodeCounterUpdated =
    Decode.map UpdateCounter <| Decode.at [ "detail" ] <| Decode.int

viewRating : Html Msg
viewRating = Html.node "my-rating" [on "onRatingUpdated" decodeRatingUpdated] []

decodeRatingUpdated : Decode.Decoder Msg
decodeRatingUpdated =
    Decode.map UpdateRating <| Decode.at [ "detail", "value" ] <| Decode.int

