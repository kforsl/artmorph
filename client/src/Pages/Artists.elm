module Pages.Artists exposing (..)

import Api.Artist exposing (Artist)
import Api.Artwork exposing (Artwork)
import Html exposing (Html)
import Html.Attributes as HA
import Html.Attributes.Aria as Aria

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
        [ HA.class ("max-w-maxWidth m-auto grid md:grid-cols-2 lg:gap-8 gap-4 md:py-24 p-4 grid-rows-" ++ String.fromInt (List.length model.artistData + 1)) ]
        (List.indexedMap
            (\x artist -> viewArtistCard x artist model.artworkData)
            model.artistData
        )


viewArtistCard : Int -> Artist -> List Artwork -> Html Msg
viewArtistCard x artist artworks =
    Html.article
        [ HA.class ("grid grid-cols-12 md:p-4 px-2 gap-2 rounded bg-bgLight relative group hover:opacity-80 focus-within:opacity-80 md:row-span-2 md:row-start-" ++ String.fromInt (x + 1))
        ]
        [ Html.img
            [ HA.src artist.profileImgUrl
            , HA.alt ("A portrait of " ++ artist.name ++ ".")
            , HA.class "max-w-64 col-span-4 w-full row-span-2 rounded place-self-center"
            ]
            []
        , Html.h2
            [ HA.class "md:text-3xl text-xl pt-2 pl-2 col-start-5 col-span-full group-hover:text-primary group-focus-within:text-primary" ]
            [ Html.text artist.name ]
        , viewArtistPreviewImages artist.id artworks
        , Html.a
            [ HA.href ("/artists/" ++ artist.id)
            , Aria.ariaLabel ("Navigate to " ++ artist.name ++ " page.") 
            , HA.class "absolute p-4 top-0 left-0 h-full w-full"
            ]
            []
        ]


viewArtistPreviewImages : String -> List Artwork -> Html Msg
viewArtistPreviewImages artistId artworks =
    let
        previewArtworks : List Artwork
        previewArtworks =
            artworks
                |> List.filter (\artwork -> artwork.artist.id == artistId)
                |> List.take 3

        generateImage : Artwork -> Html Msg
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
