module Pages.Artists exposing (..)

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


view : Model -> Html Msg
view model =
    Html.main_
        [ HA.class "bg-bgDark" ]
        [ viewArtist model
        ]


viewArtist : Model -> Html Msg
viewArtist model =
    Html.section
        [ HA.class "max-w-maxWidth m-auto flex flex-col gap-16 py-24" ]
        (List.map
            (\artist -> viewArtistCard artist model.artworkData)
            model.artistData
        )


viewArtistCard : Artist -> List Artwork -> Html Msg
viewArtistCard artist artworks =
    Html.article
        [ HA.class "grid grid-cols-12 p-4 rounded bg-bgLight relative group hover:opacity-80 focus-within:opacity-80"
        ]
        [ Html.img
            [ HA.src artist.profileImgUrl
            , HA.class "max-w-64 col-span-3 rounded"
            ]
            []
        , Html.section
            [ HA.class "p-4 col-span-4 grid grid-cols-2 gap-4"
            ]
            [ Html.h2
                [ HA.class "text-3xl col-span-full group-hover:text-primary group-focus-within:text-primary" ]
                [ Html.text artist.name ]
            , viewArtistList "Styles" artist.styles
            , viewArtistList "Mediums" artist.mediums
            ]
        , viewArtistPreviewImages artist.id artworks
        , Html.a
            [ HA.href ("/artists/" ++ artist.id)
            , HA.class "absolute p-4 top-0 left-0 h-full w-full"
            ]
            []
        ]


viewArtistList : String -> List String -> Html Msg
viewArtistList label list =
    Html.ul
        [ HA.class "flex flex-col gap-2" ]
        (Html.h3
            [ HA.class "text-lg mb-2 font-title font-semibold" ]
            [ Html.text label ]
            :: List.map viewArtistChip list
        )


viewArtistChip : String -> Html Msg
viewArtistChip label =
    Html.li
        [ HA.class "py-2 px-4 rounded-full bg-secondary bg-opacity-25 w-fit text-xs  " ]
        [ Html.text label ]


viewArtistPreviewImages : String -> List Artwork -> Html Msg
viewArtistPreviewImages artistId artworks =
    let
        previewArtworks : List Artwork
        previewArtworks =
            artworks
                |> List.filter (\artwork -> artwork.artist.id == artistId)
                |> List.take 2

        generateImage artwork =
            Html.img [ HA.src artwork.imageUrl, HA.class "max-w-52 rounded" ] []
    in
    Html.figure
        [ HA.class "col-span-5 grid grid-cols-2 place-content-center" ]
        (List.map generateImage previewArtworks)
