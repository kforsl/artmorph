module Pages.Error exposing (..)
import Html exposing (Html)
import Html.Attributes as HA

type alias Model =
    { statusCode : String
    , errorMsg : String
    }


initModel : Model
initModel =
    { statusCode = "404"
    , errorMsg = "Sorry, Something went wrong"
    }

view : Model -> Html msg
view model =
    Html.main_
        [ HA.class "" ]
        [ Html.section
            [ HA.class "max-w-maxWidth grid m-auto md:grid-cols-3 sm:grid-cols-2 sm:grid-rows-1 grid-cols-1 grid-rows-2 h-full" ]
            [ Html.img
                [ HA.src "https://artmorph-images.s3.eu-north-1.amazonaws.com/error.png" 
                , HA.class "max-h-full place-self-center"
                ]
                []
            , Html.section
                [ HA.class "flex flex-col gap-4 w-full md:col-span-2 col-span-1 text-center sm:place-self-center font-title" ]
                [ Html.h2
                    [ HA.class "lg:text-9xl md:text-7xl text-5xl text-primary drop-shadow-md"]
                    [ Html.text model.statusCode ]
                , Html.h3
                    [ HA.class "lg:text-7xl md:text-5xl text-3xl"]
                    [ Html.text model.errorMsg ]
                , Html.a
                    [ HA.href "/" 
                    , HA.class "underline lg:text-2xl text-xl"
                    ]
                    [ Html.text "Go to home page" ]
                ]
            ]
        ]