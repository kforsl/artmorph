module Components.Newsletter exposing (view)

import Html exposing (Html)
import Html.Attributes as HA
import Html.Events as HE


view : Html msg
view =
    Html.article
        [ HA.class "max-w-maxWidth m-auto py-16 grid grid-cols-2 gap-4" ]
        [ Html.h2
            [ HA.class "font-title text-3xl col-span-full" ]
            [ Html.text "Your Journey Into Art Begins Here" ]
        , Html.img
            [ HA.src "https://images.unsplash.com/photo-1460661419201-fd4cecdf8a8b?q=80&w=1760&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
            , HA.class "max-w-full aspect-video"
            ]
            []
        , Html.section
            [ HA.class "py-4" ]
            [ Html.h3
                [ HA.class "font-bread font-medium text-xl leading-relaxed mb-4" ]
                [ Html.text "Whether you’re a collector, an admirer, or an artist, ArtMorph is a space for discovery and connection. Let’s shape the future of art together." ]
            , Html.p
                [ HA.class "font-bread text-base font-regular leading-normal mb-4" ]
                [ Html.text "Stay updated with the latest exhibitions, featured artists, and exclusive content delivered straight to your inbox." ]
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