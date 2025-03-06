module Components.Header exposing (view)

import Html exposing (Html)
import Html.Attributes as HA
import Svg 
import Svg.Attributes as SA


view : Html msg
view =
    Html.header
        [ HA.class "bg-bgDark sticky top-0 w-full z-50 lg:px-0 px-4" ]
        [ Html.div
            [ HA.class "flex justify-between max-w-maxWidth m-auto" ]
            [ Html.h1
                [ HA.class "font-logo text-primary font-medium content-center py-2 lg:text-6xl sm:text-5xl text-3xl" ]
                [ Html.text "ArtMorph" ]
            , viewNavigation
            ]
        ]


viewNavigation : Html msg
viewNavigation =
    let
        hamburgerIcon =
             Svg.svg
                [ SA.fill "none"
                , SA.viewBox "0 0 24 24"
                , SA.strokeWidth "1.5"
                , SA.stroke "#EC5001"
                , SA.class "sm:hidden size-12"
                ]
                [ Svg.path
                    [ SA.strokeLinecap "round"
                    , SA.strokeLinejoin "round"
                    , SA.d "M3.75 6.75h16.5M3.75 12h16.5m-16.5 5.25h16.5"
                    ]
                    []
                ]
    in
    Html.nav
        [ HA.class "max-w-fit content-center" ]
        [ hamburgerIcon
        , Html.ul
            [ HA.class "grid sm:grid-cols-3 auto-cols-max sm:static absolute left-full bg-bgDark" ]
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
            [ HA.class "block p-4 text-base font-title text-primary font-bold hover:cursor-pointer   underline-offset-2 hover:underline focus-within:underline"
            , HA.href path
            ]
            [ Html.text label
            ]
        ]
