module Pages.Exhibition exposing (..)

import Api.Artist exposing (Artist)
import Api.Exhibitions exposing (Exhibition, ExhibitionArtwork)
import Html exposing (Html)
import Html.Attributes as HA
import Html.Attributes.Aria as Aria
import Components.Carousel


type alias Model =
    { exhibitionData : List Exhibition
    , artistData : List Artist
    , carouselModel : Components.Carousel.Model
    }


initModel : Model
initModel =
    { exhibitionData = []
    , artistData = []
    , carouselModel = Components.Carousel.init
    }


type Msg
    = None
    | MsgCarousel Components.Carousel.Msg

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        None ->
            ( model, Cmd.none )

        MsgCarousel msgCarousel -> 
            let
                ( newCarouselModel, cmdCarousel ) = 
                    Components.Carousel.update msgCarousel model.carouselModel   
            in
            ( { model | carouselModel = newCarouselModel } , Cmd.map MsgCarousel cmdCarousel)




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
                , Html.map MsgCarousel (Components.Carousel.view model.carouselModel otherExhibitions)
                ]

        Nothing ->
            Html.text "Error Not Found"


viewHero : Exhibition -> Html Msg
viewHero exhibition =
    Html.section [ HA.class "bg-bgDark relative z-0 bg-text h-fit" ]
        [ Html.div
            [ HA.class "max-w-maxWidth m-auto grid md:grid-cols-3 gap-8 grid-cols-2 sm:py-32 px-4 py-16" ]
            [ Html.img 
                [ HA.src exhibition.thumbnailUrl
                , HA.alt exhibition.description
                , HA.class "md:col-span-1 col-span-full md:row-span-2 mx-auto" 
                ] 
                []
            , Html.section [ HA.class "p-4 md:col-span-2 col-span-full" ]
                [ Html.h2
                    [ HA.class "font-title text-primary mb-4 lg:text-5xl sm:text-3xl text-xl" ]
                    [ Html.text exhibition.title ]
                , Html.p
                    [ HA.class "sm:text-base text-sm sm:mb-8 mb-4 text-textLight" ]
                    [ Html.text exhibition.description ]
               , Html.section
                [ HA.class "grid gap-4 p-4 md:col-span-2 col-span-full sm:grid-cols-2" ]
                [ Html.h3 
                    [ HA.class "font-title w-full font-semibold text-primary lg:text-2xl sm:text-xl text-lg" ] 
                    [ Html.text "Styles" ] 
                , Html.h3 
                    [ HA.class "font-title w-full font-semibold text-primary lg:text-2xl sm:text-xl text-lg" ] 
                    [ Html.text "Mediums"]
                , viewList exhibition.styles
                , viewList exhibition.mediums
                ] 
 
                ]
            ]
        ]


viewList : List String -> Html Msg
viewList list =
    Html.ul
        [ HA.class "flex flex-wrap gap-4" ]
        ( List.map viewListChip list
        )


viewListChip : String -> Html Msg
viewListChip label =
    Html.li
        [ HA.class "py-2 px-4 rounded-full bg-bgLight bg-opacity-25 w-fit text-xs  " ]
        [ Html.text label ]


viewArtworks : List ExhibitionArtwork -> Html Msg
viewArtworks artworks =
    Html.section
        [ HA.class "max-w-maxWidth m-auto py-24 grid md:grid-cols-2 gap-8" ]
        (List.indexedMap viewArtworkCard artworks)


viewArtworkCard : Int -> ExhibitionArtwork -> Html Msg
viewArtworkCard x artwork =
    Html.article
        [ HA.class ("grid grid-cols-2 gap-4 relative p-2 group hover:opacity-80 focus-within:opacity-80 row-span-2 md:row-start-" ++ String.fromInt (x + 1))
        ]
        [ Html.section
            [ HA.class "grid justify-between"
            , HA.classList
                [ ( "order-1", modBy 2 x == 1 )
                ]
            ]
            [ Html.h2
                [ HA.class "md:text-xl text-lg font-title font-semibold" ]
                [ Html.text artwork.title ]
            , Html.p
                [ HA.class "md:text-sm text-xs h-56 overflow-clip" ]
                [ Html.text artwork.description ]
            , Html.h3
                [ HA.class "md:text-lg md:text-base font-title underline text-center group-hover:text-primary group-focus-within:text-primary"
                ]
                [ Html.text "view Artwork" ]
            ]
        , Html.img
            [ HA.src artwork.imageUrl
            , HA.alt artwork.description
            , HA.class "place-self-center"
            ]
            []
        , Html.a
            [ HA.href ("/artwork/" ++ artwork.id)
            , Aria.ariaLabel ("Navigate to " ++ artwork.title ++ " page.")
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
        [ HA.class "bg-bgDark bg-overlay px-4 py-8" ]
        [ Html.section
            [ HA.class "max-w-maxWidth flex flex-wrap justify-center gap-x-12 gap-y-4 m-auto md:py-24" ]
            [ Html.h2
                [ HA.class "font-title text-textLight sm:text-3xl text-xl mb-8 col-span-full" ]
                [ Html.text "Created by: " ]
            , Html.ul
                [ HA.class "flex flex-wrap overflow-hidden justify-center md:gap-12 gap-8" ]
                (List.map viewArtistCard exhibitionArtists)
            ]
        ]


viewArtistCard : Artist -> Html Msg
viewArtistCard artist =
    Html.li
        [ HA.class "sm:max-w-44 max-w-36 grid gap-0.5 hover:opacity-80 relative focus-within:opacity-80 p-1" ]
        [ Html.h3
            [ HA.class "font-title text-base text-textLight overflow-hidden text-ellipsis text-nowrap underline underline-offset-2"
            ]
            [ Html.text artist.name ]
        , Html.img
            [ HA.src artist.profileImgUrl
            , HA.alt ("A portrait of " ++ artist.name ++ ".")
            , HA.class "rounded"
            ]
            []
        , Html.a
            [ HA.href ("/artists/" ++ artist.id)
            , Aria.ariaLabel ("Navigate to " ++ artist.name ++ " page.")
            , HA.class "h-full w-full absolute top-0 left-0"
            ]
            []
        ]

