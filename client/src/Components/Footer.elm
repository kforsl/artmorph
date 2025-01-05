module Components.Footer exposing (viewFooter)

import Html exposing (Html, footer, h2, section, text)
import Html.Attributes exposing (class)


viewFooter : Html msg
viewFooter =
    footer [ class "p-8 bg-bgDark min-h-72 max-w-full grid auto-rows-max place-content-between grid-cols-1" ]
        [ section [ class "max-w-maxWidth m-auto w-full" ]
            [ h2 [ class "text-4xl text-primary font-logo font-medium" ] [ text "ArtMorph" ]
            ]
        , h2 [ class "text-5xl text-secondary text-center font-title" ] [ text "The Art of Transformation — Beyond Boundaries." ]
        ]
