module Pages.Artwork exposing (..)

import Api.Artwork exposing (Artwork)
import Html exposing (Html)
import Html.Attributes as HA


type alias Model =
    { artworkData : List Artwork
    }


initModel : Model
initModel =
    { artworkData = []
    }


type Msg
    = MsgDummy


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MsgDummy ->
            ( model, Cmd.none )


view : Model -> String -> Html Msg
view model id =
    Html.div [ HA.class "max-w-svw min-h-full grid auto-rows-max place-content-between grid-cols-1 " ]
        [ Html.text id
        ]
