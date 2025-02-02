module Pages.Exhibition exposing (..)

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


view : Model -> String -> Html Msg
view model id =
    let
        ( matchingExhibition, otherExhibitions ) =
            List.partition (\x -> x.id == id) model.exhibitionData
    in
    case List.head matchingExhibition of
        Just exhibition ->
            Html.main_ [ HA.class "max-w-svw min-h-full grid auto-rows-max place-content-between grid-cols-1 " ]
                [ viewHero exhibition
                , viewArtworks exhibition.artworks
                , viewOtherExhibitions otherExhibitions
                ]

        Nothing ->
            Html.text "Loading... "


viewHero : Exhibition -> Html Msg
viewHero exhibition =
    Html.section [ HA.class "bg-bgDark relative z-0" ]
        [ Html.div
            [ HA.class "max-w-maxWidth m-auto flex gap-8 py-24" ]
            [ Html.img [ HA.src exhibition.thumbnailUrl ] []
            , Html.section [ HA.class "flex-grow" ]
                [ Html.h2
                    [ HA.class "text-5xl font-title text-primary mb-4" ]
                    [ Html.text exhibition.title ]
                , Html.h3
                    [ HA.class "text-2xl font-title text-primary mb-4" ]
                    [ Html.text ("Created by: " ++ "Artist Name") ]
                , Html.p
                    [ HA.class "font-bread text-base text-textLight mb-8" ]
                    [ Html.text exhibition.description ]
                , Html.section [ HA.class "flex justify-between" ]
                    [ Html.h4
                        [ HA.class "text-3xl font-title text-primary mb-4" ]
                        [ Html.text "Styles" ]
                    , Html.ul
                        []
                        (List.map viewListItem exhibition.styles)
                    , Html.h4
                        [ HA.class "text-3xl font-title text-primary mb-4" ]
                        [ Html.text "Mediums" ]
                    , Html.ul
                        []
                        (List.map viewListItem exhibition.mediums)
                    ]
                ]
            ]
        ]


viewListItem : String -> Html Msg
viewListItem x =
    Html.li [ HA.class "text-textLight" ] [ Html.text x ]


viewArtworks : List Api.Exhibitions.ExhibitionArtwork -> Html Msg
viewArtworks artworks =
    Html.section [ HA.class " max-w-maxWidth m-auto py-24 flex flex-wrap gap-4" ] (List.map viewArtworkCard artworks)


viewArtworkCard : Api.Exhibitions.ExhibitionArtwork -> Html msg
viewArtworkCard artwork =
    Html.article
        [ HA.class "max-w-44 grid gap-0.5" ]
        [ Html.a
            [ HA.href ("/artists/" ++ artwork.id)
            , HA.class "font-title text-base overflow-hidden text-ellipsis text-nowrap underline underline-offset-2 cursor-pointer"
            ]
            [ Html.text artwork.title ]
        , Html.img
            [ HA.src artwork.imageUrl ]
            []
        ]


viewOtherExhibitions : Api.Exhibitions.Model -> Html Msg
viewOtherExhibitions exhibitions =
    Html.section [ HA.class " max-w-maxWidth m-auto py-24 flex flex-wrap gap-4" ] (List.map viewExhibitionCard exhibitions)


viewExhibitionCard : Exhibition -> Html msg
viewExhibitionCard exhibition =
    Html.li
        [ HA.class "grid gap-0.5" ]
        [ Html.img
            [ HA.src exhibition.thumbnailUrl
            , HA.class "max-w-96 aspect-square object-cover"
            ]
            []
        , Html.a
            [ HA.href ("/exhibitions/" ++ exhibition.id)
            , HA.class "font-title text-base overflow-hidden text-ellipsis text-nowrap underline underline-offset-2 cursor-pointer"
            ]
            [ Html.text exhibition.title ]
        ]
