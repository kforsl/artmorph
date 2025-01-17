module Element.UI exposing (..)

import Html exposing (Html)
import Html.Attributes as HA
import Html.Events as HE


link : String -> String -> Html msg
link url linkText =
    Html.a
        [ HA.href url
        , HA.class "font-title text-base overflow-hidden text-ellipsis text-nowrap underline underline-offset-2 cursor-pointer"
        ]
        [ Html.text linkText ]


formInput : String -> Html msg
formInput labelText =
    Html.label []
        [ Html.text labelText
        , Html.input
            [ HA.class "w-full rounded-lg pl-2 py-2" ]
            []
        ]


buttonPrimary : String -> Html msg
buttonPrimary buttonText =
    Html.button
        [ HA.class "text-nowrap text-sm py-2 px-4 bg-primary rounded-2xl font-bold text-textDark" ]
        [ Html.text buttonText ]


buttonSecondary : String -> Html msg
buttonSecondary buttonText =
    Html.button
        [ HA.class "text-nowrap text-sm py-2 px-4 bg-secondary rounded-2xl font-bold ml-auto w-fit text-textLight" ]
        [ Html.text buttonText ]


bgTextSecondary : Html msg
bgTextSecondary =
    Html.figure
        [ HA.class "absolute bottom-0 w-full -z-[1]" ]
        [ Html.h5
            [ HA.class "text-secondary text-center text-5xl font-title text-nowrap" ]
            [ Html.text "The Art of Transformation — Beyond Boundaries. " ]
        , Html.h6
            [ HA.class "text-secondary text-center text-sizeBg leading-none font-logo pb-4 z-0" ]
            [ Html.text "ArtMorph" ]
        ]


viewArtistCard : Html msg
viewArtistCard =
    Html.article
        [ HA.class "max-w-44 grid gap-0.5" ]
        [ link "/artist" "Name of artist"
        , Html.img
            [ HA.src "https://images.unsplash.com/photo-1587116288118-56068e06763d?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" ]
            []
        ]


titleDark : String -> Html msg
titleDark title =
    Html.h2
        [ HA.class "font-title text-3xl mb-4 text-textDark col-span-full" ]
        [ Html.text title ]


titlePrimary : String -> Html msg
titlePrimary title =
    Html.h2
        [ HA.class "font-title text-3xl mb-4 text-primary col-span-full" ]
        [ Html.text title ]
