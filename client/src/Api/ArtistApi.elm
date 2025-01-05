module Api.ArtistApi exposing (..)

import Http
import Json.Decode exposing (Decoder, field, list, map2, map7, string)
import Models.Artist exposing (Artist)


type alias ApiResponse =
    { message : String
    , data : List Artist
    }


fetchArtists : (Result Http.Error ApiResponse -> msg) -> Cmd msg
fetchArtists msg =
    Http.get
        { url = "http://localhost:8080/api/artist"
        , expect = Http.expectJson msg apiResponseDecoder
        }


fetchArtistsById : String -> (Result Http.Error ApiResponse -> msg) -> Cmd msg
fetchArtistsById id msg =
    Http.get
        { url = "http://localhost:8080/api/artist/" ++ id
        , expect = Http.expectJson msg apiResponseDecoder
        }


fetchArtistsByStyle : String -> (Result Http.Error ApiResponse -> msg) -> Cmd msg
fetchArtistsByStyle style msg =
    Http.get
        { url = "http://localhost:8080/api/artist/" ++ style
        , expect = Http.expectJson msg apiResponseDecoder
        }


fetchArtistsByMedium : String -> (Result Http.Error ApiResponse -> msg) -> Cmd msg
fetchArtistsByMedium medium msg =
    Http.get
        { url = "http://localhost:8080/api/artist/" ++ medium
        , expect = Http.expectJson msg apiResponseDecoder
        }


artistDecoder : Decoder Artist
artistDecoder =
    map7 Artist
        (field "_id" string)
        (field "name" string)
        (field "aboutMe" string)
        (field "profileImgUrl" string)
        (field "mediums" (list string))
        (field "styles" (list string))
        (field "createdAt" string)


apiResponseDecoder : Decoder ApiResponse
apiResponseDecoder =
    map2 ApiResponse
        (field "message" string)
        (field "data" (list artistDecoder))
