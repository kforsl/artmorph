module Pages.Exhibitions exposing (..)

import Html exposing (Html)
import Html.Attributes as HA


type alias Model =
    { title : String
    }


initModel : Model
initModel =
    { title = "Exhibitions Page"
    }


type Msg
    = MsgDummy


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MsgDummy ->
            (model, Cmd.none)


view : Model -> Html Msg
view model =
    Html.div [  HA.class "max-w-svw min-h-full grid auto-rows-max place-content-between grid-cols-1 " ]
        [ Html.text model.title
        ]
