module Components.Header exposing (..)

import Html exposing (Html)
import Html.Attributes as HA
import Html.Events as HE
import Svg
import Svg.Attributes as SA
import Svg.Events as SE


type alias Model =
    { isBurgerOpen : Bool
    }


init : Model
init =
    { isBurgerOpen = False
    }


type Msg
    = ToggleBurgerState


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        ToggleBurgerState ->
            ( { model | isBurgerOpen = not model.isBurgerOpen }, Cmd.none )


view : Model -> Html Msg
view model =
    Html.header
        [ HA.class "bg-bgDark fixed top-0 w-full z-40 lg:px-0 px-4 drop-shadow-md" ]
        [ Html.div
            [ HA.class "flex justify-between max-w-maxWidth m-auto" ]
            [ Html.a 
                [ HA.href "/" 
                ] 
                [ Html.h1
                    [ HA.class "font-logo text-primary font-medium content-center py-2 lg:text-6xl sm:text-5xl text-3xl" ]
                    [ Html.text "ArtMorph" ]
                ]
            , viewNavigation model
            ]
        ]


viewNavigation : Model -> Html Msg
viewNavigation model =
    let
        hamburgerIcon =
            if model.isBurgerOpen then
                Svg.svg
                    [ SA.fill "none"
                    , SA.viewBox "0 0 24 24"
                    , SA.strokeWidth "1.5"
                    , SA.stroke "#EC5001"
                    , SA.class "sm:hidden size-8 absolute top-2 right-4 z-50"
                    , SE.onClick ToggleBurgerState
                    ]
                    [ Svg.path
                        [ SA.strokeLinecap "round"
                        , SA.strokeLinejoin "round"
                        , SA.d "M6 18 18 6M6 6l12 12"
                        ]
                        []
                    ]

            else
                Svg.svg
                    [ SA.fill "none"
                    , SA.viewBox "0 0 24 24"
                    , SA.strokeWidth "1.5"
                    , SA.stroke "#EC5001"
                    , SA.class "sm:hidden size-8"
                    , SE.onClick ToggleBurgerState
                    ]
                    [ Svg.path
                        [ SA.strokeLinecap "round"
                        , SA.strokeLinejoin "round"
                        , SA.d "M3.75 6.75h16.5M3.75 12h16.5m-16.5 5.25h16.5"
                        ]
                        []
                    ]
    in
    Html.nav
        [ HA.class "max-w-fit relativ content-center" ]
        [ hamburgerIcon
        , Html.ul
            [ HA.class "grid place-content-center sm:grid-cols-3 auto-cols-max sm:translate-none translate-x-full sm:h-fit h-screen sm:w-fit w-2/3 sm:static absolute right-0 top-0 bg-bgDark transition duration-300 ease-in-out "
            , HA.classList [ ( "translate-none", model.isBurgerOpen ) ]
            ]
            [ viewLink "/" "Home"
            , viewLink "/about" "About"
            , viewLink "/auth" "Login"
            ]
        ]


viewLink : String -> String -> Html Msg
viewLink path label =
    Html.li
        [ HE.onClick ToggleBurgerState ]
        [ Html.a
            [ HA.class "block p-4 sm:text-base text-xl font-title text-primary font-bold hover:cursor-pointer   underline-offset-2 hover:underline focus-within:underline"
            , HA.href path
            ]
            [ Html.text label
            ]
        ]
