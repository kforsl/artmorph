module Components.Newsletter exposing (..)

import Html exposing (Html)
import Html.Attributes as HA
import Html.Events as HE
import Process
import Task


type alias Model =
    { formState : FormState
    }


type FormState
    = Resting
    | Loading
    | Success
    | Error


initModel : Model
initModel =
    { formState = Resting
    }


type Msg
    = MsgSubmitForm
    | MsgSubmitError
    | MsgSubmitResting
    | MsgSubmitSuccess


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MsgSubmitForm ->
            ( { model | formState = Loading }, sendToSelfWithDelay 2000 MsgSubmitSuccess )

        MsgSubmitError ->
            ( { model | formState = Error }, Cmd.none )

        MsgSubmitResting ->
            ( { model | formState = Resting }, Cmd.none )

        MsgSubmitSuccess ->
            ( { model | formState = Success }, sendToSelfWithDelay 4000 MsgSubmitResting )


sendToSelfWithDelay : Float -> Msg -> Cmd Msg
sendToSelfWithDelay delay msg =
    Process.sleep delay
        |> Task.map (\_ -> msg)
        |> Task.perform identity


view : Model -> Html Msg
view model =
    Html.section
        [ HA.class "max-w-maxWidth m-auto sm:pt-24 sm:pb-48 grid sm:grid-cols-12 grid-cols-1 gap-8 bg-light-text md:px-4 px-4 py-8" ]
        [ Html.h2
            [ HA.class "font-title sm:text-3xl text-xl col-span-full" ]
            [ Html.text "Your Journey Into Art Begins Here" ]
        , Html.img
            [ HA.src "https://artmorph-images.s3.eu-north-1.amazonaws.com/newsletter.png"
            , HA.alt "A digital painting of a city skyline at sunset with a silhouetted figure standing on a bridge. The figure reaches toward the sky, where vibrant splashes of colorful paint drip down, blending with the clouds. The artwork creates a surreal and dreamlike atmosphere, symbolizing creativity and imagination."
            , HA.class "max-w-full rounded sm:col-span-5"
            ]
            []
        , Html.section
            [ HA.class "py-4 sm:col-span-7" ]
            [ Html.h3
                [ HA.class "font-medium sm:text-xl text-lg leading-relaxed sm:mb-8 mb-4" ]
                [ Html.text "Stay Inspired – Get the Latest from Artmorph" ]
            , Html.p
                [ HA.class "sm:text-base text-sm font-regular leading-7 mb-12 " ]
                [ Html.text "Art is always evolving, and so is Artmorph. Be the first to discover new exhibitions, featured artists, and exclusive insights into the world of digital curation. Sign up for our newsletter and let inspiration find you." ]
            , Html.form
                [ HA.class " w-full flex sm:flex-nowrap flex-wrap gap-4 pb-4"
                , HE.onSubmit MsgSubmitForm
                ]
                [ Html.input
                    [ HA.class "w-full bg-textLight rounded-lg pl-2 py-2"
                    , HA.placeholder "John.Doe@mail.com"
                    , HA.required True
                    ]
                    []
                , case model.formState of
                    Resting ->
                        Html.button
                            [ HA.class "text-nowrap text-sm py-2 px-4 bg-primary rounded-2xl font-bold hover:opacity-80 focus-within:opacity-80 cursor-pointer" ]
                            [ Html.text "Subscribe Now" ]

                    Loading ->
                        Html.button
                            [ HA.class "text-nowrap text-sm py-2 px-4 bg-primary rounded-2xl font-bold" ]
                            [ Html.text "Loading . . ." ]

                    Success ->
                        Html.button
                            [ HA.class "text-nowrap text-sm py-2 px-4 bg-primary rounded-2xl font-bold" ]
                            [ Html.text "Success" ]

                    Error ->
                        Html.button
                            [ HA.class "text-nowrap text-sm py-2 px-4 bg-primary rounded-2xl font-bold hover:opacity-80 focus-within:opacity-80 cursor-pointer" ]
                            [ Html.text "Subscribe Now" ]
                ]
            , Html.nav
                [ HA.class "flex justify-around" ]
                [ Html.a
                    [ HA.href "/exhibitions"
                    , HA.class "font-title text-base mb-2 overflow-hidden text-ellipsis text-nowrap underline underline-offset-2 cursor-pointer p-2 hover:text-primary focus-within:text-primary"
                    ]
                    [ Html.text "Start Exploring Exhibitions" ]
                , Html.a
                    [ HA.href "/artists"
                    , HA.class "font-title text-base mb-2 overflow-hidden text-ellipsis text-nowrap underline underline-offset-2 cursor-pointer p-2 hover:text-primary focus-within:text-primary"
                    ]
                    [ Html.text "Check out our creators" ]
                ]
            ]
        ]
