module Components.Newsletter exposing (view)

import Html exposing (Html)
import Html.Attributes as HA
import Html.Events as HE


view : Html msg
view =
    Html.article
        [ HA.class "max-w-maxWidth m-auto pt-16 pb-48 grid grid-cols-2 gap-4 bg-light-text" ]
        [ Html.h2
            [ HA.class "font-title text-3xl col-span-full" ]
            [ Html.text "Your Journey Into Art Begins Here" ]
        , Html.img
            [ HA.src "https://artmorph-images.s3.eu-north-1.amazonaws.com/newsletter.png"
            , HA.class "max-w-full"
            ]
            []
        , Html.section
            [ HA.class "py-4" ]
            [ Html.h3
                [ HA.class "font-bread font-medium text-xl leading-relaxed mb-4" ]
                [ Html.text "Stay Inspired – Get the Latest from Artmorph" ]
            , Html.p
                [ HA.class "font-bread text-base font-regular leading-normal mb-4" ]
                [ Html.text "Art is always evolving, and so is Artmorph. Be the first to discover new exhibitions, featured artists, and exclusive insights into the world of digital curation. Sign up for our newsletter and let inspiration find you." ]
            , Html.form
                [ HA.class " w-full flex gap-4 pb-4"
                -- , HE.onSubmit msg
                ]
                [ Html.input
                    [ HA.class "w-full rounded-lg pl-2 py-2" ]
                    []
                , Html.button
                    [ HA.class "text-nowrap text-sm py-2 px-4 bg-primary rounded-2xl font-bold" ]
                    [ Html.text "Subscribe Now" ]
                ]
            , Html.nav
                [ HA.class "flex justify-around" ]
                [ Html.a
                    [ HA.href "/exhibitions"
                    , HA.class "font-title text-base mb-2 overflow-hidden text-ellipsis text-nowrap underline underline-offset-2 cursor-pointer"
                    ]
                    [ Html.text "Start Exploring Exhibitions" ]
                , Html.a
                    [ HA.href "/artists"
                    , HA.class "font-title text-base mb-2 overflow-hidden text-ellipsis text-nowrap underline underline-offset-2 cursor-pointer"
                    ]
                    [ Html.text "Check out our creators" ]
                ]
            ]
        ]