module Api.ExhibitionsApi exposing (..)

import Api.ArtworkApi exposing (artworkDecoder)
import Http
import Json.Decode exposing (Decoder, field, list, map2, map8, string)
import Models.Exhibitions exposing (Exhibition)


type alias ApiResponse =
    { message : String
    , data : List Exhibition
    }


type Msg
    = GotExhibitions (Result Http.Error ApiResponse)


fetchExhibition : (Result Http.Error ApiResponse -> msg) -> Cmd msg
fetchExhibition msg =
    Http.get
        { url = "http://localhost:8080/api/exhibition"
        , expect = Http.expectJson msg apiResponseDecoder
        }


fetchExhibitionById : String -> (Result Http.Error ApiResponse -> msg) -> Cmd msg
fetchExhibitionById id msg =
    Http.get
        { url = "http://localhost:8080/api/exhibition/" ++ id
        , expect = Http.expectJson msg apiResponseDecoder
        }


fetchExhibitionByStyle : String -> (Result Http.Error ApiResponse -> msg) -> Cmd msg
fetchExhibitionByStyle style msg =
    Http.get
        { url = "http://localhost:8080/api/exhibition/" ++ style
        , expect = Http.expectJson msg apiResponseDecoder
        }


fetchExhibitionByMedium : String -> (Result Http.Error ApiResponse -> msg) -> Cmd msg
fetchExhibitionByMedium medium msg =
    Http.get
        { url = "http://localhost:8080/api/exhibition/" ++ medium
        , expect = Http.expectJson msg apiResponseDecoder
        }


exhibitionDecoder : Decoder Exhibition
exhibitionDecoder =
    map8 Exhibition
        (field "_id" string)
        (field "title" string)
        (field "description" string)
        (field "thumbnailUrl" string)
        (field "artworks" (list artworkDecoder))
        (field "mediums" (list string))
        (field "styles" (list string))
        (field "createdAt" string)


apiResponseDecoder : Decoder ApiResponse
apiResponseDecoder =
    map2 ApiResponse
        (field "message" string)
        (field "data" (list exhibitionDecoder))
