module Pages.HomePage exposing (..)

import Html exposing (Html, a, article, button, div, figure, form, h2, h3, h4, h5, h6, img, input, li, nav, p, section, span, text, ul)
import Html.Attributes exposing (class, href, src)


type alias Model =
    { title : String
    }


initModel : Model
initModel =
    { title = "About"
    }


view : model -> Html msg
view _ =
    div [ class "bg-bgLight" ]
        [ viewHero
        , viewWelcome
        , viewExhibitions
        , viewPictureOfTheMonth
        , viewArtist
        , viewNewsletter
        ]


viewHero : Html msg
viewHero =
    section [ class "pt-32 bg-bgDark relative z-0" ]
        [ figure [ class "absolute bottom-0 w-full -z-[1]" ]
            [ h5 [ class "text-secondary text-center text-5xl font-title text-nowrap" ] [ text "The Art of Transformation — Beyond Boundaries. " ]
            , h6 [ class "text-secondary text-center text-sizeBg leading-none font-logo pb-4 z-0" ] [ text "ArtMorph" ]
            ]
        , div [ class "max-w-maxWidth m-auto grid gap-20 grid-cols-2 pt-24" ]
            [ figure [ class "relative max-w-md" ]
                [ img [ src "https://images.unsplash.com/photo-1682680215210-d385fa4ea8a5?q=80&w=1935&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", class " bg-contain overflow-hidden" ] []
                , img [ src "https://images.unsplash.com/photo-1634986666676-ec8fd927c23d?q=80&w=1935&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", class "ml-4 absolute bottom-0 left-full max-w-60" ] []
                ]
            , h2 [ class "text-5xl font-title text-primary flex flex-col gap-6" ] [ span [] [ text "The Art of" ], span [ class "text-right" ] [ text "Transformation" ], span [ class "text-center" ] [ text "Beyond Boundaries." ] ]
            ]
        ]


viewWelcome : Html msg
viewWelcome =
    article [ class "max-w-maxWidth m-auto py-8 grid grid-cols-2 border-b-2 border-black" ]
        [ figure []
            [ img [ src "https://images.unsplash.com/photo-1682680215210-d385fa4ea8a5?q=80&w=1935&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", class "w-full aspect-video" ] []
            ]
        , section [ class "p-4" ]
            [ h2 [ class "font-title text-3xl mb-4" ]
                [ text "Welcome to Artmorph" ]
            , p
                [ class "font-bread text-base mb-2" ]
                [ text "Where tradition meets innovation, and art takes on new forms. We are a digital platform celebrating the evolution of creativity, from timeless brushstrokes to cutting-edge digital masterpieces. Explore a gallery where boundaries fade, and imagination thrives in both physical and virtual spaces." ]
            , p [ class "font-bread text-base" ] [ text "Discover more about our vision and journey → ", a [ href "/about", class "font-bread underline underline-offset-2 text-primary cursor-pointer text-base" ] [ text "Read more about us" ] ]
            ]
        ]


viewExhibitions : Html msg
viewExhibitions =
    article [ class "max-w-maxWidth m-auto py-16" ]
        [ section [ class "flex justify-between" ]
            [ h2 [ class "font-title text-3xl mb-4" ] [ text "Featured Exhibitions" ]
            , viewFilterExhibition
            ]
        , ul [ class "flex gap-4 overflow-hidden py-8" ]
            [ viewExhibitionCard
            , viewExhibitionCard
            , viewExhibitionCard
            , viewExhibitionCard
            ]
        ]


viewFilterExhibition : Html msg
viewFilterExhibition =
    ul [ class "flex gap-4" ]
        [ li []
            [ text "Digital" ]
        , li
            []
            [ text "Olja" ]
        , li
            []
            [ text "Akryl" ]
        , li
            []
            [ text "Akvarell" ]
        ]


viewExhibitionCard : Html msg
viewExhibitionCard =
    li []
        [ img [ src "https://images.unsplash.com/photo-1460661419201-fd4cecdf8a8b?q=80&w=1760&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", class "max-w-96" ] []
        , h2 [ class "font-title underline underline-offset-2 cursor-pointer text-base" ] [ text "Title " ]
        ]


viewPictureOfTheMonth : Html msg
viewPictureOfTheMonth =
    section [ class "bg-bgDark py-16 relative z-0" ]
        [ figure [ class "absolute top-1/3 w-full -z-[1]" ]
            [ h5 [ class "text-secondary text-center text-5xl font-title text-nowrap" ] [ text "The Art of Transformation — Beyond Boundaries. " ]
            , h6 [ class "text-secondary text-center text-sizeBg leading-none font-logo pb-4 z-0" ] [ text "ArtMorph" ]
            ]
        , div [ class "max-w-maxWidth m-auto" ]
            [ h2 [ class "font-title text-3xl mb-8 text-primary text-center" ] [ text "Picture of the month" ]
            , img [ src "https://images.unsplash.com/photo-1682680215210-d385fa4ea8a5?q=80&w=1935&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", class "mb-8 max-w-96 m-auto" ] []
            , h3 [ class "font-bread text-xl mb-4 text-primary text-center" ] [ text "Title of the artwork" ]
            , h4 [ class "font-bread text-xl text-primary text-center" ] [ text "Created by ArtistName" ]
            ]
        ]


viewArtist : Html msg
viewArtist =
    section [ class "max-w-maxWidth m-auto py-16 border-b-2 border-black" ]
        [ h2 [ class "font-title text-3xl mb-4" ] [ text "The Minds Behind the Masterpieces" ]
        , ul [ class "flex overflow-hidden justify-between" ]
            [ viewArtistCard
            , viewArtistCard
            , viewArtistCard
            , viewArtistCard
            , viewArtistCard
            , viewArtistCard
            ]
        ]


viewArtistCard : Html msg
viewArtistCard =
    article [ class "max-w-44" ]
        [ h2 [ class "font-title text-base mb-2 overflow-hidden text-ellipsis text-nowrap underline underline-offset-2 cursor-pointer" ] [ text "Name of artist" ]
        , img [ src "https://images.unsplash.com/photo-1587116288118-56068e06763d?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" ] []
        ]


viewNewsletter : Html msg
viewNewsletter =
    article [ class "max-w-maxWidth m-auto py-16 grid grid-cols-2 gap-4" ]
        [ h2 [ class "font-title text-3xl col-span-full" ]
            [ text "Your Journey Into Art Begins Here" ]
        , img
            [ src "https://images.unsplash.com/photo-1460661419201-fd4cecdf8a8b?q=80&w=1760&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", class "max-w-full aspect-video" ]
            []
        , section [ class "py-4" ]
            [ h3 [ class "font-bread font-medium text-xl leading-relaxed mb-4" ] [ text "Whether you’re a collector, an admirer, or an artist, ArtMorph is a space for discovery and connection. Let’s shape the future of art together." ]
            , p [ class "font-bread text-base font-regular leading-normal mb-4" ] [ text "Stay updated with the latest exhibitions, featured artists, and exclusive content delivered straight to your inbox." ]
            , form [ class " w-full flex gap-4 pb-4" ]
                [ input [ class "w-full rounded-lg pl-2" ] []
                , button [ class "text-nowrap text-sm py-2 px-4 bg-primary rounded-2xl font-bold" ] [ text "Subscribe Now" ]
                ]
            , nav [ class "flex justify-around" ]
                [ a [ href "/exhibition", class "font-title text-base mb-2 overflow-hidden text-ellipsis text-nowrap underline underline-offset-2 cursor-pointer" ] [ text "Start Exploring" ]
                , a [ href "/contact", class "font-title text-base mb-2 overflow-hidden text-ellipsis text-nowrap underline underline-offset-2 cursor-pointer" ] [ text "Start Exploring" ]
                ]
            ]
        ]
