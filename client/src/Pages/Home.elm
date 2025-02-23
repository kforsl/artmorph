module Pages.Home exposing (..)

import Api.Artist exposing (Artist)
import Api.Artwork exposing (Artwork)
import Api.Exhibitions exposing (Exhibition)
import Array
import Components.Newsletter
import Html exposing (Html)
import Html.Attributes as HA


type alias Model =
    { artistData : List Artist
    , artworkData : List Artwork
    , exhibitionData : List Exhibition
    }


initModel : Model
initModel =
    { artistData = []
    , artworkData = []
    , exhibitionData = []
    }


type Msg
    = None


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        None ->
            ( model, Cmd.none )


view : Model -> Html Msg
view model =
    Html.main_ [ HA.class "bg-bgLight" ]
        [ viewHero
        , viewWelcome
        , viewExhibitions model.exhibitionData
        , viewPictureOfTheMonth model.artworkData
        , viewArtist model.artistData
        , Components.Newsletter.view
        ]


viewHero : Html Msg
viewHero =
    Html.section
        [ HA.class " bg-bgDark relative z-0 h-3/4 bg-text" ]
        [ Html.div
            [ HA.class "max-w-maxWidth h-full m-auto grid grid-cols-12 gap-8 pt-24" ]
            [ Html.figure
                [ HA.class "relative grid items-end col-span-5 after:h-32 after:w-screen after:absolute after:bg-primary after:bottom-64 after:-right-72 after:opacity-50 after:rounded-sm" ]
                [ Html.img
                    [ HA.src "https://artmorph-images.s3.eu-north-1.amazonaws.com/home-hero.png"
                    , HA.class " bg-contain overflow-hidden rounded"
                    ]
                    []
                , Html.img
                    [ HA.src "https://artmorph-images.s3.eu-north-1.amazonaws.com/home-secondary-hero.png"
                    , HA.class "absolute bottom-0 left-full ml-4 w-3/5 z-10 rounded"
                    ]
                    []
                ]
            , Html.h2
                [ HA.class "text-5xl col-span-7 text-primary flex flex-col justify-center gap-6 text-nowrap h-1/2" ]
                [ Html.span
                    [ HA.class "font-title"]
                    [ Html.text "From Past to Future" ]
                , Html.span
                    [ HA.class "text-right font-title" ]
                    [ Html.text "Imagination Unfolds" ]
                ]
            ]
        ]


viewWelcome : Html Msg
viewWelcome =
    Html.article
        [ HA.class "max-w-maxWidth m-auto pt-12 pb-24 grid grid-cols-12 border-b-2 border-bgDark" ]
        [ Html.figure
            [ HA.class "col-span-5" ]
            [ Html.img
                [ HA.src "https://artmorph-images.s3.eu-north-1.amazonaws.com/welcome.png"
                , HA.class "rounded"
                ]
                []
            ]
        , Html.section
            [ HA.class "p-4 col-span-7" ]
            [ Html.h2
                [ HA.class "font-title text-4xl mb-8 text-textDark col-span-full" ]
                [ Html.text "Welcome to Artmorph" ]
            , Html.p
                [ HA.class "  text-base mb-8 leading-7 p-2" ]
                [ Html.text "Art is a living, breathing force — constantly shifting, transforming, and telling new stories. At Artmorph, we curate immersive online exhibitions that celebrate this evolution. From the echoes of history to the boundless realms of imagination, each collection invites you to see the world through a new artistic lens. Explore, experience, and let creativity reshape your perspective." ]
            , Html.a
                [ HA.href "/about"
                , HA.class "  underline underline-offset-2 text-primary cursor-pointer text-base p-2 hover:opacity-80 focus-within:opacity-80"
                ]
                [ Html.text "Discover More About Us" ]
            ]
        ]


viewExhibitions : List Exhibition -> Html Msg
viewExhibitions exhibitions =
    Html.article
        [ HA.class "max-w-maxWidth m-auto py-24" ]
        [ Html.section
            [ HA.class "flex justify-between" ]
            [ Html.h2
                [ HA.class "font-title text-3xl mb-4 text-textDark col-span-full" ]
                [ Html.text "Featured Exhibitions" ]
            , Html.a
                [ HA.href "/exhibitions"
                , HA.class "place-self-center text-nowrap text-base h-fit py-2.5 px-4 bg-primary   rounded-2xl font-bold hover:opacity-80 focus-within:opacity-80"
                ]
                [ Html.text "Checkout all our exhibitions" ]
            ]
        , Html.ul
            [ HA.class "flex gap-4 overflow-x-scroll py-8" ]
            (List.indexedMap
                viewExhibitionCard
                exhibitions
            )
        ]


viewExhibitionCard : Int -> Exhibition -> Html Msg
viewExhibitionCard x exhibition =
    Html.li
        [ HA.class "grid gap-0.5 relative p-1 hover:opacity-80 focus-within:opacity-80"
        ]
        [ Html.img
            [ HA.src exhibition.thumbnailUrl
            , HA.class "max-w-96 object-cover object-top rounded"
            ]
            []
        , Html.p
            [ HA.class "font-title text-base overflow-hidden text-ellipsis text-nowrap"
            ]
            [ Html.text exhibition.title ]
        , Html.a
            [ HA.href ("/exhibitions/" ++ exhibition.id)
            , HA.class "absolute w-full h-full"
            ]
            []
        ]


viewPictureOfTheMonth : List Artwork -> Html Msg
viewPictureOfTheMonth artworks =
    let
        pictureOfTheMonth =
            Array.get 13 (Array.fromList artworks)
    in
    case pictureOfTheMonth of
        Just artwork ->
            Html.section
                [ HA.class "bg-bgDark py-24 relative z-0 bg-text" ]
                [ Html.figure
                    [ HA.class "max-w-maxWidth m-auto grid place-content-center relative p-1 hover:opacity-80 focus-within:opacity-80" ]
                    [ Html.h2
                        [ HA.class "font-title text-4xl mb-8 text-primary text-center" ]
                        [ Html.text "Picture of the month" ]
                    , Html.img
                        [ HA.src artwork.imageUrl
                        , HA.class "mb-8 m-auto rounded"
                        ]
                        []
                    , Html.p
                        [ HA.class "  text-3xl cursor-pointer text-primary mb-4 text-center"
                        ]
                        [ Html.text artwork.title ]
                    , Html.p
                        [ HA.class "  text-xl text-primary mb-4 text-center cursor-pointer"
                        ]
                        [ Html.text "Created by ", Html.span [] [ Html.text artwork.artist.name ] ]
                    , Html.a
                        [ HA.href ("/artwork/" ++ artwork.id)
                        , HA.class "h-full w-full absolute "
                        ]
                        []
                    ]
                ]

        Nothing ->
            Html.text ""


viewArtist : List Artist -> Html Msg
viewArtist artists =
    Html.section
        [ HA.class "max-w-maxWidth m-auto py-24 border-b-2 border-bgDark" ]
        [ Html.h2
            [ HA.class "font-title text-4xl mb-8 text-textDark col-span-full" ]
            [ Html.text "The Minds Behind the Masterpieces" ]
        , Html.ul
            [ HA.class "flex overflow-hidden justify-between" ]
            (List.map viewArtistCard artists)
        ]


viewArtistCard : Artist -> Html Msg
viewArtistCard artist =
    Html.article
        [ HA.class "max-w-44 grid gap-0.5 hover:opacity-80 relative focus-within:opacity-80 p-1" ]
        [ Html.h3
            [ HA.class "font-title text-base overflow-hidden text-ellipsis text-nowrap underline underline-offset-2"
            ]
            [ Html.text artist.name ]
        , Html.img
            [ HA.src artist.profileImgUrl
            , HA.class "rounded"
            ]
            []
        , Html.a
            [ HA.href ("/artists/" ++ artist.id)
            , HA.class "h-full w-full absolute top-0 left-0"
            ]
            []
        ]
