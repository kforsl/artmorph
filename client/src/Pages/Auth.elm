module Pages.Auth exposing (..)

 
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
    { formType = Login
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
            ( { model | formState = Loading }, sendToSelfWithDelay 2000 MsgSubmitSuccess )

        MsgSubmitError ->
            ( { model | formState = Error },  Cmd.none)

        MsgSubmitResting ->
            ( { model | formState = Resting }, Cmd.none )

        MsgSubmitSuccess ->
            ( { model | formState = Success }, sendToSelfWithDelay 4000 MsgSubmitResting )


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
                            [ Html.label []
                                [ Html.text "Email"
                                , Html.input
                                    [ HA.class "w-full rounded-lg pl-2 py-2" ]
                                    []
                                ]
                            , Html.label []
                                [ Html.text "Password"
                                , Html.input
                                    [ HA.class "w-full rounded-lg pl-2 py-2" ]
                                    []
                                ]
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
                , bgTextSecondary
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
                            [ Html.label []
                                [ Html.text "Email"
                                , Html.input
                                    [ HA.class "w-full rounded-lg pl-2 py-2" ]
                                    []
                                ]
                            , Html.label []
                                [ Html.text "Password"
                                , Html.input
                                    [ HA.class "w-full rounded-lg pl-2 py-2" ]
                                    []
                                ]
                            , Html.label []
                                [ Html.text "Repeat Password"
                                , Html.input
                                    [ HA.class "w-full rounded-lg pl-2 py-2" ]
                                    []
                                ]
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
                , bgTextSecondary
                ]


bgTextSecondary : Html msg
bgTextSecondary =
    Html.figure
        [ HA.class "absolute bottom-0 w-full -z-[1]" ]
        [ Html.h5
            [ HA.class "text-secondary text-center text-5xl font-title text-nowrap" ]
            [ Html.text "The Art of Transformation — Beyond Boundaries. " ]
        , Html.h6
            [ HA.class "text-secondary text-center text-sizeBg leading-none font-logo pb-4 z-0" ]
            [ Html.text "ArtMorph" ]
        ]

