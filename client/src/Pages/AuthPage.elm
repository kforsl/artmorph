module Pages.AuthPage exposing (..)

import Element.UI
import Html exposing (Html)
import Html.Attributes as HA
import Html.Events as HE
import Process
import Task


type alias Model =
    { formType : FormType
    , formState : FormState
    }


type FormType
    = Login
    | Register


type FormState
    = Resting
    | Loading
    | Success
    | Error


initModel : Model
initModel =
    { formType = Register
    , formState = Resting
    }


type Msg
    = MsgChangeFormType
    | MsgSubmitForm
    | MsgSubmitError
    | MsgSubmitResting
    | MsgSubmitSuccess


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MsgChangeFormType ->
            case model.formType of
                Login ->
                    ( { model | formType = Register }, Cmd.none )

                Register ->
                    ( { model | formType = Login }, Cmd.none )

        MsgSubmitForm ->
            ( { model | formState = Loading }, sendToSelfWithDelay 2000 MsgSubmitError )

        MsgSubmitError ->
            ( { model | formState = Error }, sendToSelfWithDelay 4000 MsgSubmitResting )

        MsgSubmitResting ->
            ( { model | formState = Resting }, Cmd.none )

        MsgSubmitSuccess ->
            ( { model | formState = Success }, Cmd.none )


sendToSelfWithDelay : Float -> msg -> Cmd msg
sendToSelfWithDelay delay msg =
    Process.sleep delay
        |> Task.map (\_ -> msg)
        |> Task.perform identity


view : Model -> Html Msg
view model =
    case model.formType of
        Login ->
            Html.main_
                [ HA.class "relative z-0 h-full max-h-svh bg-bgDark w-full grid content-center" ]
                [ Html.section
                    [ HA.class "grid place-content-center relative" ]
                    [ Html.h1
                        [ HA.class "text-sizeBg w-full text-secondary font-logo absolute -top-12 left-0 -translate-y-1/2 text-center text-nowrap z-20" ]
                        [ Html.text "Sign In" ]
                    , Html.form
                        [ HA.class "bg-primary flex flex-col p-28 pt-40 gap-4 max-w-3xl justify-center relative h-[596px]"
                        , HE.onSubmit MsgSubmitForm
                        ]
                        [ Html.div
                            [ HA.class "grid gap-2" ]
                            [ Element.UI.formInput "Email"
                            , Element.UI.formInput "Password"
                            ]
                        , Html.p
                            [ HA.class "text-base font-bread text-center font-bold" ]
                            [ Html.span
                                [ HA.class "mr-1 underline underline-offset-2 cursor-pointer"
                                , HE.onClick MsgChangeFormType
                                ]
                                [ Html.text "Create an account" ]
                            , Html.text "to start exploring exhibitions, connect with artists, and receive exclusive updates."
                            ]
                        , case model.formState of
                            Resting ->
                                Element.UI.buttonSecondary "Sign In"

                            Loading ->
                                Element.UI.buttonSecondary "Loading . . ."

                            Success ->
                                Element.UI.buttonSecondary "Success"

                            Error ->
                                Element.UI.buttonSecondary "Sign In"
                        ]
                    ]
                , Element.UI.bgTextSecondary
                ]

        Register ->
            Html.main_
                [ HA.class "relative z-0 h-full max-h-svh bg-bgDark w-full grid content-center" ]
                [ Html.section
                    [ HA.class "grid place-content-center relative" ]
                    [ Html.h1
                        [ HA.class "text-sizeBg w-full text-secondary font-logo absolute -top-12 left-0 -translate-y-1/2 text-center text-nowrap z-20" ]
                        [ Html.text "Register" ]
                    , Html.form
                        [ HA.class "bg-primary flex flex-col p-28 pt-40 gap-4 max-w-3xl justify-center relative h-[596px]"
                        , HE.onSubmit MsgSubmitForm
                        ]
                        [ Html.div
                            [ HA.class "grid gap-2" ]
                            [ Element.UI.formInput "Email"
                            , Element.UI.formInput "Password"
                            , Element.UI.formInput "Repeat Password"
                            ]
                        , Html.p
                            [ HA.class "text-base font-bread text-center font-bold" ]
                            [ Html.span
                                [ HA.class "mr-1 underline underline-offset-2 cursor-pointer"
                                , HE.onClick MsgChangeFormType
                                ]
                                [ Html.text "Log in" ]
                            , Html.text "to continue discovering and engaging with inspiring art collections."
                            ]
                        , case model.formState of
                            Resting ->
                                Element.UI.buttonSecondary "Register"

                            Loading ->
                                Element.UI.buttonSecondary "Loading . . ."

                            Success ->
                                Element.UI.buttonSecondary "Success"

                            Error ->
                                Element.UI.buttonSecondary "Register"
                        ]
                    ]
                , Element.UI.bgTextSecondary
                ]



--
