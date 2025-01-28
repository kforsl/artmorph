module Pages.Home exposing (..)

import Api.Artist exposing (Artist)
import Api.Artwork exposing (Artwork)
import Api.Exhibitions exposing (Exhibition)
import Components.Newsletter
import Html exposing (Html)
import Html.Attributes as HA


type alias Model =
    { title : String
    , artistData : List Artist
    , artworkData : List Artwork
    , exhibitionData : List Exhibition
    }


initModel : Model
initModel =
    { title = "Home Page"
    , artistData = []
    , artworkData = []
    , exhibitionData = []
    }


type Msg
    = MsgDummy


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MsgDummy ->
            ( model, Cmd.none )


view : Model -> Html Msg
view model =
    Html.main_ [ HA.class "bg-bgLight" ]
        [ viewHero
        , viewWelcome
        , viewExhibitions
        , viewPictureOfTheMonth
        , viewArtist
        , Components.Newsletter.view
        ]


viewHero : Html msg
viewHero =
    Html.section
        [ HA.class " bg-bgDark relative z-0" ]
        [ bgTextSecondary
        , Html.div
            [ HA.class "max-w-maxWidth m-auto grid gap-20 grid-cols-2 pt-24" ]
            [ Html.figure
                [ HA.class "relative max-w-md" ]
                [ Html.img
                    [ HA.src "https://images.unsplash.com/photo-1682680215210-d385fa4ea8a5?q=80&w=1935&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
                    , HA.class " bg-contain overflow-hidden"
                    ]
                    []
                , Html.img
                    [ HA.src "https://images.unsplash.com/photo-1634986666676-ec8fd927c23d?q=80&w=1935&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
                    , HA.class "ml-4 absolute bottom-0 left-full max-w-60"
                    ]
                    []
                ]
            , Html.h2
                [ HA.class "text-5xl font-title text-primary flex flex-col gap-6" ]
                [ Html.span
                    []
                    [ Html.text "The Art of" ]
                , Html.span
                    [ HA.class "text-right" ]
                    [ Html.text "Transformation" ]
                , Html.span
                    [ HA.class "text-center" ]
                    [ Html.text "Beyond Boundaries." ]
                ]
            ]
        ]


viewWelcome : Html msg
viewWelcome =
    Html.article
        [ HA.class "max-w-maxWidth m-auto py-8 grid grid-cols-2 border-b-2 border-black" ]
        [ Html.figure
            []
            [ Html.img
                [ HA.src "https://images.unsplash.com/photo-1682680215210-d385fa4ea8a5?q=80&w=1935&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
                , HA.class "w-full aspect-video"
                ]
                []
            ]
        , Html.section
            [ HA.class "p-4" ]
            [ Html.h2
                [ HA.class "font-title text-3xl mb-4 text-textDark col-span-full" ]
                [ Html.text "Welcome to Artmorph" ]
            , Html.p
                [ HA.class "font-bread text-base mb-2" ]
                [ Html.text "Where tradition meets innovation, and art takes on new forms. We are a digital platform celebrating the evolution of creativity, from timeless brushstrokes to cutting-edge digital masterpieces. Explore a gallery where boundaries fade, and imagination thrives in both physical and virtual spaces." ]
            , Html.p
                [ HA.class "font-bread text-base" ]
                [ Html.text "Discover more about our vision and journey → "
                , Html.a
                    [ HA.href "/about"
                    , HA.class "font-bread underline underline-offset-2 text-primary cursor-pointer text-base"
                    ]
                    [ Html.text "Read more about us" ]
                ]
            ]
        ]


viewExhibitions : Html msg
viewExhibitions =
    Html.article
        [ HA.class "max-w-maxWidth m-auto py-16" ]
        [ Html.section
            [ HA.class "flex justify-between" ]
            [ Html.h2
                [ HA.class "font-title text-3xl mb-4 text-textDark col-span-full" ]
                [ Html.text "Featured Exhibitions" ]
            , viewFilterExhibition
            ]
        , Html.ul
            [ HA.class "flex gap-4 overflow-hidden py-8" ]
            [ viewExhibitionCard
            , viewExhibitionCard
            , viewExhibitionCard
            , viewExhibitionCard
            ]
        ]


viewFilterExhibition : Html msg
viewFilterExhibition =
    Html.ul [ HA.class "flex gap-4" ]
        [ viewFilterButton "Digital"
        , viewFilterButton "Olja"
        , viewFilterButton "Akryl"
        , viewFilterButton "Akvarell"
        ]


viewFilterButton : String -> Html msg
viewFilterButton btnText =
    Html.li
        [ HA.class "px-4 py-2 border-secondary border-2 grid place-content-center rounded-full font-bread font-bold text-sm tracking-wide h-fit" ]
        [ Html.text btnText ]


viewExhibitionCard : Html msg
viewExhibitionCard =
    Html.li
        [ HA.class "grid gap-0.5" ]
        [ Html.img
            [ HA.src "https://images.unsplash.com/photo-1460661419201-fd4cecdf8a8b?q=80&w=1760&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
            , HA.class "max-w-96"
            ]
            []
        , Html.a
            [ HA.href "/exhibition"
            , HA.class "font-title text-base overflow-hidden text-ellipsis text-nowrap underline underline-offset-2 cursor-pointer"
            ]
            [ Html.text "Title " ]
        ]


viewPictureOfTheMonth : Html msg
viewPictureOfTheMonth =
    Html.section
        [ HA.class "bg-bgDark py-16 relative z-0" ]
        [ bgTextSecondary
        , Html.div
            [ HA.class "max-w-maxWidth m-auto" ]
            [ Html.h2
                [ HA.class "font-title text-3xl mb-8 text-primary text-center" ]
                [ Html.text "Picture of the month" ]
            , Html.img
                [ HA.src "https://images.unsplash.com/photo-1682680215210-d385fa4ea8a5?q=80&w=1935&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
                , HA.class "mb-8 max-w-96 m-auto"
                ]
                []
            , Html.h3
                [ HA.class "font-bread text-xl mb-4 text-primary text-center" ]
                [ Html.text "Title of the artwork" ]
            , Html.h4
                [ HA.class "font-bread text-xl text-primary text-center" ]
                [ Html.text "Created by ArtistName" ]
            ]
        ]


viewArtist : Html msg
viewArtist =
    Html.section
        [ HA.class "max-w-maxWidth m-auto py-16 border-b-2 border-black" ]
        [ Html.h2
            [ HA.class "font-title text-3xl mb-4 text-textDark col-span-full" ]
            [ Html.text "The Minds Behind the Masterpieces" ]
        , Html.ul
            [ HA.class "flex overflow-hidden justify-between" ]
            [ Html.article
                [ HA.class "max-w-44 grid gap-0.5" ]
                [ Html.a
                    [ HA.href "/artist"
                    , HA.class "font-title text-base overflow-hidden text-ellipsis text-nowrap underline underline-offset-2 cursor-pointer"
                    ]
                    [ Html.text "Name of artist" ]
                , Html.img
                    [ HA.src "https://images.unsplash.com/photo-1587116288118-56068e06763d?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" ]
                    []
                ]
            , Html.article
                [ HA.class "max-w-44 grid gap-0.5" ]
                [ Html.a
                    [ HA.href "/artist"
                    , HA.class "font-title text-base overflow-hidden text-ellipsis text-nowrap underline underline-offset-2 cursor-pointer"
                    ]
                    [ Html.text "Name of artist" ]
                , Html.img
                    [ HA.src "https://images.unsplash.com/photo-1587116288118-56068e06763d?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" ]
                    []
                ]
            , Html.article
                [ HA.class "max-w-44 grid gap-0.5" ]
                [ Html.a
                    [ HA.href "/artist"
                    , HA.class "font-title text-base overflow-hidden text-ellipsis text-nowrap underline underline-offset-2 cursor-pointer"
                    ]
                    [ Html.text "Name of artist" ]
                , Html.img
                    [ HA.src "https://images.unsplash.com/photo-1587116288118-56068e06763d?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" ]
                    []
                ]
            , Html.article
                [ HA.class "max-w-44 grid gap-0.5" ]
                [ Html.a
                    [ HA.href "/artist"
                    , HA.class "font-title text-base overflow-hidden text-ellipsis text-nowrap underline underline-offset-2 cursor-pointer"
                    ]
                    [ Html.text "Name of artist" ]
                , Html.img
                    [ HA.src "https://images.unsplash.com/photo-1587116288118-56068e06763d?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" ]
                    []
                ]
            , Html.article
                [ HA.class "max-w-44 grid gap-0.5" ]
                [ Html.a
                    [ HA.href "/artist"
                    , HA.class "font-title text-base overflow-hidden text-ellipsis text-nowrap underline underline-offset-2 cursor-pointer"
                    ]
                    [ Html.text "Name of artist" ]
                , Html.img
                    [ HA.src "https://images.unsplash.com/photo-1587116288118-56068e06763d?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" ]
                    []
                ]
            , Html.article
                [ HA.class "max-w-44 grid gap-0.5" ]
                [ Html.a
                    [ HA.href "/artist"
                    , HA.class "font-title text-base overflow-hidden text-ellipsis text-nowrap underline underline-offset-2 cursor-pointer"
                    ]
                    [ Html.text "Name of artist" ]
                , Html.img
                    [ HA.src "https://images.unsplash.com/photo-1587116288118-56068e06763d?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" ]
                    []
                ]
            ]
        ]


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
