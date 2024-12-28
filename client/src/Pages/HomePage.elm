module Pages.HomePage exposing (..)

import Html exposing (Html, div, h1, h5, h6, section, text)
import Html.Attributes exposing (class)


type alias Model =
    { title : String
    }


initModel : Model
initModel =
    { title = "About"
    }


view : model -> Html msg
view model =
    div []
        [ h1 [] [ text "Home page" ]
        ]
