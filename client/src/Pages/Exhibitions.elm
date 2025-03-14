module Pages.Exhibitions exposing (..)

import Api.Exhibitions exposing (Exhibition)
import Html exposing (Html)
import Html.Attributes as HA
import Api.Exhibitions exposing (ExhibitionArtwork)


type alias Model =
    { exhibitionData : List Exhibition
    }


initModel : Model
initModel =
    { exhibitionData = []
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
        [ viewExhibition model
        ]


viewExhibition : Model -> Html Msg
viewExhibition model =
    Html.section
        [ HA.class ("max-w-maxWidth m-auto grid md:grid-cols-2 lg:gap-8 gap-4 md:py-24 p-4 grid-rows-" ++ String.fromInt (List.length model.exhibitionData + 1)) ]
        (List.indexedMap
            viewExhibitionCard
            model.exhibitionData
        )


viewExhibitionCard : Int -> Exhibition -> Html Msg
viewExhibitionCard x exhibition =
    Html.article
        [ HA.class ("grid grid-cols-12 md:p-4 px-2 gap-2 rounded bg-bgLight relative group hover:opacity-80 focus-within:opacity-80 md:row-span-2 md:row-start-" ++ String.fromInt (x + 1))
        ]
        [ Html.img
            [ HA.src exhibition.thumbnailUrl
            , HA.alt exhibition.description
            , HA.class "max-w-64 col-span-4 w-full row-span-2 rounded place-self-center"
            ]
            []
        , Html.h2
            [ HA.class "md:text-3xl text-xl pt-2 pl-2 col-start-5 col-span-full group-hover:text-primary group-focus-within:text-primary" ]
            [ Html.text exhibition.title ]
        , viewExhibitionPreviewImages exhibition
        , Html.a
            [ HA.href ("/exhibitions/" ++ exhibition.id)
            , HA.class "absolute p-4 top-0 left-0 h-full w-full"
            ]
            []
        ]


viewExhibitionPreviewImages : Exhibition -> Html Msg
viewExhibitionPreviewImages exhibitions =
    let
        previewArtworks =
            List.take 3 exhibitions.artworks

        generateImage : ExhibitionArtwork -> Html Msg
        generateImage artwork =
            Html.img 
                [ HA.src artwork.imageUrl
                , HA.alt artwork.description
                , HA.class "max-w-52 w-full rounded" 
                ] 
                []
    in
    Html.figure
        [ HA.class "col-span-full grid gap-2 col-start-5 grid-cols-3 place-content-center md:p-0 p-4" ]
        (List.map generateImage previewArtworks)
