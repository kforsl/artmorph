module Components.Header exposing (..)

import Html exposing (Html, a, div, h1, header, li, nav, text, ul)
import Html.Attributes exposing (class, href)


viewHeader : Html msg
viewHeader =
    header [ class "bg-bgDark fixed top-0 w-full z-50" ]
        [ div [ class "flex justify-between   max-w-maxWidth m-auto" ]
            [ h1 [ class "text-6xl font-logo text-primary font-medium content-center py-2" ] [ text "ArtMorph" ]
            , viewNavigation
            ]
        ]


viewNavigation : Html msg
viewNavigation =
    nav [ class "max-w-fit content-center" ]
        [ ul [ class "grid grid-cols-3 auto-cols-max" ]
            [ viewLink "/" "Home"
            , viewLink "/about" "About"
            , viewLink "/exhibition" "Exhibitions"
            , viewLink "/artist" "Artist"
            , viewLink "/artwork" "Artwork"
            , viewLink "/auth" "Login"
            ]
        ]


viewLink : String -> String -> Html msg
viewLink path label =
    li [] [ a [ class "block p-4 text-base font-title text-primary font-bold hover:cursor-pointer hover:underline underline-offset-2", href path ] [ text label ] ]
