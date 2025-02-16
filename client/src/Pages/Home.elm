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
        , viewExhibitions model.exhibitionData
        , viewPictureOfTheMonth model.artworkData
        , viewArtist model.artistData
        , Components.Newsletter.view
        ]


viewHero : Html msg
viewHero =
    Html.section
        [ HA.class " bg-bgDark relative z-0 h-5/6 bg-text" ]
        [ Html.div
            [ HA.class "max-w-maxWidth h-full m-auto grid gap-20 grid-cols-2 pt-24 " ]
            [ Html.figure
                [ HA.class "relative grid place-content-end after:h-1/3 after:w-screen after:absolute after:bg-primary after:bottom-1/4 after:-right-2/3 after:opacity-25" ]
                [ Html.img
                    [ HA.src "https://artmorph-images.s3.eu-north-1.amazonaws.com/home-hero.png"
                    , HA.class " bg-contain overflow-hidden"
                    ]
                    []
                , Html.img
                    [ HA.src "https://artmorph-images.s3.eu-north-1.amazonaws.com/home-secondary-hero.png"
                    , HA.class "ml-4 absolute bottom-0 left-full w-3/5 z-10"
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
                [ HA.src "https://artmorph-images.s3.eu-north-1.amazonaws.com/welcome.png"
                , HA.class ""
                ]
                []
            ]
        , Html.section
            [ HA.class "p-4" ]
            [ Html.h2
                [ HA.class "font-title text-4xl mb-8 text-textDark col-span-full" ]
                [ Html.text "Welcome to Artmorph" ]
            , Html.p
                [ HA.class "font-bread text-base mb-8" ]
                [ Html.text "Art is a living, breathing force—constantly shifting, transforming, and telling new stories. At Artmorph, we curate immersive online exhibitions that celebrate this evolution. From the echoes of history to the boundless realms of imagination, each collection invites you to see the world through a new artistic lens. Explore, experience, and let creativity reshape your perspective." ]
            , Html.a
                [ HA.href "/about"
                , HA.class "font-bread underline underline-offset-2 text-primary cursor-pointer text-base"
                ]
                [ Html.text "Discover More About Us" ]
            ]
        ]


viewExhibitions : Api.Exhibitions.Model -> Html msg
viewExhibitions exhibitions =
    Html.article
        [ HA.class "max-w-maxWidth m-auto py-16" ]
        [ Html.section
            [ HA.class "flex justify-between" ]
            [ Html.h2
                [ HA.class "font-title text-3xl mb-4 text-textDark col-span-full" ]
                [ Html.text "Featured Exhibitions" ]
            , Html.a
                [ HA.href "/exhibitions"
                , HA.class "place-self-center text-nowrap text-base h-fit py-2.5 px-4 bg-primary rounded-2xl font-bold"
                ]
                [ Html.text "View all exhibitions" ]
            ]
        , Html.ul
            [ HA.class "flex gap-4 overflow-x-scroll py-8" ]
            (List.map
                viewExhibitionCard
                exhibitions
            )
        ]


viewFilterButton : String -> Html msg
viewFilterButton btnText =
    Html.li
        [ HA.class "px-4 py-2 border-secondary border-2 grid place-content-center rounded-full font-bread font-bold text-sm tracking-wide h-fit" ]
        [ Html.text btnText ]


viewExhibitionCard : Exhibition -> Html msg
viewExhibitionCard exhibition =
    Html.li
        [ HA.class "grid gap-0.5" ]
        [ Html.img
            [ HA.src exhibition.thumbnailUrl
            , HA.class "max-w-96 aspect-square object-cover object-top"
            ]
            []
        , Html.a
            [ HA.href ("/exhibitions/" ++ exhibition.id)
            , HA.class "font-title text-base overflow-hidden text-ellipsis text-nowrap underline underline-offset-2 cursor-pointer"
            ]
            [ Html.text exhibition.title ]
        ]


viewPictureOfTheMonth : List Artwork -> Html msg
viewPictureOfTheMonth artworks =
    let
        pictureOfTheMonth =
            Array.get 13 (Array.fromList artworks)
    in
    case pictureOfTheMonth of
        Just artwork ->
            Html.section
                [ HA.class "bg-bgDark py-16 relative z-0 bg-text" ]
                [ Html.div
                    [ HA.class "max-w-maxWidth m-auto grid place-content-center" ]
                    [ Html.h2
                        [ HA.class "font-title text-3xl mb-8 text-primary text-center" ]
                        [ Html.text "Picture of the month" ]
                    , Html.img
                        [ HA.src artwork.imageUrl
                        , HA.class "mb-8 max-w-96 m-auto"
                        ]
                        []
                    , Html.a
                        [ HA.href ("/artwork/" ++ artwork.id)
                        , HA.class "font-bread text-xl underline underline-offset-2 cursor-pointer text-primary mb-4 text-center"
                        ]
                        [ Html.text artwork.title ]
                    , Html.a
                        [ HA.href ("/artists/" ++ artwork.artist.id)
                        , HA.class "font-bread text-xl text-primary mb-4 text-center underline underline-offset-2 cursor-pointer"
                        ]
                        [ Html.text ("Created by " ++ artwork.artist.name) ]
                    ]
                ]

        Nothing ->
            Html.text ""


viewArtist : Api.Artist.Model -> Html msg
viewArtist artists =
    Html.section
        [ HA.class "max-w-maxWidth m-auto py-16 border-b-2 border-black" ]
        [ Html.h2
            [ HA.class "font-title text-3xl mb-4 text-textDark col-span-full" ]
            [ Html.text "The Minds Behind the Masterpieces" ]
        , Html.ul
            [ HA.class "flex overflow-hidden justify-between" ]
            (List.map viewArtistCard artists)
        ]


viewArtistCard : Artist -> Html msg
viewArtistCard artist =
    Html.article
        [ HA.class "max-w-44 grid gap-0.5" ]
        [ Html.a
            [ HA.href ("/artists/" ++ artist.id)
            , HA.class "font-title text-base overflow-hidden text-ellipsis text-nowrap underline underline-offset-2 cursor-pointer"
            ]
            [ Html.text artist.name ]
        , Html.img
            [ HA.src artist.profileImgUrl ]
            []
        ]
