module Api.Artist exposing (..)

import Http
import Json.Decode as JD exposing (Decoder)


type alias Model =
    List Artist


initModel : Model
initModel =
    []


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


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchArtist result ->
            case result of
                Ok data ->
                    ( data.data, Cmd.none )

                Err _ ->
                    ( model, Cmd.none )


baseUrl : String
baseUrl =
    "https://artmorph-api.onrender.com"


fetchArtists : Cmd Msg
fetchArtists =
    Http.get
        { url = baseUrl ++ "/api/artist"
        , expect = Http.expectJson FetchArtist apiResponseDecoder
        }


fetchArtistsById : String -> Cmd Msg
fetchArtistsById id =
    Http.get
        { url = baseUrl ++ "/api/artist/" ++ id
        , expect = Http.expectJson FetchArtist apiResponseDecoder
        }


fetchArtistsByStyle : String -> Cmd Msg
fetchArtistsByStyle style =
    Http.get
        { url = baseUrl ++ "/api/artist/" ++ style
        , expect = Http.expectJson FetchArtist apiResponseDecoder
        }


fetchArtistsByMedium : String -> Cmd Msg
fetchArtistsByMedium medium =
    Http.get
        { url = baseUrl ++ "/api/artist/" ++ medium
        , expect = Http.expectJson FetchArtist apiResponseDecoder
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
