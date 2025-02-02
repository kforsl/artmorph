module Pages.Artists exposing (..)

import Api.Artist exposing (Artist)
import Html exposing (Html)
import Html.Attributes as HA


type alias Model =
    { artistData : List Artist
    }


initModel : Model
initModel =
    { artistData = []
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
    Html.main_
        [ HA.class "bg-bgLight" ]
        [ viewArtist model
        ]


viewArtist : Model -> Html Msg
viewArtist model =
    Html.section
        [ HA.class "max-w-maxWidth m-auto" ]
        (List.map
            viewArtistCard
            model.artistData
        )


viewArtistCard : Artist -> Html Msg
viewArtistCard artist =
    Html.article
        []
        [ Html.img [ HA.src artist.profileImgUrl ] []
        , Html.h2 [] [ Html.text artist.name ]
        , Html.p [] [ Html.text artist.aboutMe ]
        ]
