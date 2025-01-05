module Components.UI exposing (..)

import Html exposing (Html, a, article, button, figure, form, h2, h3, h5, h6, img, input, label, nav, p, section, text)
import Html.Attributes exposing (class, href, src)
import Html.Events exposing (onSubmit)


link : String -> String -> Html msg
link url linkText =
    a [ href url, class "font-title text-base overflow-hidden text-ellipsis text-nowrap underline underline-offset-2 cursor-pointer" ] [ text linkText ]


formInput : String -> Html msg
formInput labelText =
    label []
        [ text labelText
        , input
            [ class "w-full rounded-lg pl-2 py-2" ]
            []
        ]


buttonPrimary : String -> Html msg
buttonPrimary buttonText =
    button [ class "text-nowrap text-sm py-2 px-4 bg-primary rounded-2xl font-bold text-textDark" ] [ text buttonText ]


buttonSecondary : String -> Html msg
buttonSecondary buttonText =
    button [ class "text-nowrap text-sm py-2 px-4 bg-secondary rounded-2xl font-bold ml-auto w-fit text-textLight" ] [ text buttonText ]


bgTextSecondary : Html msg
bgTextSecondary =
    figure [ class "absolute bottom-0 w-full -z-[1]" ]
        [ h5 [ class "text-secondary text-center text-5xl font-title text-nowrap" ] [ text "The Art of Transformation — Beyond Boundaries. " ]
        , h6 [ class "text-secondary text-center text-sizeBg leading-none font-logo pb-4 z-0" ] [ text "ArtMorph" ]
        ]


viewArtistCard : Html msg
viewArtistCard =
    article [ class "max-w-44 grid gap-0.5" ]
        [ link "/artist" "Name of artist"
        , img [ src "https://images.unsplash.com/photo-1587116288118-56068e06763d?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" ] []
        ]


titleDark : String -> Html msg
titleDark title =
    h2 [ class "font-title text-3xl mb-4 text-textDark col-span-full" ] [ text title ]


titlePrimary : String -> Html msg
titlePrimary title =
    h2 [ class "font-title text-3xl mb-4 text-primary col-span-full" ] [ text title ]


viewNewsletter : msg -> Html msg
viewNewsletter msg =
    article [ class "max-w-maxWidth m-auto py-16 grid grid-cols-2 gap-4" ]
        [ h2 [ class "font-title text-3xl col-span-full" ]
            [ text "Your Journey Into Art Begins Here" ]
        , img
            [ src "https://images.unsplash.com/photo-1460661419201-fd4cecdf8a8b?q=80&w=1760&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", class "max-w-full aspect-video" ]
            []
        , section [ class "py-4" ]
            [ h3 [ class "font-bread font-medium text-xl leading-relaxed mb-4" ] [ text "Whether you’re a collector, an admirer, or an artist, ArtMorph is a space for discovery and connection. Let’s shape the future of art together." ]
            , p [ class "font-bread text-base font-regular leading-normal mb-4" ] [ text "Stay updated with the latest exhibitions, featured artists, and exclusive content delivered straight to your inbox." ]
            , form [ class " w-full flex gap-4 pb-4", onSubmit msg ]
                [ input [ class "w-full rounded-lg pl-2 py-2" ] []
                , button [ class "text-nowrap text-sm py-2 px-4 bg-primary rounded-2xl font-bold" ] [ text "Subscribe Now" ]
                ]
            , nav [ class "flex justify-around" ]
                [ a [ href "/exhibition", class "font-title text-base mb-2 overflow-hidden text-ellipsis text-nowrap underline underline-offset-2 cursor-pointer" ] [ text "Start Exploring" ]
                , a [ href "/contact", class "font-title text-base mb-2 overflow-hidden text-ellipsis text-nowrap underline underline-offset-2 cursor-pointer" ] [ text "Start Exploring" ]
                ]
            ]
        ]
