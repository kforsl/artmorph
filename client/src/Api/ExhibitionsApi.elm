module Api.ExhibitionsApi exposing (..)

import Http
import Json.Decode exposing (Decoder, field, list, map2, string)
import Models.Exhibitions exposing (Exhibition)


type alias ApiResponse =
    { message : String
    , data : List Exhibition
    }


type Msg
    = GotExhibitions (Result Http.Error ApiResponse)


exhibitionDecoder : Decoder Exhibition
exhibitionDecoder =
    map2 Exhibition
        (field "_id" string)
        (field "name" string)


apiResponseDecoder : Decoder ApiResponse
apiResponseDecoder =
    map2 ApiResponse
        (field "message" string)
        (field "data" (list exhibitionDecoder))
