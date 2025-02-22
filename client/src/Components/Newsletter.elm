module Components.Newsletter exposing (view)

import Html exposing (Html)
import Html.Attributes as HA
import Html.Events as HE


view : Html msg
view =
    Html.section
        [ HA.class "max-w-maxWidth m-auto pt-24 pb-48 grid grid-cols-12 gap-8 bg-light-text" ]
        [ Html.h2
            [ HA.class "font-title text-4xl col-span-full" ]
            [ Html.text "Your Journey Into Art Begins Here" ]
        , Html.img
            [ HA.src "https://artmorph-images.s3.eu-north-1.amazonaws.com/newsletter.png"
            , HA.class "max-w-full rounded col-span-5"
            ]
            []
        , Html.section
            [ HA.class "py-4 col-span-7" ]
            [ Html.h3
                [ HA.class "font-bread font-medium text-xl leading-relaxed mb-8" ]
                [ Html.text "Stay Inspired – Get the Latest from Artmorph" ]
            , Html.p
                [ HA.class "font-bread text-base font-regular leading-7 mb-12 " ]
                [ Html.text "Art is always evolving, and so is Artmorph. Be the first to discover new exhibitions, featured artists, and exclusive insights into the world of digital curation. Sign up for our newsletter and let inspiration find you." ]
            , Html.form
                [ HA.class " w-full flex gap-4 pb-4"

                -- , HE.onSubmit msg
                ]
                [ Html.input
                    [ HA.class "w-full rounded-lg pl-2 py-2" ]
                    []
                , Html.button
                    [ HA.class "text-nowrap text-sm py-2 px-4 bg-primary rounded-2xl font-bold hover:opacity-80 focus-within:opacity-80" ]
                    [ Html.text "Subscribe Now" ]
                ]
            , Html.nav
                [ HA.class "flex justify-around" ]
                [ Html.a
                    [ HA.href "/exhibitions"
                    , HA.class "font-title text-base mb-2 overflow-hidden text-ellipsis text-nowrap underline underline-offset-2 cursor-pointer p-2 hover:text-primary focus-within:text-primary"
                    ]
                    [ Html.text "Start Exploring Exhibitions" ]
                , Html.a
                    [ HA.href "/artists"
                    , HA.class "font-title text-base mb-2 overflow-hidden text-ellipsis text-nowrap underline underline-offset-2 cursor-pointer p-2 hover:text-primary focus-within:text-primary"
                    ]
                    [ Html.text "Check out our creators" ]
                ]
            ]
        ]
