module Api.Exhibitions exposing (..)

import Api.Artwork exposing (Artwork)
import Http
import Json.Decode as JD exposing (Decoder)


type alias Model =
    List Exhibition


initModel : Model
initModel =
    []


type alias ApiResponse =
    { message : String
    , data : List Exhibition
    }


type alias Exhibition =
    { id : String
    , title : String
    , description : String
    , thumbnailUrl : String
    , artworks : List ExhibitionArtwork
    , mediums : List String
    , styles : List String
    , createdAt : String
    }


type Msg
    = GetExhibition (Result Http.Error ApiResponse)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetExhibition result ->
            case result of
                Ok data ->
                    ( data.data, Cmd.none )

                Err error ->
                    ( model, Cmd.none )


baseUrl : String
baseUrl =
    "https://artmorph-api.onrender.com"


fetchExhibition : Cmd Msg
fetchExhibition =
    Http.get
        { url = baseUrl ++ "/api/exhibition"
        , expect = Http.expectJson GetExhibition apiResponseDecoder
        }


fetchExhibitionById : String -> Cmd Msg
fetchExhibitionById id =
    Http.get
        { url = baseUrl ++ "/api/exhibition/" ++ id
        , expect = Http.expectJson GetExhibition apiResponseDecoder
        }


fetchExhibitionByStyle : String -> Cmd Msg
fetchExhibitionByStyle style =
    Http.get
        { url = baseUrl ++ "/api/exhibition/" ++ style
        , expect = Http.expectJson GetExhibition apiResponseDecoder
        }


fetchExhibitionByMedium : String -> Cmd Msg
fetchExhibitionByMedium medium =
    Http.get
        { url = baseUrl ++ "/api/exhibition/" ++ medium
        , expect = Http.expectJson GetExhibition apiResponseDecoder
        }


exhibitionDecoder : Decoder Exhibition
exhibitionDecoder =
    JD.map8 Exhibition
        (JD.field "_id" JD.string)
        (JD.field "title" JD.string)
        (JD.field "description" JD.string)
        (JD.field "thumbnailUrl" JD.string)
        (JD.field "artworks" (JD.list exhibitionArtworkDecoder))
        (JD.field "mediums" (JD.list JD.string))
        (JD.field "styles" (JD.list JD.string))
        (JD.field "createdAt" JD.string)


type alias ExhibitionArtwork =
    { id : String
    , title : String
    , description : String
    , artist : String
    , imageUrl : String
    , mediums : List String
    , styles : List String
    , createdAt : String
    }


exhibitionArtworkDecoder : Decoder ExhibitionArtwork
exhibitionArtworkDecoder =
    JD.map8 ExhibitionArtwork
        (JD.field "_id" JD.string)
        (JD.field "title" JD.string)
        (JD.field "description" JD.string)
        (JD.field "artist" JD.string)
        (JD.field "imageUrl" JD.string)
        (JD.field "mediums" (JD.list JD.string))
        (JD.field "styles" (JD.list JD.string))
        (JD.field "createdAt" JD.string)


apiResponseDecoder : Decoder ApiResponse
apiResponseDecoder =
    JD.map2 ApiResponse
        (JD.field "message" JD.string)
        (JD.field "data" (JD.list exhibitionDecoder))
