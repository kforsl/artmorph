module Api.Artwork exposing (..)

import Api.Artist exposing (Artist, artistDecoder)
import Http
import Json.Decode as JD exposing (Decoder)


type alias Model =
    List Artwork


initModel : Model
initModel =
    []


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


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchArtwork result ->
            case result of
                Ok data ->
                    ( data.data, Cmd.none )

                Err error ->
                    ( model, Cmd.none )


baseUrl : String
baseUrl =
    "https://artmorph-api.onrender.com"


fetchArtwork : Cmd Msg
fetchArtwork =
    Http.get
        { url = baseUrl ++ "/api/artwork"
        , expect = Http.expectJson FetchArtwork apiResponseDecoder
        }


fetchArtworkById : String -> Cmd Msg
fetchArtworkById id =
    Http.get
        { url = baseUrl ++ "/api/artwork/" ++ id
        , expect = Http.expectJson FetchArtwork apiResponseDecoder
        }


fetchArtworkByStyle : String -> Cmd Msg
fetchArtworkByStyle style =
    Http.get
        { url = baseUrl ++ "/api/artwork/" ++ style
        , expect = Http.expectJson FetchArtwork apiResponseDecoder
        }


fetchArtworkByMedium : String -> Cmd Msg
fetchArtworkByMedium medium =
    Http.get
        { url = baseUrl ++ "/api/artwork/" ++ medium
        , expect = Http.expectJson FetchArtwork apiResponseDecoder
        }


fetchArtworkByArtist : String -> Cmd Msg
fetchArtworkByArtist artist =
    Http.get
        { url = baseUrl ++ "/api/artwork/artist" ++ artist
        , expect = Http.expectJson FetchArtwork apiResponseDecoder
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
