module Data.Exhibitions exposing (..)

import Data.Artwork exposing (Artwork, artworkDecoder)
import Http
import Json.Decode as JD exposing (Decoder)


type alias Model =
    { exhibition : List Exhibition
    , exhibitionById : List Exhibition
    , exhibitionByStyle : List Exhibition
    , exhibitionByMedium : List Exhibition
    }


initModel : Model
initModel =
    { exhibition = []
    , exhibitionById = []
    , exhibitionByMedium = []
    , exhibitionByStyle = []
    }


type alias ApiResponse =
    { message : String
    , data : List Exhibition
    }


type alias Exhibition =
    { id : String
    , title : String
    , description : String
    , thumbnailUrl : String
    , artworks : List Artwork
    , mediums : List String
    , styles : List String
    , createdAt : String
    }


type Msg
    = GetExhibition (Result Http.Error ApiResponse)
    | GetExhibitionById (Result Http.Error ApiResponse)
    | GetExhibitionByStyle (Result Http.Error ApiResponse)
    | GetExhibitionByMedium (Result Http.Error ApiResponse)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetExhibition result ->
            case result of
                Ok data ->
                    ( { model | exhibition = data.data }, Cmd.none )

                Err error ->
                    ( model, Cmd.none )

        GetExhibitionById result ->
            ( model, Cmd.none )

        GetExhibitionByStyle result ->
            ( model, Cmd.none )

        GetExhibitionByMedium result ->
            ( model, Cmd.none )


fetchExhibition : Cmd Msg
fetchExhibition =
    Http.get
        { url = "http://localhost:8080/api/exhibition"
        , expect = Http.expectJson GetExhibition apiResponseDecoder
        }


fetchExhibitionById : String -> Cmd Msg
fetchExhibitionById id =
    Http.get
        { url = "http://localhost:8080/api/exhibition/" ++ id
        , expect = Http.expectJson GetExhibitionById apiResponseDecoder
        }


fetchExhibitionByStyle : String -> Cmd Msg
fetchExhibitionByStyle style =
    Http.get
        { url = "http://localhost:8080/api/exhibition/" ++ style
        , expect = Http.expectJson GetExhibitionByStyle apiResponseDecoder
        }


fetchExhibitionByMedium : String -> Cmd Msg
fetchExhibitionByMedium medium =
    Http.get
        { url = "http://localhost:8080/api/exhibition/" ++ medium
        , expect = Http.expectJson GetExhibitionByMedium apiResponseDecoder
        }


exhibitionDecoder : Decoder Exhibition
exhibitionDecoder =
    JD.map8 Exhibition
        (JD.field "_id" JD.string)
        (JD.field "title" JD.string)
        (JD.field "description" JD.string)
        (JD.field "thumbnailUrl" JD.string)
        (JD.field "artworks" (JD.list artworkDecoder))
        (JD.field "mediums" (JD.list JD.string))
        (JD.field "styles" (JD.list JD.string))
        (JD.field "createdAt" JD.string)


apiResponseDecoder : Decoder ApiResponse
apiResponseDecoder =
    JD.map2 ApiResponse
        (JD.field "message" JD.string)
        (JD.field "data" (JD.list exhibitionDecoder))
