module Models.Artist exposing (..)


type alias Artist =
    { id : String
    , name : String
    , aboutMe : String
    , profileImgUrl : String
    , mediums : List String
    , styles : List String
    , createdAt : String
    }
