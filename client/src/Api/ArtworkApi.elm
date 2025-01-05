module Api.ArtworkApi exposing (..)

import Http
import Json.Decode exposing (Decoder, field, list, map2, string)
import Models.Artwork exposing (Artwork)


type alias ApiResponse =
    { message : String
    , data : List Artwork
    }


type Msg
    = GotArtworks (Result Http.Error ApiResponse)


artworkDecoder : Decoder Artwork
artworkDecoder =
    map2 Artwork
        (field "_id" string)
        (field "name" string)


apiResponseDecoder : Decoder ApiResponse
apiResponseDecoder =
    map2 ApiResponse
        (field "message" string)
        (field "data" (list artworkDecoder))
