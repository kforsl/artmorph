module Models.Exhibitions exposing (..)

import Models.Artwork exposing (Artwork)


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
