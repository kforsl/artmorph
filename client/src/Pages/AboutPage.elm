module Pages.AboutPage exposing (..)

import Html exposing (Html, div, h1)


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
        [ h1 [] [ Html.text "AboutPage" ]
        ]
