module Pages.Exhibitions exposing (..)

import Api.Exhibitions exposing (Exhibition)
import Html exposing (Html)
import Html.Attributes as HA


type alias Model =
    { exhibitionData : List Exhibition
    }


initModel : Model
initModel =
    { exhibitionData = []
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
        [ viewExhibition model
        ]


viewExhibition : Model -> Html Msg
viewExhibition model =
    Html.section
        [ HA.class "max-w-maxWidth m-auto" ]
        (List.map
            viewExhibitionCard
            model.exhibitionData
        )


viewExhibitionCard : Exhibition -> Html Msg
viewExhibitionCard exhibition =
    Html.article
        []
        [ Html.img [ HA.src exhibition.thumbnailUrl ] []
        , Html.h2 [] [ Html.text exhibition.title ]
        ]
