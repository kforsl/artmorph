module Components.Header exposing (view)

import Html exposing (Html)
import Html.Attributes as HA


view : Html msg
view =
    Html.header
        [ HA.class "bg-bgDark sticky top-0 w-full z-50" ]
        [ Html.div
            [ HA.class "flex justify-between max-w-maxWidth m-auto" ]
            [ Html.h1
                [ HA.class "text-6xl font-logo text-primary font-medium content-center py-2" ]
                [ Html.text "ArtMorph" ]
            , viewNavigation
            ]
        ]


viewNavigation : Html msg
viewNavigation =
    Html.nav
        [ HA.class "max-w-fit content-center" ]
        [ Html.ul
            [ HA.class "grid grid-cols-3 auto-cols-max" ]
            [ viewLink "/" "Home"
            , viewLink "/about" "About"
            , viewLink "/auth" "Login"
            ]
        ]


viewLink : String -> String -> Html msg
viewLink path label =
    Html.li
        []
        [ Html.a
            [ HA.class "block p-4 text-base font-title text-primary font-bold hover:cursor-pointer hover:underline underline-offset-2"
            , HA.href path
            ]
            [ Html.text label
            ]
        ]
