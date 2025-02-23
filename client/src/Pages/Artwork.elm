module Pages.Artwork exposing (..)

import Api.Artist exposing (Artist)
import Api.Artwork exposing (Artwork)
import Browser.Navigation as Navigation
import Html exposing (Html)
import Html.Attributes as HA
import Html.Events as HE
import Svg exposing (Svg)
import Svg.Attributes as SA


type alias Model =
    { artworkData : List Artwork
    }


initModel : Model
initModel =
    { artworkData = []
    }


type Msg
    = None
    | NavigateBack Navigation.Key


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        None ->
            ( model, Cmd.none )

        NavigateBack key ->
            ( model, Navigation.back key 1 )


view : Model -> String -> Navigation.Key -> Html Msg
view model id navigationKey =
    let
        matchingArtwork =
            List.filter (\x -> x.id == id) model.artworkData
    in
    case List.head matchingArtwork of
        Just artwork ->
            Html.main_ [ HA.class "max-w-svw " ]
                [ viewArtwork artwork navigationKey
                , viewArtworkInformation artwork
                , viewArtistInformation artwork.artist
                ]

        Nothing ->
            Html.text "Error Not Found"


viewArtwork : Artwork -> Navigation.Key -> Html Msg
viewArtwork artwork navigationKey =
    Html.section
        [ HA.class "bg-bgDark h-5/6 z-0 pt-12 bg-text" ]
        [ Html.figure [ HA.class "max-w-maxWidth z-0 m-auto relative grid h-full place-items-center" ]
            [ viewBackBnt navigationKey
            , Html.a
                [ HA.class "w-fit       "
                , HA.href artwork.imageUrl
                , HA.target "_blank"
                ]
                [ Html.img
                    [ HA.src artwork.imageUrl, HA.class "h-full" ]
                    []
                ]
            ]
        ]


viewBackBnt : Navigation.Key -> Html Msg
viewBackBnt navigationKey =
    Html.a
        [ HA.class "absolute top-0 left-0 p-4 hover:text-primary focus-within:text-primary"
        , NavigateBack navigationKey |> HE.onClick
        ]
        [ Svg.svg
            [ SA.fill "none"
            , SA.viewBox "0 0 24 24"
            , SA.strokeWidth "1.5"
            , SA.stroke "currentColor"
            , SA.class "size-10"
            ]
            [ Svg.path
                [ SA.strokeLinecap "round"
                , SA.strokeLinejoin "round"
                , SA.d "M9 15 3 9m0 0 6-6M3 9h12a6 6 0 0 1 0 12h-3"
                ]
                []
            ]
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
                [ HA.class "  text-base text-textLight mb-8 col-span-2" ]
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
            [ Html.section
                []
                [ Html.h2
                    [ HA.class "text-3xl font-title text-primary mb-4" ]
                    [ Html.text "About the Artist" ]
                , Html.p
                    [ HA.class "  text-base text-textLight mb-8 max-w-[50ch]" ]
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
        [ HA.class "py-2 px-4 rounded-full bg-bgLight bg-opacity-25 w-fit text-xs  " ]
        [ Html.text label ]
