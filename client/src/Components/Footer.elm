module Components.Footer exposing (..)

import Html exposing (Html)
import Html.Attributes as HA


view : Html msg
view =
    Html.footer
        [ HA.class "p-8 py-24 bg-bgDark min-h-96 max-w-full grid auto-rows-max place-content-between grid-cols-1 bg-footer-text relative" ]
        [ Html.section
            [ HA.class "max-w-maxWidth m-auto w-full" ]
            [ Html.h2
                [ HA.class "text-5xl text-primary font-logo font-medium" ]
                [ Html.text "ArtMorph" ]
            , Html.p
                [ HA.class "text-textLight absolute bottom-4 left-8" ]
                [ Html.text "© Copyright Artmorph - 2025" ]
            ]
        ]
