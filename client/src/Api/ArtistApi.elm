module Api.ArtistApi exposing (..)

import Http
import Json.Decode exposing (Decoder, field, list, map2, map7, string)
import Models.Artist exposing (Artist)


type alias ApiResponse =
    { message : String
    , data : List Artist
    }


type Msg
    = GotArtists (Result Http.Error ApiResponse)


getArtists : Cmd Msg
getArtists =
    Http.get
        { url = "http://localhost:8080/api/artist"
        , expect = Http.expectJson GotArtists apiResponseDecoder
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
