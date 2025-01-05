module Models.Artwork exposing (..)

import Models.Artist exposing (Artist)


type alias Artwork =
    { id : String
    , title : String
    , description : String
    , artist : Artist
    , imageUrl : String
    , mediums : List String
    , styles : List String
    , createdAt : String
    }
