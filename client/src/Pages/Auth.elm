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
                [ HA.class "relative z-0 h-svh bg-bgDark w-full grid content-center bg-text px-4" ]
                [ Html.section
                    [ HA.class "grid place-content-center relative" ]
                    [ Html.h1
                        [ HA.class "lg:text-sizeBg md:text-[250px] sm:text-[200px] text-[100px] w-full text-secondary font-logo absolute sm:-top-12 top-0 left-0 sm:-translate-y-1/2 text-center text-nowrap z-20" ]
                        [ Html.text "Sign In" ]
                    , Html.form
                        [ HA.class "bg-primary flex flex-col mb:p-28 gap-4 max-w-3xl justify-center relative h-[596px] sm:p-14 p-4 pt-40"
                        , HE.onSubmit MsgSubmitForm
                        ]
                        [ viewBackBnt navigationKey
                        , Html.div
                            [ HA.class "grid gap-2" ]
                            [ Html.label []
                                [ Html.text "Email"
                                , Html.input
                                    [ HA.class "w-full bg-bgLight rounded pl-2 py-2"
                                    , HA.required True
                                    ]
                                    []
                                ]
                            , Html.label []
                                [ Html.text "Password"
                                , Html.input
                                    [ HA.class "w-full bg-bgLight rounded pl-2 py-2"
                                    , HA.type_ "password"
                                    , HA.required True
                                    ]
                                    []
                                ]
                            ]
                        , Html.p
                            [ HA.class "sm:text-base text-sm text-center font-bold cursor-pointer"
                            , HE.onClick MsgChangeFormType
                            ]
                            [ Html.span
                                [ HA.class "underline underline-offset-2"
                                ]
                                [ Html.text "Create an account" ]
                            , Html.text " to start exploring exhibitions, connect with artists, and receive exclusive updates."
                            ]
                        , case model.formState of
                            Resting ->
                                Html.button
                                    [ HA.class "text-nowrap text-sm py-2 px-4 bg-secondary rounded font-bold ml-auto w-fit text-textLight hover:opacity-80 focus-within:opacity-80 cursor-pointer" ]
                                    [ Html.text "Sign In" ]

                            Loading ->
                                Html.button
                                    [ HA.class "text-nowrap text-sm py-2 px-4 bg-secondary rounded font-bold ml-auto w-fit text-textLight" ]
                                    [ Html.text "Loading . . ." ]

                            Success ->
                                Html.button
                                    [ HA.class "text-nowrap text-sm py-2 px-4 bg-secondary rounded font-bold ml-auto w-fit text-textLight" ]
                                    [ Html.text "Success" ]

                            Error ->
                                Html.button
                                    [ HA.class "text-nowrap text-sm py-2 px-4 bg-secondary rounded font-bold ml-auto w-fit text-textLight hover:opacity-80 focus-within:opacity-80 cursor-pointer" ]
                                    [ Html.text "Sign In" ]
                        ]
                    ]
                ]

        Register ->
            Html.main_
                [ HA.class "relative z-0 h-svh bg-bgDark w-full grid content-center bg-text p-4" ]
                [ Html.section
                    [ HA.class "grid place-content-center relative" ]
                    [ Html.h1
                        [ HA.class "lg:text-sizeBg md:text-[200px] sm:text-[160px] text-[80px] w-full text-secondary font-logo absolute sm:-top-12 top-0 left-0 sm:-translate-y-1/2 text-center text-nowrap z-20" ]
                        [ Html.text "Register" ]
                    , Html.form
                        [ HA.class "bg-primary flex flex-col mb:p-28 gap-4 max-w-3xl justify-center relative h-[596px] sm:p-14 p-4 pt-40"
                        , HE.onSubmit MsgSubmitForm
                        ]
                        [ viewBackBnt navigationKey
                        , Html.div
                            [ HA.class "grid gap-2" ]
                            [ Html.label []
                                [ Html.text "Email"
                                , Html.input
                                    [ HA.class "w-full bg-bgLight rounded pl-2 py-2"
                                    , HA.required True
                                    ]
                                    []
                                ]
                            , Html.label []
                                [ Html.text "Password"
                                , Html.input
                                    [ HA.class "w-full bg-bgLight rounded pl-2 py-2"
                                    , HA.type_ "password"
                                    , HA.required True
                                    ]
                                    []
                                ]
                            , Html.label []
                                [ Html.text "Repeat Password"
                                , Html.input
                                    [ HA.class "w-full bg-bgLight rounded pl-2 py-2"
                                    , HA.type_ "password"
                                    , HA.required True
                                    ]
                                    []
                                ]
                            ]
                        , Html.p
                            [ HA.class "sm:text-base text-sm text-center font-bold cursor-pointer"
                            , HE.onClick MsgChangeFormType
                            ]
                            [ Html.span 
                                [ HA.class "underline underline-offset-2"] 
                                [ Html.text "Log in"] 
                            , Html.text " to continue discovering and engaging with inspiring art collections."
                            ]
                        , case model.formState of
                            Resting ->
                                Html.button
                                    [ HA.class "text-nowrap text-sm py-2 px-4 bg-secondary rounded font-bold ml-auto w-fit text-textLight hover:opacity-80 focus-within:opacity-80 cursor-pointer" ]
                                    [ Html.text "Register" ]

                            Loading ->
                                Html.button
                                    [ HA.class "text-nowrap text-sm py-2 px-4 bg-secondary rounded font-bold ml-auto w-fit text-textLight" ]
                                    [ Html.text "Loading . . ." ]

                            Success ->
                                Html.button
                                    [ HA.class "text-nowrap text-sm py-2 px-4 bg-secondary rounded font-bold ml-auto w-fit text-textLight" ]
                                    [ Html.text "Success" ]

                            Error ->
                                Html.button
                                    [ HA.class "text-nowrap text-sm py-2 px-4 bg-secondary rounded font-bold ml-auto w-fit text-textLight hover:opacity-80 focus-within:opacity-80 cursor-pointer" ]
                                    [ Html.text "Register" ]
                        ]
                    ]
                ]


viewBackBnt : Navigation.Key -> Html Msg
viewBackBnt navigationKey =
    Html.a
        [ HA.class "absolute bottom-8 left-8 p-4 hover:text-textLight focus-within:text-textLight cursor-pointer"
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
