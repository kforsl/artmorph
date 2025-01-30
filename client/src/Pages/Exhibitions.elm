module Pages.Exhibitions exposing (..)

import Api.Exhibitions exposing (Exhibition)
import Html exposing (Html)
import Html.Attributes as HA


type alias Model =
    { exhibitionData : List Exhibition
    }


initModel : Model
initModel =
    { exhibitionData = []
    }


type Msg
    = MsgDummy


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MsgDummy ->
            ( model, Cmd.none )


view : Model -> Html Msg
view model =
    Html.div [ HA.class "max-w-svw min-h-full grid auto-rows-max place-content-between grid-cols-1 " ]
        [ Html.text "All Exhibitions Page"
        ]
