module Pages.ArtworkPage exposing (..)

import Element.Footer exposing (viewFooter)
import Element.Header exposing (viewHeader)
import Html exposing (Html)
import Html.Attributes as HA


type alias Model =
    { title : String
    }


initModel : Model
initModel =
    { title = "About"
    }


view : model -> Html msg
view _ =
    Html.div
        [ HA.class "max-w-svw min-h-full grid auto-rows-max place-content-between grid-cols-1 " ]
        [ viewHeader
        , Html.h1
            []
            [ Html.text "ArtworkPage" ]
        , viewFooter
        ]
