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
    = MsgDummy


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MsgDummy ->
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
    Html.section [ HA.class "bg-bgDark relative z-0" ]
        [ Html.div
            [ HA.class "max-w-maxWidth m-auto flex gap-8 py-24" ]
            [ Html.img [ HA.src artist.profileImgUrl ] []
            , Html.section [ HA.class "flex-grow" ]
                [ Html.h2
                    [ HA.class "text-5xl font-title text-primary mb-4" ]
                    [ Html.text artist.name ]
                , Html.p
                    [ HA.class "font-bread text-base text-textLight mb-8" ]
                    [ Html.text artist.aboutMe ]
                , Html.section
                    [ HA.class "flex justify-between" ]
                    [ viewList "Styles" artist.styles
                    , viewList "Mediums" artist.mediums
                    ]
                ]
            ]
        ]


viewList : String -> List String -> Html Msg
viewList label list =
    Html.ul
        [ HA.class "flex flex-col gap-2" ]
        (Html.h4
            [ HA.class "text-2xl mb-4 font-title font-semibold text-primary" ]
            [ Html.text label ]
            :: List.map viewListChip list
        )


viewListChip : String -> Html Msg
viewListChip label =
    Html.li
        [ HA.class "py-2 px-4 rounded-full bg-bgLight bg-opacity-25 w-fit text-xs font-bread" ]
        [ Html.text label ]


viewArtworks : List Artwork -> Html Msg
viewArtworks artworks =
    Html.section
        [ HA.class " max-w-maxWidth m-auto py-24 grid grid-cols-2 gap-8" ]
        (List.indexedMap viewArtworkCard artworks)


viewArtworkCard : Int -> Artwork -> Html Msg
viewArtworkCard x artwork =
    Html.article
        [ HA.class ("grid grid-cols-2 gap-4 relative row-span-2 row-start-" ++ String.fromInt (x + 1))
        ]
        [ Html.section
            [ HA.href ("/artwork/" ++ artwork.id)
            , HA.class "grid justify-between"
            , HA.classList
                [ ( "order-1", modBy 2 x == 1 )
                ]
            ]
            [ Html.h2
                [ HA.class "text-xl font-title font-semibold" ]
                [ Html.text artwork.title ]
            , Html.p
                [ HA.class "font-bread text-sm h-56 overflow-clip" ]
                [ Html.text artwork.description ]
            , Html.h3
                [ HA.class "text-lg font-title underline text-center"
                ]
                [ Html.text "view Artwork" ]
            ]
        , Html.img
            [ HA.src artwork.imageUrl
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
        [ HA.class "max-w-maxWidth w-full m-auto py-16 border-b-2 border-black" ]
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
