module Pages.HomePage exposing (..)

import Components.UI
import Html exposing (Html, a, article, div, figure, h2, h3, h4, img, li, p, section, span, text, ul)
import Html.Attributes exposing (class, href, src)


type alias Model =
    { title : String
    }


type Msg
    = MsgSignUpToNewsletter


initModel : Model
initModel =
    { title = "About"
    }


view : Model -> Html Msg
view _ =
    div [ class "bg-bgLight" ]
        [ viewHero
        , viewWelcome
        , viewExhibitions
        , viewPictureOfTheMonth
        , viewArtist
        , Components.UI.viewNewsletter MsgSignUpToNewsletter
        ]


viewHero : Html msg
viewHero =
    section [ class "pt-32 bg-bgDark relative z-0" ]
        [ Components.UI.bgTextSecondary
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
            [ Components.UI.titleDark "Welcome to Artmorph"
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
            [ Components.UI.titleDark "Featured Exhibitions"
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
        [ viewFilterButton "Digital"
        , viewFilterButton "Olja"
        , viewFilterButton "Akryl"
        , viewFilterButton "Akvarell"
        ]


viewFilterButton : String -> Html msg
viewFilterButton btnText =
    li [ class "px-4 py-2 border-secondary border-2 grid place-content-center rounded-full font-bread font-bold text-sm tracking-wide h-fit" ]
        [ text btnText ]


viewExhibitionCard : Html msg
viewExhibitionCard =
    li [ class "grid gap-0.5" ]
        [ img [ src "https://images.unsplash.com/photo-1460661419201-fd4cecdf8a8b?q=80&w=1760&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", class "max-w-96" ] []
        , Components.UI.link "/exhibition" "Title "
        ]


viewPictureOfTheMonth : Html msg
viewPictureOfTheMonth =
    section [ class "bg-bgDark py-16 relative z-0" ]
        [ Components.UI.bgTextSecondary
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
        [ Components.UI.titleDark "The Minds Behind the Masterpieces"
        , ul [ class "flex overflow-hidden justify-between" ]
            [ Components.UI.viewArtistCard
            , Components.UI.viewArtistCard
            , Components.UI.viewArtistCard
            , Components.UI.viewArtistCard
            , Components.UI.viewArtistCard
            , Components.UI.viewArtistCard
            ]
        ]


update msg model =
    case msg of
        MsgSignUpToNewsletter ->
            ( model, Cmd.none )
