module Pages.Artwork exposing (..)

import Api.Artist exposing (Artist)
import Api.Artwork exposing (Artwork)
import Html exposing (Html)
import Html.Attributes as HA


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
        matchingArtwork =
            List.filter (\x -> x.id == id) model.artworkData
    in
    case List.head matchingArtwork of
        Just artwork ->
            Html.main_ [ HA.class "max-w-svw " ]
                [ viewArtwork artwork
                , viewArtworkInformation artwork
                , viewArtistInformation artwork.artist
                ]

        Nothing ->
            Html.text "Error Not Found"


viewArtwork : Artwork -> Html Msg
viewArtwork artwork =
    Html.figure [ HA.class "bg-bgDark h-5/6 z-0 py-16 bg-text" ]
        [ Html.img
            [ HA.src artwork.imageUrl, HA.class "h-full mx-auto" ]
            []
        ]


viewArtworkInformation : Artwork -> Html Msg
viewArtworkInformation artwork =
    Html.section [ HA.class "bg-bgDark relative z-0" ]
        [ Html.div
            [ HA.class "max-w-maxWidth m-auto p-8 grid gap-4 grid-cols-4 justify-items-center" ]
            [ Html.h2
                [ HA.class "text-4xl font-title text-primary mb-4 col-span-full" ]
                [ Html.text artwork.title ]
            , Html.h3
                [ HA.class "text-3xl font-title text-primary mb-4 col-span-full" ]
                [ Html.text ("Created by: " ++ artwork.artist.name) ]
            , Html.p
                [ HA.class "font-bread text-base text-textLight mb-8 col-span-2" ]
                [ Html.text artwork.description ]
            , viewList "Styles" artwork.styles
            , viewList "Mediums" artwork.mediums
            ]
        ]


viewArtistInformation : Artist -> Html Msg
viewArtistInformation artist =
    Html.section [ HA.class "bg-bgDark relative z-0 flex justify-center" ]
        [ Html.div
            [ HA.class "max-w-maxWidth m-auto flex gap-8 py-24" ]
            [ Html.section [ ]
                [ Html.h2
                    [ HA.class "text-3xl font-title text-primary mb-4" ]
                    [ Html.text "About the Artist" ]
                , Html.p
                    [ HA.class "font-bread text-base text-textLight mb-8 max-w-[50ch]" ]
                    [ Html.text artist.aboutMe ]
                ]
            , Html.img [ HA.src artist.profileImgUrl, HA.class "h-80" ] []
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
