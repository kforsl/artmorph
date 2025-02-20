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
        [ HA.class "bg-bgDark" ]
        [ viewExhibition model
        ]


viewExhibition : Model -> Html Msg
viewExhibition model =
    Html.section
        [ HA.class "max-w-maxWidth m-auto flex flex-col gap-8 py-16" ]
        (List.map
            viewExhibitionCard
            model.exhibitionData
        )


viewExhibitionCard : Exhibition -> Html Msg
viewExhibitionCard exhibition =
    Html.article
        [ HA.class "grid grid-cols-12 p-4 rounded bg-bgLight relative"
        ]
        [ Html.img
            [ HA.src exhibition.thumbnailUrl
            , HA.class "max-w-64 col-span-3 rounded"
            ]
            []
        , Html.section
            [ HA.class "p-4 col-span-4 grid grid-cols-2 gap-4"
            ]
            [ Html.h2
                [ HA.class "text-3xl col-span-full" ]
                [ Html.text exhibition.title ]
            , viewExhibitionList "Styles" exhibition.styles
            , viewExhibitionList "Mediums" exhibition.mediums
            ]
        , viewExhibitionPreviewImages exhibition
        , Html.a
            [ HA.href ("/exhibitions/" ++ exhibition.id)
            , HA.class "absolute p-4 top-0 left-0 h-full w-full"
            ]
            []
        ]


viewExhibitionList : String -> List String -> Html Msg
viewExhibitionList label list =
    Html.ul
        [ HA.class "flex flex-col gap-2" ]
        (Html.h3
            [ HA.class "text-lg mb-2 font-title font-semibold" ]
            [ Html.text label ]
            :: List.map viewExhibitionChip list
        )


viewExhibitionChip : String -> Html Msg
viewExhibitionChip label =
    Html.li
        [ HA.class "py-2 px-4 rounded-full bg-secondary bg-opacity-25 w-fit text-xs font-bread" ]
        [ Html.text label ]


viewExhibitionPreviewImages : Exhibition -> Html Msg
viewExhibitionPreviewImages exhibitions =
    let
        previewArtworks = List.take 2 exhibitions.artworks
        
        generateImage artwork = 
            Html.img [ HA.src artwork.imageUrl, HA.class "max-w-52 rounded" ] []
    in
    Html.figure
        [ HA.class "col-span-5 grid grid-cols-2 place-content-center" ]
        (List.map generateImage previewArtworks 
        )
