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
        []
        [ Html.section
            [ HA.class "max-w-maxWidth min-h-screen grid m-auto md:grid-cols-3 sm:grid-cols-2 sm:grid-rows-1 grid-cols-1 grid-rows-2 h-full" ]
            [ Html.img
                [ HA.src "https://artmorph-images.s3.eu-north-1.amazonaws.com/error.webp"
                , HA.alt "A friendly but confused-looking monster, digitally painted, stands in the middel of a chaotic scene. The creature has large, expressive eyes, a goofy grin, and multiple arms holding tangled wires."
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
