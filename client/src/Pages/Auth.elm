module Pages.Auth exposing (..)

import Browser.Navigation as Navigation
import Html exposing (Html)
import Html.Attributes as HA
import Html.Events as HE
import Process
import Svg exposing (Svg)
import Svg.Attributes as SA
import Task


type alias Model =
    { formType : FormType
    , formState : FormState
    , navigationKey : Maybe Navigation.Key
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
    { formType = Login
    , formState = Resting
    , navigationKey = Nothing
    }


type Msg
    = MsgChangeFormType
    | NavigateBack Navigation.Key
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

        NavigateBack key ->
            ( model, Navigation.back key 1 )

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


view : Model -> Navigation.Key -> Html Msg
view model navigationKey =
    case model.formType of
        Login ->
            Html.main_
                [ HA.class "relative z-0 h-full max-h-svh bg-bgDark w-full grid content-center bg-text" ]
                [ Html.section
                    [ HA.class "grid place-content-center relative" ]
                    [ Html.h1
                        [ HA.class "text-sizeBg w-full text-secondary font-logo absolute -top-12 left-0 -translate-y-1/2 text-center text-nowrap z-20" ]
                        [ Html.text "Sign In" ]
                    , Html.form
                        [ HA.class "bg-primary flex flex-col p-28 pt-40 gap-4 max-w-3xl justify-center relative h-[596px]"
                        , HE.onSubmit MsgSubmitForm
                        ]
                        [ viewBackBnt navigationKey
                        , Html.div
                            [ HA.class "grid gap-2" ]
                            [ Html.label []
                                [ Html.text "Email"
                                , Html.input
                                    [ HA.class "w-full bg-bgLight rounded-lg pl-2 py-2" ]
                                    []
                                ]
                            , Html.label []
                                [ Html.text "Password"
                                , Html.input
                                    [ HA.class "w-full bg-bgLight rounded-lg pl-2 py-2" 
                                    , HA.type_ "password"
                                    ]
                                    []
                                ]
                            ]
                        , Html.p
                            [ HA.class "text-base   text-center font-bold" ]
                            [ Html.span
                                [ HA.class "mr-1 underline underline-offset-2 cursor-pointer"
                                , HE.onClick MsgChangeFormType
                                ]
                                [ Html.text "Create an account" ]
                            , Html.text "to start exploring exhibitions, connect with artists, and receive exclusive updates."
                            ]
                        , case model.formState of
                            Resting ->
                                Html.button
                                    [ HA.class "text-nowrap text-sm py-2 px-4 bg-secondary rounded-2xl font-bold ml-auto w-fit text-textLight" ]
                                    [ Html.text "Sign In" ]

                            Loading ->
                                Html.button
                                    [ HA.class "text-nowrap text-sm py-2 px-4 bg-secondary rounded-2xl font-bold ml-auto w-fit text-textLight" ]
                                    [ Html.text "Loading . . ." ]

                            Success ->
                                Html.button
                                    [ HA.class "text-nowrap text-sm py-2 px-4 bg-secondary rounded-2xl font-bold ml-auto w-fit text-textLight" ]
                                    [ Html.text "Success" ]

                            Error ->
                                Html.button
                                    [ HA.class "text-nowrap text-sm py-2 px-4 bg-secondary rounded-2xl font-bold ml-auto w-fit text-textLight" ]
                                    [ Html.text "Sign In" ]
                        ]
                    ]
                ]

        Register ->
            Html.main_
                [ HA.class "relative z-0 h-full max-h-svh bg-bgDark w-full grid content-center bg-text" ]
                [ Html.section
                    [ HA.class "grid place-content-center relative" ]
                    [ Html.h1
                        [ HA.class "text-sizeBg w-full text-secondary font-logo absolute -top-12 left-0 -translate-y-1/2 text-center text-nowrap z-20" ]
                        [ Html.text "Register" ]
                    , Html.form
                        [ HA.class "bg-primary flex flex-col p-28 pt-40 gap-4 max-w-3xl justify-center relative h-[596px]"
                        , HE.onSubmit MsgSubmitForm
                        ]
                        [ viewBackBnt navigationKey
                        , Html.div
                            [ HA.class "grid gap-2" ]
                            [ Html.label []
                                [ Html.text "Email"
                                , Html.input
                                    [ HA.class "w-full bg-bgLight rounded-lg pl-2 py-2" ]
                                    []
                                ]
                            , Html.label []
                                [ Html.text "Password"
                                , Html.input
                                    [ HA.class "w-full bg-bgLight rounded-lg pl-2 py-2" 
                                    , HA.type_ "password"
                                    ]
                                    []
                                ]
                            , Html.label []
                                [ Html.text "Repeat Password"
                                , Html.input
                                    [ HA.class "w-full bg-bgLight rounded-lg pl-2 py-2" 
                                    , HA.type_ "password"
                                    ]
                                    []
                                ]
                            ]
                        , Html.p
                            [ HA.class "text-base text-center font-bold" ]
                            [ Html.span
                                [ HA.class "mr-1 underline underline-offset-2 cursor-pointer"
                                , HE.onClick MsgChangeFormType
                                ]
                                [ Html.text "Log in" ]
                            , Html.text "to continue discovering and engaging with inspiring art collections."
                            ]
                        , case model.formState of
                            Resting ->
                                Html.button
                                    [ HA.class "text-nowrap text-sm py-2 px-4 bg-secondary rounded-2xl font-bold ml-auto w-fit text-textLight" ]
                                    [ Html.text "Register" ]

                            Loading ->
                                Html.button
                                    [ HA.class "text-nowrap text-sm py-2 px-4 bg-secondary rounded-2xl font-bold ml-auto w-fit text-textLight" ]
                                    [ Html.text "Loading . . ." ]

                            Success ->
                                Html.button
                                    [ HA.class "text-nowrap text-sm py-2 px-4 bg-secondary rounded-2xl font-bold ml-auto w-fit text-textLight" ]
                                    [ Html.text "Success" ]

                            Error ->
                                Html.button
                                    [ HA.class "text-nowrap text-sm py-2 px-4 bg-secondary rounded-2xl font-bold ml-auto w-fit text-textLight" ]
                                    [ Html.text "Register" ]
                        ]
                    ]
                ]


viewBackBnt : Navigation.Key -> Html Msg
viewBackBnt navigationKey =
    Html.a
        [ HA.class "absolute bottom-8 left-8 p-4 hover:text-textLight focus-within:text-textLight"
        , NavigateBack navigationKey |> HE.onClick
        ]
        [ Svg.svg
            [ SA.fill "none"
            , SA.viewBox "0 0 24 24"
            , SA.strokeWidth "1.5"
            , SA.stroke "currentColor"
            , SA.class "size-10"
            ]
            [ Svg.path
                [ SA.strokeLinecap "round"
                , SA.strokeLinejoin "round"
                , SA.d "M9 15 3 9m0 0 6-6M3 9h12a6 6 0 0 1 0 12h-3"
                ]
                []
            ]
        ]
