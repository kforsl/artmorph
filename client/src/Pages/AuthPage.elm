module Pages.AuthPage exposing (..)

import Components.UI
import Html exposing (Html, div, form, h1, p, span, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick, onSubmit)


type alias Model =
    { formTitle : String
    , formInputs : List String
    , formLinkText : String
    , formMessage : String
    , formBtnText : String
    }


type Msg
    = MsgChangeFormType
    | MsgSubmitForm


initModel : Model
initModel =
    { formTitle = "Sign In"
    , formInputs = [ "Email", "Password" ]
    , formLinkText = "Create an account"
    , formMessage = "to start exploring exhibitions, connect with artists, and receive exclusive updates."
    , formBtnText = "Login"
    }


view : Model -> Html Msg
view model =
    div [ class " absolute top-0 z-50 h-full max-h-svh bg-bgDark w-full grid place-content-center" ]
        [ Components.UI.bgTextSecondary
        , form [ class "bg-primary flex flex-col p-28 pt-40 gap-4 max-w-3xl justify-center", onSubmit MsgSubmitForm ]
            [ h1 [ class "text-sizeBg w-full text-secondary font-logo absolute top-1/3 -translate-y-2/3 left-0 text-center text-nowrap z-20" ] [ text model.formTitle ]
            , div [ class "grid gap-2" ] (List.map Components.UI.formInput model.formInputs)
            , p [ class "text-base font-bread text-center font-bold" ] [ span [ class "mr-1 underline underline-offset-2 cursor-pointer", onClick MsgChangeFormType ] [ text model.formLinkText ], text model.formMessage ]
            , Components.UI.buttonSecondary model.formBtnText
            ]
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MsgChangeFormType ->
            if model.formTitle == "Sign In" then
                let
                    changedInputs =
                        { formTitle = "Register"
                        , formInputs = [ "Email", "Password", "Repeat Password" ]
                        , formLinkText = "Log in"
                        , formMessage = "to continue discovering and engaging with          inspiring art                collections."
                        , formBtnText = "Sign up"
                        }
                in
                ( changedInputs, Cmd.none )

            else
                let
                    changedInputs =
                        { formTitle = "Sign In"
                        , formInputs = [ "Email", "Password" ]
                        , formLinkText = "Create an account"
                        , formMessage = "to start exploring exhibitions, connect with artists, and receive exclusive updates."
                        , formBtnText = "Login"
                        }
                in
                ( changedInputs, Cmd.none )

        MsgSubmitForm ->
            ( { model | formBtnText = "Loading..." }, Cmd.none )
