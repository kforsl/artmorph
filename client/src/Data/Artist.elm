module Data.Artist exposing (..)

import Http
import Json.Decode as JD exposing (Decoder)


type alias Model =
    { artists : List Artist
    , artistsById : List Artist
    , artistsByStyle : List Artist
    , artistsByMedium : List Artist
    }


initModel : Model
initModel =
    { artists = []
    , artistsById = []
    , artistsByMedium = []
    , artistsByStyle = []
    }


type alias ApiResponse =
    { message : String
    , data : List Artist
    }


type alias Artist =
    { id : String
    , name : String
    , aboutMe : String
    , profileImgUrl : String
    , mediums : List String
    , styles : List String
    , createdAt : String
    }


type Msg
    = FetchArtist (Result Http.Error ApiResponse)
    | FetchArtistById (Result Http.Error ApiResponse)
    | FetchArtistByStyle (Result Http.Error ApiResponse)
    | FetchArtistByMedium (Result Http.Error ApiResponse)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchArtist result ->
            case result of
                Ok data ->
                    ( { model | artists = data.data }, Cmd.none )

                Err error ->
                    ( model, Cmd.none )

        FetchArtistById result ->
            ( model, Cmd.none )

        FetchArtistByStyle result ->
            ( model, Cmd.none )

        FetchArtistByMedium result ->
            ( model, Cmd.none )


fetchArtists : Cmd Msg
fetchArtists =
    Http.get
        { url = "http://localhost:8080/api/artist"
        , expect = Http.expectJson FetchArtist apiResponseDecoder
        }


fetchArtistsById : String -> Cmd Msg
fetchArtistsById id =
    Http.get
        { url = "http://localhost:8080/api/artist/" ++ id
        , expect = Http.expectJson FetchArtistById apiResponseDecoder
        }


fetchArtistsByStyle : String -> Cmd Msg
fetchArtistsByStyle style =
    Http.get
        { url = "http://localhost:8080/api/artist/" ++ style
        , expect = Http.expectJson FetchArtistByStyle apiResponseDecoder
        }


fetchArtistsByMedium : String -> Cmd Msg
fetchArtistsByMedium medium =
    Http.get
        { url = "http://localhost:8080/api/artist/" ++ medium
        , expect = Http.expectJson FetchArtistByMedium apiResponseDecoder
        }


artistDecoder : Decoder Artist
artistDecoder =
    JD.map7 Artist
        (JD.field "_id" JD.string)
        (JD.field "name" JD.string)
        (JD.field "aboutMe" JD.string)
        (JD.field "profileImgUrl" JD.string)
        (JD.field "mediums" (JD.list JD.string))
        (JD.field "styles" (JD.list JD.string))
        (JD.field "createdAt" JD.string)


apiResponseDecoder : Decoder ApiResponse
apiResponseDecoder =
    JD.map2 ApiResponse
        (JD.field "message" JD.string)
        (JD.field "data" (JD.list artistDecoder))
