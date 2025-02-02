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
            List.filter (\x -> x.artist.id == id) model.artworkData
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
    Html.section [ HA.class "max-w-svw min-h-full grid auto-rows-max place-content-between grid-cols-1 " ] [ Html.text "artist" ]


viewArtworks : List Artwork -> Html msg
viewArtworks artworks =
    Html.section [] [ Html.text "Artwork" ]


viewArtworkCard : Artwork -> Html msg
viewArtworkCard artwork =
    Html.article [] [ Html.text artwork.title ]


viewOtherArtists : List Artist -> Html msg
viewOtherArtists otherArtist =
    Html.section [] [ Html.text "other artists" ]
