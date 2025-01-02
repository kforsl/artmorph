module Main exposing (..)

import Browser
import Browser.Navigation
import Html exposing (Html, a, div, footer, h1, h2, header, li, nav, section, text, ul)
import Html.Attributes exposing (class, href)
import Pages.AboutPage as AboutPage
import Pages.ArtistPage as ArtistPage
import Pages.ArtworkPage as ArtworkPage
import Pages.AuthPage as AuthPage
import Pages.ExhibitionPage as ExhibitionPage
import Pages.HomePage as HomePage
import Router
import Url exposing (Url)


type alias Model =
    { url : Url.Url
    , navigationKey : Browser.Navigation.Key
    , modelAboutPage : AboutPage.Model
    , modelArtistPage : ArtistPage.Model
    , modelArtworkPage : ArtworkPage.Model
    , modelAuthPage : AuthPage.Model
    , modelExhibitionPage : ExhibitionPage.Model
    , modelHomePage : HomePage.Model
    }


type Msg
    = MsgUrlChange Url.Url
    | MsgUrlRequest Browser.UrlRequest
    | MsgAuthPage AuthPage.Msg


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = onUrlChange
        , onUrlRequest = onUrlRequest
        }


init : () -> Url -> Browser.Navigation.Key -> ( Model, Cmd Msg )
init _ url navigationKey =
    ( initModel url navigationKey, Cmd.none )


initModel : Url -> Browser.Navigation.Key -> Model
initModel url navigationKey =
    { url = url
    , navigationKey = navigationKey
    , modelAboutPage = AboutPage.initModel
    , modelArtistPage = ArtistPage.initModel
    , modelArtworkPage = ArtworkPage.initModel
    , modelAuthPage = AuthPage.initModel
    , modelExhibitionPage = ExhibitionPage.initModel
    , modelHomePage = HomePage.initModel
    }


view : Model -> Browser.Document Msg
view model =
    { title = getTitle model.url
    , body = [ viewContent model ]
    }


getTitle : Url -> String
getTitle url =
    if String.startsWith "/about" url.path then
        "About ArtMorph"

    else if String.startsWith "/artist" url.path then
        "Artist"

    else if String.startsWith "/artwork" url.path then
        "Artwork"

    else if String.startsWith "/auth" url.path then
        "Auth Page"

    else if String.startsWith "/exhibition" url.path then
        "Exhibition"

    else
        "ArtMorph"


viewContent : Model -> Html Msg
viewContent model =
    div [ class "max-w-svw min-h-full grid auto-rows-max place-content-between grid-cols-1" ]
        [ viewHeader
        , viewPage model
        , viewFooter
        ]


viewHeader : Html msg
viewHeader =
    header [ class "bg-bgDark fixed top-0 w-full z-50" ]
        [ div [ class "flex justify-between   max-w-maxWidth m-auto" ]
            [ h1 [ class "text-6xl font-logo text-primary font-medium content-center py-2" ] [ Html.text "ArtMorph" ]
            , viewNavigation
            ]
        ]


viewNavigation : Html msg
viewNavigation =
    nav [ class "max-w-fit content-center" ]
        [ ul [ class "grid grid-cols-3 auto-cols-max" ]
            [ viewLink "/" "Home"
            , viewLink "/about" "About"
            , viewLink "/exhibition" "Exhibitions"
            , viewLink "/artist" "Artist"
            , viewLink "/artwork" "Artwork"
            , viewLink "/auth" "Login"
            ]
        ]


viewLink : String -> String -> Html msg
viewLink path label =
    li [] [ a [ class "block p-4 text-base font-title text-primary font-bold hover:cursor-pointer hover:underline underline-offset-2", href path ] [ text label ] ]


viewFooter : Html msg
viewFooter =
    footer [ class "p-8 bg-bgDark min-h-72 max-w-full grid auto-rows-max place-content-between grid-cols-1" ]
        [ section [ class "max-w-maxWidth m-auto w-full" ]
            [ h2 [ class "text-4xl text-primary font-logo font-medium" ] [ text "ArtMorph" ]
            ]
        , h2 [ class "text-5xl text-secondary text-center font-title" ] [ text "The Art of Transformation — Beyond Boundaries." ]
        ]


viewPage : Model -> Html Msg
viewPage model =
    case Router.fromUrl model.url of
        Just Router.RouteAboutPage ->
            AboutPage.view model.modelAboutPage

        Just Router.RouteArtistPage ->
            ArtistPage.view model.modelArtistPage

        Just Router.RouteArtworkPage ->
            ArtworkPage.view model.modelArtworkPage

        Just Router.RouteAuthPage ->
            Html.map MsgAuthPage (AuthPage.view model.modelAuthPage)

        Just Router.RouteExhibitionPage ->
            ExhibitionPage.view model.modelExhibitionPage

        Just Router.RouteHomePage ->
            HomePage.view model.modelHomePage

        Nothing ->
            div [] [ h1 [] [ text "Error" ] ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MsgUrlChange url ->
            ( { model | url = url }, Cmd.none )

        MsgUrlRequest urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model
                    , Browser.Navigation.pushUrl
                        model.navigationKey
                        (Url.toString url)
                    )

                Browser.External url ->
                    ( model, Browser.Navigation.load url )

        MsgAuthPage msgAuthPage ->
            let
                ( newAuthPageModel, cmdAuthPage ) =
                    AuthPage.update msgAuthPage model.modelAuthPage
            in
            ( { model | modelAuthPage = newAuthPageModel }
            , Cmd.map MsgAuthPage cmdAuthPage
            )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


onUrlChange : Url.Url -> Msg
onUrlChange url =
    MsgUrlChange url


onUrlRequest : Browser.UrlRequest -> Msg
onUrlRequest urlRequest =
    MsgUrlRequest urlRequest
