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
            Html.text "Loading... "


viewArtistInformation : Artist -> Html msg
viewArtistInformation artist =
    Html.section [ HA.class "bg-bgDark relative z-0" ]
        [ Html.div
            [ HA.class "max-w-maxWidth m-auto flex gap-8 py-24" ]
            [ Html.img [ HA.src artist.profileImgUrl ] []
            , Html.section [ HA.class "flex-grow" ]
                [ Html.h2
                    [ HA.class "text-5xl font-title text-primary mb-4" ]
                    [ Html.text artist.name ]
                , Html.h3
                    [ HA.class "text-2xl font-title text-primary mb-4" ]
                    [ Html.text ("Created by: " ++ "Artist Name") ]
                , Html.p
                    [ HA.class "font-bread text-base text-textLight mb-8" ]
                    [ Html.text artist.aboutMe ]
                , Html.section [ HA.class "flex justify-between" ]
                    [ Html.h4
                        [ HA.class "text-3xl font-title text-primary mb-4" ]
                        [ Html.text "Styles" ]
                    , Html.ul
                        []
                        (List.map viewListItem artist.styles)
                    , Html.h4
                        [ HA.class "text-3xl font-title text-primary mb-4" ]
                        [ Html.text "Mediums" ]
                    , Html.ul
                        []
                        (List.map viewListItem artist.mediums)
                    ]
                ]
            ]
        ]


viewListItem : String -> Html msg
viewListItem x =
    Html.li [ HA.class "text-textLight" ] [ Html.text x ]


viewArtworks : List Artwork -> Html msg
viewArtworks artworks =
    Html.section [ HA.class "flex" ]
        (List.map viewArtworkCard artworks)


viewArtworkCard : Artwork -> Html msg
viewArtworkCard artwork =
    Html.article []
        [ Html.img [ HA.src artwork.imageUrl ] []
        , Html.a
            [ HA.href ("/artwork/" ++ artwork.id)
            , HA.class "font-title text-base overflow-hidden text-ellipsis text-nowrap underline underline-offset-2 cursor-pointer"
            ]
            [ Html.text artwork.title ]
        ]


viewOtherArtists : List Artist -> Html Msg
viewOtherArtists artists =
    Html.section [ HA.class " max-w-maxWidth m-auto py-24 flex flex-wrap gap-4" ] (List.map viewArtistCard artists)


viewArtistCard : Artist -> Html msg
viewArtistCard artist =
    Html.li
        [ HA.class "grid gap-0.5" ]
        [ Html.img
            [ HA.src artist.profileImgUrl
            , HA.class "max-w-96 aspect-square object-cover"
            ]
            []
        , Html.a
            [ HA.href ("/artists/" ++ artist.id)
            , HA.class "font-title text-base overflow-hidden text-ellipsis text-nowrap underline underline-offset-2 cursor-pointer"
            ]
            [ Html.text artist.name ]
        ]
