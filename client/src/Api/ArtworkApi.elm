module Api.ArtworkApi exposing (..)

import Api.ArtistApi exposing (artistDecoder)
import Http
import Json.Decode exposing (Decoder, field, list, map2, map8, string)
import Models.Artist exposing (Artist)
import Models.Artwork exposing (Artwork)


type alias ApiResponse =
    { message : String
    , data : List Artwork
    }


fetchArtwork : (Result Http.Error ApiResponse -> msg) -> Cmd msg
fetchArtwork msg =
    Http.get
        { url = "http://localhost:8080/api/artwork"
        , expect = Http.expectJson msg apiResponseDecoder
        }


fetchArtworkById : String -> (Result Http.Error ApiResponse -> msg) -> Cmd msg
fetchArtworkById id msg =
    Http.get
        { url = "http://localhost:8080/api/artwork/" ++ id
        , expect = Http.expectJson msg apiResponseDecoder
        }


fetchArtworkByStyle : String -> (Result Http.Error ApiResponse -> msg) -> Cmd msg
fetchArtworkByStyle style msg =
    Http.get
        { url = "http://localhost:8080/api/artwork/" ++ style
        , expect = Http.expectJson msg apiResponseDecoder
        }


fetchArtworkByMedium : String -> (Result Http.Error ApiResponse -> msg) -> Cmd msg
fetchArtworkByMedium medium msg =
    Http.get
        { url = "http://localhost:8080/api/artwork/" ++ medium
        , expect = Http.expectJson msg apiResponseDecoder
        }


fetchArtworkByArtist : String -> (Result Http.Error ApiResponse -> msg) -> Cmd msg
fetchArtworkByArtist artist msg =
    Http.get
        { url = "http://localhost:8080/api/artwork/artist" ++ artist
        , expect = Http.expectJson msg apiResponseDecoder
        }


artworkDecoder : Decoder Artwork
artworkDecoder =
    map8 Artwork
        (field "_id" string)
        (field "title" string)
        (field "description" string)
        (field "artist" artistDecoder)
        (field "imageUrl" string)
        (field "mediums" (list string))
        (field "styles" (list string))
        (field "createdAt" string)


apiResponseDecoder : Decoder ApiResponse
apiResponseDecoder =
    map2 ApiResponse
        (field "message" string)
        (field "data" (list artworkDecoder))
