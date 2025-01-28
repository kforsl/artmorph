module Components.Footer exposing (..)

import Html exposing (Html)
import Html.Attributes as HA

view : Html msg 
view = 
     Html.footer
        [ HA.class "mt-32 p-8 bg-bgDark min-h-72 max-w-full grid auto-rows-max place-content-between grid-cols-1" ]
        [ Html.section
            [ HA.class "max-w-maxWidth m-auto w-full" ]
            [ Html.h2
                [ HA.class "text-4xl text-primary font-logo font-medium" ]
                [ Html.text "ArtMorph" ]
            ]
        , Html.h2
            [ HA.class "text-5xl text-secondary text-center font-title" ]
            [ Html.text "The Art of Transformation — Beyond Boundaries." ]
        ]