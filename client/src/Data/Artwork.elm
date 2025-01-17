module Data.Artwork exposing (..)

import Data.Artist exposing (Artist, artistDecoder)
import Http
import Json.Decode as JD exposing (Decoder)


type alias Model =
    { artwork : List Artwork
    , artworkById : List Artwork
    , artworkByStyle : List Artwork
    , artworkByMedium : List Artwork
    }


initModel : Model
initModel =
    { artwork = []
    , artworkById = []
    , artworkByMedium = []
    , artworkByStyle = []
    }


type alias ApiResponse =
    { message : String
    , data : List Artwork
    }


type alias Artwork =
    { id : String
    , title : String
    , description : String
    , artist : Artist
    , imageUrl : String
    , mediums : List String
    , styles : List String
    , createdAt : String
    }


type Msg
    = FetchArtwork (Result Http.Error ApiResponse)
    | FetchArtworkById (Result Http.Error ApiResponse)
    | FetchArtworkByStyle (Result Http.Error ApiResponse)
    | FetchArtworkByMedium (Result Http.Error ApiResponse)
    | FetchArtworkByArtist (Result Http.Error ApiResponse)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchArtwork result ->
            case result of
                Ok data ->
                    ( { model | artwork = data.data }, Cmd.none )

                Err error ->
                    ( model, Cmd.none )

        FetchArtworkById result ->
            ( model, Cmd.none )

        FetchArtworkByStyle result ->
            ( model, Cmd.none )

        FetchArtworkByMedium result ->
            ( model, Cmd.none )

        FetchArtworkByArtist result ->
            ( model, Cmd.none )


fetchArtwork : Cmd Msg
fetchArtwork =
    Http.get
        { url = "http://localhost:8080/api/artwork"
        , expect = Http.expectJson FetchArtwork apiResponseDecoder
        }


fetchArtworkById : String -> Cmd Msg
fetchArtworkById id =
    Http.get
        { url = "http://localhost:8080/api/artwork/" ++ id
        , expect = Http.expectJson FetchArtworkById apiResponseDecoder
        }


fetchArtworkByStyle : String -> Cmd Msg
fetchArtworkByStyle style =
    Http.get
        { url = "http://localhost:8080/api/artwork/" ++ style
        , expect = Http.expectJson FetchArtworkByStyle apiResponseDecoder
        }


fetchArtworkByMedium : String -> Cmd Msg
fetchArtworkByMedium medium =
    Http.get
        { url = "http://localhost:8080/api/artwork/" ++ medium
        , expect = Http.expectJson FetchArtworkByMedium apiResponseDecoder
        }


fetchArtworkByArtist : String -> Cmd Msg
fetchArtworkByArtist artist =
    Http.get
        { url = "http://localhost:8080/api/artwork/artist" ++ artist
        , expect = Http.expectJson FetchArtworkByArtist apiResponseDecoder
        }


artworkDecoder : Decoder Artwork
artworkDecoder =
    JD.map8 Artwork
        (JD.field "_id" JD.string)
        (JD.field "title" JD.string)
        (JD.field "description" JD.string)
        (JD.field "artist" artistDecoder)
        (JD.field "imageUrl" JD.string)
        (JD.field "mediums" (JD.list JD.string))
        (JD.field "styles" (JD.list JD.string))
        (JD.field "createdAt" JD.string)


apiResponseDecoder : Decoder ApiResponse
apiResponseDecoder =
    JD.map2 ApiResponse
        (JD.field "message" JD.string)
        (JD.field "data" (JD.list artworkDecoder))
