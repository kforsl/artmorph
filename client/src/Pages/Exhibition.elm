module Pages.Exhibition exposing (..)

import Api.Artist exposing (Artist)
import Api.Exhibitions exposing (Exhibition, ExhibitionArtwork)
import Html exposing (Html)
import Html.Attributes as HA


type alias Model =
    { exhibitionData : List Exhibition
    , artistData : List Artist
    }


initModel : Model
initModel =
    { exhibitionData = []
    , artistData = []
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
                , viewCreatedBy exhibition.artworks model.artistData
                , viewOtherExhibitions otherExhibitions
                ]

        Nothing ->
            Html.text "Error Not Found"


viewHero : Exhibition -> Html Msg
viewHero exhibition =
    Html.section [ HA.class "bg-bgDark relative z-0 bg-text" ]
        [ Html.div
            [ HA.class "max-w-maxWidth m-auto flex gap-8 py-24" ]
            [ Html.img [ HA.src exhibition.thumbnailUrl ] []
            , Html.section [ HA.class "flex-grow" ]
                [ Html.h2
                    [ HA.class "text-5xl font-title text-primary mb-4" ]
                    [ Html.text exhibition.title ]
                , Html.p
                    [ HA.class "font-bread text-base text-textLight mb-8" ]
                    [ Html.text exhibition.description ]
                , Html.section [ HA.class "flex justify-evenly" ]
                    [ viewList "Styles" exhibition.styles
                    , viewList "Mediums" exhibition.mediums
                    ]
                ]
            ]
        ]


viewList : String -> List String -> Html Msg
viewList label list =
    Html.ul
        [ HA.class "flex flex-col gap-2" ]
        (Html.h4
            [ HA.class "text-3xl mb-4 font-title font-semibold text-primary" ]
            [ Html.text label ]
            :: List.map viewListChip list
        )


viewListChip : String -> Html Msg
viewListChip label =
    Html.li
        [ HA.class "py-2 px-4 rounded-full bg-bgLight bg-opacity-25 w-fit text-xs font-bread" ]
        [ Html.text label ]


viewArtworks : List ExhibitionArtwork -> Html Msg
viewArtworks artworks =
    Html.section
        [ HA.class " max-w-maxWidth m-auto py-24 grid grid-cols-2 gap-8" ]
        (List.indexedMap viewArtworkCard artworks)


viewArtworkCard : Int -> ExhibitionArtwork -> Html Msg
viewArtworkCard x artwork =
    Html.article
        [ HA.class ("grid grid-cols-2 gap-4 relative row-span-2 row-start-" ++ String.fromInt (x + 1))
        ]
        [ Html.section
            [ HA.href ("/artwork/" ++ artwork.id)
            , HA.class "grid justify-between"
            , HA.classList
                [ ( "order-1", modBy 2 x == 1 )
                ]
            ]
            [ Html.h2
                [ HA.class "text-xl font-title font-semibold" ]
                [ Html.text artwork.title ]
            , Html.p
                [ HA.class "font-bread text-sm h-56 overflow-clip" ]
                [ Html.text artwork.description ]
            , Html.h3
                [ HA.class "text-lg font-title underline text-center"
                ]
                [ Html.text "view Artwork" ]
            ]
        , Html.img
            [ HA.src artwork.imageUrl
            ]
            []
        , Html.a
            [ HA.href ("/artwork/" ++ artwork.id)
            , HA.class "absolute top-0 left-0 h-full w-full p-2"
            ]
            []
        ]


viewCreatedBy : List ExhibitionArtwork -> List Artist -> Html Msg
viewCreatedBy artworks artists =
    let
        exhibitionArtists =
            List.filter
                (\artist -> List.any (\artwork -> artwork.artist == artist.id) artworks)
                artists
    in
    Html.article
        [ HA.class "bg-bgDark" ]
        [ Html.section
            [ HA.class "max-w-maxWidth flex gap-12 m-auto py-16 border-b-2 border-black" ]
            [ Html.h2
                [ HA.class "font-title text-textLight text-4xl mb-8 col-span-full" ]
                [ Html.text "Created by: " ]
            , Html.ul
                [ HA.class "flex overflow-hidden justify-center gap-12" ]
                (List.map viewArtistCard exhibitionArtists)
            ]
        ]


viewArtistCard : Artist -> Html Msg
viewArtistCard artist =
    Html.article
        [ HA.class "max-w-44 grid gap-0.5 hover:opacity-80 relative focus-within:opacity-80 p-1" ]
        [ Html.h3
            [ HA.class "font-title text-base text-textLight overflow-hidden text-ellipsis text-nowrap underline underline-offset-2"
            ]
            [ Html.text artist.name ]
        , Html.img
            [ HA.src artist.profileImgUrl
            , HA.class "rounded"
            ]
            []
        , Html.a
            [ HA.href ("/artists/" ++ artist.id)
            , HA.class "h-full w-full absolute top-0 left-0"
            ]
            []
        ]


viewOtherExhibitions : List Exhibition -> Html Msg
viewOtherExhibitions exhibitions =
    Html.article
        [ HA.class "max-w-maxWidth m-auto py-16" ]
        [ Html.section
            [ HA.class "flex justify-between" ]
            [ Html.h2
                [ HA.class "font-title text-3xl mb-4 text-textDark col-span-full" ]
                [ Html.text "Featured Exhibitions" ]
            , Html.a
                [ HA.href "/exhibitions"
                , HA.class "place-self-center text-nowrap text-base h-fit py-2.5 px-4 bg-primary rounded-2xl font-bold"
                ]
                [ Html.text "Checkout all our exhibitions" ]
            ]
        , Html.ul
            [ HA.class "flex gap-4 overflow-x-scroll py-8" ]
            (List.indexedMap
                viewExhibitionCard
                exhibitions
            )
        ]


viewExhibitionCard : Int -> Exhibition -> Html Msg
viewExhibitionCard x exhibition =
    Html.li
        [ HA.class "grid gap-0.5 relative p-1"
        ]
        [ Html.img
            [ HA.src exhibition.thumbnailUrl
            , HA.class "max-w-96 object-cover object-top rounded"
            ]
            []
        , Html.p
            [ HA.class "font-title text-base overflow-hidden text-ellipsis text-nowrap"
            ]
            [ Html.text exhibition.title ]
        , Html.a
            [ HA.href ("/exhibitions/" ++ exhibition.id)
            , HA.class "absolute w-full h-full"
            ]
            []
        ]
