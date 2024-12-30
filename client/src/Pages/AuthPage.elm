module Pages.AuthPage exposing (..)

import Html exposing (Html, div, h1)
import Html.Attributes exposing (class)


type alias Model =
    { title : String
    }


initModel : Model
initModel =
    { title = "About"
    }


view : model -> Html msg
view _ =
    div [ class "pt-44" ]
        [ h1 [] [ Html.text "AuthPage" ]
        ]
