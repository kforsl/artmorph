module Main exposing (..)

import Browser
import Browser.Navigation
import Data.Artist as Artist
import Data.Artwork as Artwork
import Data.Exhibitions as Exhibition
import Html exposing (Html)
import Html.Attributes as HA
import Pages.AboutPage as AboutPage
import Pages.ArtistPage as ArtistPage
import Pages.ArtworkPage as ArtworkPage
import Pages.AuthPage as AuthPage
import Pages.ExhibitionPage as ExhibitionPage
import Pages.HomePage as HomePage
import Url exposing (Url)
import Url.Parser


type alias Model =
    { url : Url.Url
    , navigationKey : Browser.Navigation.Key
    , modelAboutPage : AboutPage.Model
    , modelArtistPage : ArtistPage.Model
    , modelArtworkPage : ArtworkPage.Model
    , modelAuthPage : AuthPage.Model
    , modelExhibitionPage : ExhibitionPage.Model
    , modelHomePage : HomePage.Model
    , dataArtist : Artist.Model
    , dataArtwork : Artwork.Model
    , dataExhibit : Exhibition.Model
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
    , dataArtist = Artist.initModel
    , dataArtwork = Artwork.initModel
    , dataExhibit = Exhibition.initModel
    }


type Msg
    = MsgUrlChange Url.Url
    | MsgUrlRequest Browser.UrlRequest
    | MsgAuthPage AuthPage.Msg
    | MsgAboutPage AboutPage.Msg
    | MsgHomePage HomePage.Msg
    | MsgDataArtist Artist.Msg
    | MsgDataArtwork Artwork.Msg
    | MsgDataExhibition Exhibition.Msg


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

        MsgDataArtist _ ->
            Debug.todo "branch 'MsgDataArtist _' not implemented"

        MsgDataArtwork _ ->
            Debug.todo "branch 'MsgDataArtwork _' not implemented"

        MsgDataExhibition _ ->
            Debug.todo "branch 'MsgDataExhibition _' not implemented"


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


onUrlChange : Url.Url -> Msg
onUrlChange url =
    MsgUrlChange url


onUrlRequest : Browser.UrlRequest -> Msg
onUrlRequest urlRequest =
    MsgUrlRequest urlRequest


aboutPageParser : Url.Parser.Parser a a
aboutPageParser =
    Url.Parser.s "about"


artistPageParser : Url.Parser.Parser a a
artistPageParser =
    Url.Parser.s "artist"


artworkPageParser : Url.Parser.Parser a a
artworkPageParser =
    Url.Parser.s "artwork"


authPageParser : Url.Parser.Parser a a
authPageParser =
    Url.Parser.s "auth"


exhibitionPageParser : Url.Parser.Parser a a
exhibitionPageParser =
    Url.Parser.s "exhibition"


homePageParser : Url.Parser.Parser a a
homePageParser =
    Url.Parser.top


type Route
    = RouteAboutPage
    | RouteArtistPage
    | RouteArtworkPage
    | RouteAuthPage
    | RouteExhibitionPage
    | RouteHomePage


routerParser : Url.Parser.Parser (Route -> c) c
routerParser =
    Url.Parser.oneOf
        [ Url.Parser.map RouteAboutPage aboutPageParser
        , Url.Parser.map RouteArtistPage artistPageParser
        , Url.Parser.map RouteArtworkPage artworkPageParser
        , Url.Parser.map RouteAuthPage authPageParser
        , Url.Parser.map RouteExhibitionPage exhibitionPageParser
        , Url.Parser.map RouteHomePage homePageParser
        ]


fromUrl : Url.Url -> Maybe Route
fromUrl url =
    Url.Parser.parse routerParser url


asPath : Route -> String
asPath route =
    case route of
        RouteAboutPage ->
            "/about"

        RouteArtistPage ->
            "/artist"

        RouteArtworkPage ->
            "/artwork"

        RouteAuthPage ->
            "/auth"

        RouteExhibitionPage ->
            "/exhibition"

        RouteHomePage ->
            "/"


view : Model -> Browser.Document Msg
view model =
    { title = getTitle model.url
    , body = [ viewPage model ]
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
        "ArtMorph Auth"

    else if String.startsWith "/exhibition" url.path then
        "Exhibition"

    else
        "ArtMorph"


viewPage : Model -> Html Msg
viewPage model =
    case fromUrl model.url of
        Just RouteAboutPage ->
            Html.map MsgAboutPage (AboutPage.view model.modelAboutPage)

        Just RouteArtistPage ->
            ArtistPage.view model.modelArtistPage

        Just RouteArtworkPage ->
            ArtworkPage.view model.modelArtworkPage

        Just RouteAuthPage ->
            Html.map MsgAuthPage (AuthPage.view model.modelAuthPage)

        Just RouteExhibitionPage ->
            ExhibitionPage.view model.modelExhibitionPage

        Just RouteHomePage ->
            Html.map MsgHomePage (HomePage.view model.modelHomePage)

        Nothing ->
            Html.div [] [ Html.h1 [ HA.class "text-center" ] [ Html.text "Error" ] ]


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
