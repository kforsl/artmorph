module Pages.Artwork exposing (..)

import Api.Artist exposing (Artist)
import Api.Artwork exposing (Artwork)
import Html exposing (Html)
import Html.Attributes as HA
import Html.Extra


type alias Model =
    { artworkData : List Artwork
    }


initModel : Model
initModel =
    { artworkData = []
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
        ( matchingArtwork, otherArtwork ) =
            List.partition (\x -> x.id == id) model.artworkData
    in
    case List.head matchingArtwork of
        Just artwork ->
            let
                artistId =
                    artwork.artist.id
            in
            Html.main_ [ HA.class "max-w-svw min-h-full grid auto-rows-max place-content-between grid-cols-1 " ]
                [ viewArtwork artwork
                , viewArtworkInformation artwork
                -- , viewArtistInformation artwork.artist
                , viewArtistOtherArtwork otherArtwork artistId
                ]

        Nothing ->
            Html.text "Error Not Found"

viewArtwork : Artwork -> Html Msg
viewArtwork artwork =
    Html.figure [ HA.class "bg-bgDark h-full relative z-0 py-16" ]
        [ Html.img
            [ HA.src artwork.imageUrl, HA.class "h-full mx-auto" ]
            []
        ]


viewArtworkInformation : Artwork -> Html Msg
viewArtworkInformation artwork =
    Html.section [ HA.class "bg-bgDark relative z-0" ]
        [ Html.div
            [ HA.class "max-w-maxWidth h-full m-auto p-8" ]
            [ Html.h2
                [ HA.class "text-5xl font-title text-primary mb-4" ]
                [ Html.text artwork.title ]
            , Html.h3
                [ HA.class "text-2xl font-title text-primary mb-4" ]
                [ Html.text ("Created by: " ++ artwork.artist.name) ]
            , Html.p
                [ HA.class "font-bread text-base text-textLight mb-8" ]
                [ Html.text artwork.description ]
            , Html.section [ HA.class "flex justify-between" ]
                [ Html.h3
                    [ HA.class "text-3xl font-title text-primary mb-4" ]
                    [ Html.text "Styles" ]
                , Html.ul
                    []
                    (List.map viewListItem artwork.styles)
                , Html.h3
                    [ HA.class "text-3xl font-title text-primary mb-4" ]
                    [ Html.text "Mediums" ]
                , Html.ul
                    []
                    (List.map viewListItem artwork.mediums)
                ]
            ]
        ]


viewArtistInformation : Artist -> Html Msg
viewArtistInformation artist =
    Html.section [ HA.class "bg-bgDark relative z-0" ]
        [ Html.div
            [ HA.class "max-w-maxWidth m-auto flex gap-8 py-24" ]
            [ Html.img [ HA.src artist.profileImgUrl, HA.class "m-auto" ] []
            , Html.section [ HA.class "flex-grow" ]
                [ Html.h2
                    [ HA.class "text-5xl font-title text-primary mb-4" ]
                    [ Html.text artist.name ]
                , Html.p
                    [ HA.class "font-bread text-base text-textLight mb-8" ]
                    [ Html.text artist.aboutMe ]
                , Html.section [ HA.class "flex justify-between" ]
                    [ Html.h3
                        [ HA.class "text-3xl font-title text-primary mb-4" ]
                        [ Html.text "Styles" ]
                    , Html.ul
                        []
                        (List.map viewListItem artist.styles)
                    , Html.h3
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


viewArtistOtherArtwork : List Artwork -> String -> Html Msg
viewArtistOtherArtwork artworks artistId =
    Html.section
        [ HA.class " max-w-maxWidth m-auto py-24 flex flex-wrap gap-4" ]
        (List.map
            (\artwork ->
                Html.Extra.viewIf (artwork.artist.id == artistId)
                    (viewArtworkCard artwork)
            )
            artworks
        )


viewArtworkCard : Artwork -> Html msg
viewArtworkCard artwork =
    Html.article
        [ HA.class "max-w-44 grid gap-0.5" ]
        [ Html.a
            [ HA.href ("/artwork/" ++ artwork.id)
            , HA.class "font-title text-base overflow-hidden text-ellipsis text-nowrap underline underline-offset-2 cursor-pointer"
            ]
            [ Html.text artwork.title ]
        , Html.img
            [ HA.src artwork.imageUrl ]
            []
        ]
