module Update exposing (..)

import Browser
import Browser.Navigation
import Msg exposing (Msg(..))
import Pages.AboutPage as AboutPage
import Pages.ArtistPage as ArtistPage
import Pages.ArtworkPage as ArtworkPage
import Pages.AuthPage as AuthPage
import Pages.ExhibitionPage as ExhibitionPage
import Pages.HomePage as HomePage
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

        MsgAboutPage msgAboutPage ->
            let
                ( newAboutPageModel, cmdAuthPage ) =
                    AboutPage.update msgAboutPage model.modelAboutPage
            in
            ( { model | modelAboutPage = newAboutPageModel }
            , Cmd.map MsgAuthPage cmdAuthPage
            )

        MsgHomePage msgHomePage ->
            let
                ( newHomePageModel, cmdAuthPage ) =
                    HomePage.update msgHomePage model.modelHomePage
            in
            ( { model | modelHomePage = newHomePageModel }
            , Cmd.map MsgHomePage cmdAuthPage
            )
