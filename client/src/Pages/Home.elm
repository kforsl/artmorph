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
    , newsletterModel : Components.Newsletter.Model
    }


initModel : Model
initModel =
    { artistData = []
    , artworkData = []
    , exhibitionData = []
    , newsletterModel = Components.Newsletter.initModel
    }


type Msg
    = MsgNewsletterSubmit Components.Newsletter.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MsgNewsletterSubmit msgArtworkPage ->
            let
                ( newNewsletterModel, cmdNewsletter ) =
                    Components.Newsletter.update msgArtworkPage Components.Newsletter.initModel
            in
            ( { model | newsletterModel = newNewsletterModel } , Cmd.map MsgNewsletterSubmit cmdNewsletter )


view : Model -> Html Msg
view model =
    Html.main_ [ HA.class "bg-bgLight" ]
        [ viewHero
        , viewWelcome
        , viewExhibitions model.exhibitionData
        , viewPictureOfTheMonth model.artworkData
        , viewArtist model.artistData
        , Html.map MsgNewsletterSubmit (Components.Newsletter.view model.newsletterModel)
        ]


viewHero : Html Msg
viewHero =
    Html.section
        [ HA.class " bg-bgDark relative z-0 h-3/4 bg-text" ]
        [ Html.div
            [ HA.class "max-w-maxWidth h-full m-auto grid md:grid-cols-12 grid-cols-7 md:grid-rows-2 grid-rows-3 gap-4 px-4" ]
            [ Html.img
                [ HA.src "https://artmorph-images.s3.eu-north-1.amazonaws.com/home-hero.png"
                , HA.class "object-contain max-h-full overflow-hidden rounded md:col-span-5 sm:col-span-4 col-span-6 md:row-start-1 row-span-2 self-end row-start-2 md:col-start-1 col-start-1"
                ]
                []
            , Html.img
                [ HA.src "https://artmorph-images.s3.eu-north-1.amazonaws.com/home-secondary-hero.png"
                , HA.class "object-contain z-10 max-h-full rounded md:col-span-3 sm:col-span-2 md:col-start-5 col-start-5 md:row-start-2 row-start-3 w-full col-span-3"
                ]
                []
            , Html.figure
                [ HA.class "rows-start-2 opacity-50 bg-primary h-1/3 col-start-1 md:row-start-2 row-start-3 md:col-end-8 col-end-7 relative before:absolute before:h-full before:w-screen before:-right-0 before:bg-primary" ]
                []
            , Html.h2
                [ HA.class "lg:text-4xl md:text-2xl text-2xl col-span-7 md:col-start-6 col-start-1 row-start-1 text-primary flex flex-col justify-center gap-6 text-nowrap self-end " ]
                [ Html.span
                    [ HA.class "font-title" ]
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
        [ HA.class "max-w-maxWidth m-auto sm:pt-12 sm:pb-24 grid sm:grid-cols-12 sm:gap-0 gap-4 grid-cols-6 border-b-2 border-bgDark md:px-4 px-4 py-8" ]
        [ Html.img
            [ HA.src "https://artmorph-images.s3.eu-north-1.amazonaws.com/welcome.png"
            , HA.class "w-full sm:col-span-5 col-span-6 rounded"
            ]
            []
        , Html.section
            [ HA.class "sm:p-4 sm:col-span-7 col-span-6" ]
            [ Html.h2
                [ HA.class "font-title sm:text-3xl text-xl mb-8 text-textDark col-span-full" ]
                [ Html.text "Welcome to Artmorph" ]
            , Html.p
                [ HA.class "sm:text-base text-sm sm:mb-4 mb-2 leading-7 p-2" ]
                [ Html.text "Art is a living, breathing force — constantly shifting, transforming, and telling new stories. At Artmorph, we curate immersive online exhibitions that celebrate this evolution. From the echoes of history to the boundless realms of imagination, each collection invites you to see the world through a new artistic lens. Explore, experience, and let creativity reshape your perspective." ]
            , Html.a
                [ HA.href "/about"
                , HA.class "underline underline-offset-2 text-primary cursor-pointer text-base p-2 hover:opacity-80 focus-within:opacity-80"
                ]
                [ Html.text "Discover More About Us" ]
            ]
        ]


viewExhibitions : List Exhibition -> Html Msg
viewExhibitions exhibitions =
    Html.article
        [ HA.class "max-w-maxWidth m-auto py-24" ]
        [ Html.section
            [ HA.class "flex flex-wrap justify-between" ]
            [ Html.h2
                [ HA.class "font-title md:text-3xl text-2xl mb-4 text-textDark col-span-full" ]
                [ Html.text "Featured Exhibitions" ]
            , Html.a
                [ HA.href "/exhibitions"
                , HA.class "place-self-center text-nowrap sm:text-base text-sm h-fit py-2.5 px-4 bg-primary   rounded-2xl font-bold hover:opacity-80 focus-within:opacity-80"
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
                [ HA.class "bg-bgDark sm:py-24 px-4 py-8 relative z-0 bg-text" ]
                [ Html.figure
                    [ HA.class "max-w-maxWidth m-auto grid place-content-center relative p-1 hover:opacity-80 focus-within:opacity-80" ]
                    [ Html.h2
                        [ HA.class "font-title md:text-4xl text-2xl mb-8 text-primary text-center" ]
                        [ Html.text "Picture of the month" ]
                    , Html.img
                        [ HA.src artwork.imageUrl
                        , HA.class "mb-8 m-auto rounded"
                        ]
                        []
                    , Html.p
                        [ HA.class "md:text-3xl text-xl cursor-pointer text-primary mb-4 text-center"
                        ]
                        [ Html.text artwork.title ]
                    , Html.p
                        [ HA.class "md:text-xl text-lg text-primary mb-4 text-center cursor-pointer"
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
        [ HA.class "max-w-maxWidth w-full m-auto py-16 border-b-2 border-bgDark px-4 py-8" ]
        [ Html.h2
            [ HA.class "font-title sm:text-3xl text-xl mb-8 text-textDark col-span-full" ]
            [ Html.text "The Minds Behind the Masterpieces" ]
        , Html.ul
            [ HA.class "flex md:flex-nowrap flex-wrap overflow-hidden justify-evenly" ]
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
