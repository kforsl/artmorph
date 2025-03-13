module Pages.Artist exposing (..)

import Api.Artist exposing (Artist)
import Api.Artwork exposing (Artwork)
import Html exposing (Html)
import Html.Attributes as HA


type alias Model =
    { artistData : List Artist
    , artworkData : List Artwork
    }


initModel : Model
initModel =
    { artistData = []
    , artworkData = []
    }


type Msg
    = None


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        None ->
            ( model, Cmd.none )


view : Model -> String -> Html Msg
view model id =
    let
        ( matchingArtist, otherArtists ) =
            List.partition (\x -> x.id == id) model.artistData

        artistsArtwork =
            List.filter (\artwork -> artwork.artist.id == id) model.artworkData
    in
    case List.head matchingArtist of
        Just artist ->
            Html.main_ [ HA.class "max-w-svw min-h-full grid auto-rows-max place-content-between grid-cols-1 " ]
                [ viewArtistInformation artist
                , viewArtworks artistsArtwork
                , viewOtherArtists otherArtists
                ]

        Nothing ->
            Html.text "Error Not Found"


viewArtistInformation : Artist -> Html Msg
viewArtistInformation artist =
    Html.section [ HA.class "bg-bgDark relative z-0 bg-text h-fit" ]
        [ Html.div
            [ HA.class "max-w-maxWidth m-auto grid md:grid-cols-3 gap-8 grid-cols-2 sm:py-24 px-4 py-8" ]
            [ Html.section [ HA.class "p-4 md:col-span-2 col-span-full" ]
                [ Html.h2
                    [ HA.class "font-title text-primary mb-4 lg:text-5xl sm:text-3xl text-xl" ]
                    [ Html.text artist.name ]
                , Html.p
                    [ HA.class "sm:text-base text-sm sm:mb-8 mb-4 text-textLight" ]
                    [ Html.text artist.aboutMe ]
                ]
            , Html.img 
                [ HA.src artist.profileImgUrl
                , HA.alt ("A portrait of " ++ artist.name ++ ".")

                , HA.class "md:col-span-1 col-span-full md:row-span-2 mx-auto" 
                ] 
                []
            , Html.section
                [ HA.class "grid gap-4 p-4 md:col-span-2 col-span-full sm:grid-cols-2" ]
                [ viewList "Styles" artist.styles
                , viewList "Mediums" artist.mediums
                ]
            ]
        ]


viewList : String -> List String -> Html Msg
viewList label list =
    Html.ul
        [ HA.class "flex flex-wrap gap-4" ]
        (Html.h4
            [ HA.class "mb-4 font-title w-full font-semibold text-primary lg:text-2xl sm:text-xl text-lg" ]
            [ Html.text label ]
            :: List.map viewListChip list
        )


viewListChip : String -> Html Msg
viewListChip label =
    Html.li
        [ HA.class "py-2 px-4 rounded-full bg-bgLight bg-opacity-25 w-fit h-fit sm:text-sm text-xs" ]
        [ Html.text label ]


viewArtworks : List Artwork -> Html Msg
viewArtworks artworks =
    Html.section
        [ HA.class " max-w-maxWidth m-auto py-24 grid md:grid-cols-2 gap-8" ]
        (List.indexedMap viewArtworkCard artworks)


viewArtworkCard : Int -> Artwork -> Html Msg
viewArtworkCard x artwork =
    Html.article
        [ HA.class ("grid grid-cols-2 gap-4 relative p-2 group hover:opacity-80 focus-within:opacity-80 row-span-2 md:row-start-" ++ String.fromInt (x + 1))
        ]
        [ Html.section
            [ HA.href ("/artwork/" ++ artwork.id)
            , HA.class "grid justify-between"
            , HA.classList
                [ ( "order-1", modBy 2 x == 1 )
                ]
            ]
            [ Html.h2
                [ HA.class "md:text-xl text-lg font-title font-semibold" ]
                [ Html.text artwork.title ]
            , Html.p
                [ HA.class "md:text-sm text-xs h-56 overflow-clip" ]
                [ Html.text artwork.description ]
            , Html.h3
                [ HA.class "md:text-lg md:text-base font-title underline text-center group-hover:text-primary group-focus-within:text-primary"
                ]
                [ Html.text "view Artwork" ]
            ]
        , Html.img
            [ HA.src artwork.imageUrl
            , HA.class "place-self-center"
            ]
            []
        , Html.a
            [ HA.href ("/artwork/" ++ artwork.id)
            , HA.class "absolute top-0 left-0 h-full w-full p-2"
            ]
            []
        ]


viewOtherArtists : List Artist -> Html Msg
viewOtherArtists artists =
    Html.section
        [ HA.class "max-w-maxWidth w-full m-auto py-16 px-4 py-8" ]
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
        [ HA.class "sm:max-w-44 max-w-36 grid gap-0.5 hover:opacity-80 relative focus-within:opacity-80 p-1" ]
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
