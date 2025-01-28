module Main exposing (..)

import Api.Artist exposing (Artist)
import Api.Artwork exposing (Artwork)
import Api.Exhibitions exposing (Exhibition)
import Browser
import Browser.Navigation as Navigation
import Components.Footer
import Components.Header
import Html exposing (Html)
import Html.Attributes as HA
import Html.Extra
import Pages.About
import Pages.Artist
import Pages.Artists
import Pages.Artwork
import Pages.Auth
import Pages.Exhibition
import Pages.Exhibitions
import Pages.Home
import Route
import Url exposing (Url)


type alias Model =
    { url : Url
    , navigationKey : Navigation.Key
    , sharedArtistsData : Api.Artist.Model
    , sharedArtworkData : Api.Artwork.Model
    , sharedExhibitionData : Api.Exhibitions.Model
    , modelAboutPage : Pages.About.Model
    , modelArtistPage : Pages.Artist.Model
    , modelArtistsPage : Pages.Artists.Model
    , modelArtworkPage : Pages.Artwork.Model
    , modelAuthPage : Pages.Auth.Model
    , modelExhibitionPage : Pages.Exhibition.Model
    , modelExhibitionsPage : Pages.Exhibitions.Model
    , modelHomePage : Pages.Home.Model
    }


type alias ApiResponse =
    { message : String
    , data : List Artist
    }


type alias SharedData =
    { artists : List Artist
    , artwork : List Artwork
    , exhibition : List Exhibition
    }


init : () -> Url -> Navigation.Key -> ( Model, Cmd Msg )
init _ url navigationKey =
    ( initModel url navigationKey, Cmd.batch [ Cmd.map MsgFetchArtistData Api.Artist.fetchArtists, Cmd.map MsgFetchArtworkData Api.Artwork.fetchArtwork, Cmd.map MsgFetchExhibitionData Api.Exhibitions.fetchExhibition  ] )


initModel : Url -> Navigation.Key -> Model
initModel url navigationKey =
    { url = url
    , navigationKey = navigationKey
    , sharedArtistsData = Api.Artist.initModel
    , sharedArtworkData = Api.Artwork.initModel
    , sharedExhibitionData = Api.Exhibitions.initModel
    , modelAboutPage = Pages.About.initModel
    , modelArtistPage = Pages.Artist.initModel
    , modelArtistsPage = Pages.Artists.initModel
    , modelArtworkPage = Pages.Artwork.initModel
    , modelAuthPage = Pages.Auth.initModel
    , modelExhibitionPage = Pages.Exhibition.initModel
    , modelExhibitionsPage = Pages.Exhibitions.initModel
    , modelHomePage = Pages.Home.initModel
    }


type Msg
    = MsgUrlChange Url
    | MsgUrlRequested Browser.UrlRequest
    | MsgFetchArtistData Api.Artist.Msg
    | MsgFetchArtworkData Api.Artwork.Msg
    | MsgFetchExhibitionData Api.Exhibitions.Msg
    | MsgAboutPage Pages.About.Msg
    | MsgArtistPage Pages.Artist.Msg
    | MsgArtistsPage Pages.Artists.Msg
    | MsgArtworkPage Pages.Artwork.Msg
    | MsgAuthPage Pages.Auth.Msg
    | MsgExhibitionPage Pages.Exhibition.Msg
    | MsgExhibitionsPage Pages.Exhibitions.Msg
    | MsgHomePage Pages.Home.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MsgUrlChange url ->
            ( { model | url = url }, Cmd.none )

        MsgUrlRequested urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model
                    , Navigation.pushUrl
                        model.navigationKey
                        (Url.toString url)
                    )

                Browser.External url ->
                    ( model
                    , Navigation.load url
                    )

        MsgFetchArtistData msgApiArtist ->
            let
                ( newArtistData, cmdArtistApi ) =
                    Api.Artist.update msgApiArtist model.sharedArtistsData

            in
            ( { model | sharedArtistsData = newArtistData }, Cmd.map MsgFetchArtistData cmdArtistApi )

        MsgFetchArtworkData msgApiArtwork ->
            let
                ( newArtworkData, cmdArtworkApi ) =
                    Api.Artwork.update msgApiArtwork model.sharedArtworkData
            in
            ( { model | sharedArtworkData = newArtworkData }, Cmd.map MsgFetchArtworkData cmdArtworkApi )

        MsgFetchExhibitionData msgApiExhibitions ->
            let
                ( newExhibitionsData, cmdExhibitionsApi ) =
                    Api.Exhibitions.update msgApiExhibitions model.sharedExhibitionData
            in
            ( { model | sharedExhibitionData = newExhibitionsData }, Cmd.map MsgFetchExhibitionData cmdExhibitionsApi )

        MsgAboutPage msgAboutPage ->
            let
                ( newAboutPageModel, cmdAboutPage ) =
                    Pages.About.update msgAboutPage model.modelAboutPage
            in
            ( { model | modelAboutPage = newAboutPageModel }, Cmd.map MsgAboutPage cmdAboutPage )

        MsgArtistPage msgArtistPage ->
            let
                ( newArtistPageModel, cmdArtistPage ) =
                    Pages.Artist.update msgArtistPage model.modelArtistPage
            in
            ( { model | modelArtistPage = newArtistPageModel }, Cmd.map MsgArtistPage cmdArtistPage )

        MsgArtistsPage msgArtistsPage ->
            let
                ( newArtistsPageModel, cmdArtistsPage ) =
                    Pages.Artists.update msgArtistsPage model.modelArtistsPage
            in
            ( { model | modelArtistsPage = newArtistsPageModel }, Cmd.map MsgArtistsPage cmdArtistsPage )

        MsgArtworkPage msgArtworkPage ->
            let
                ( newArtworkPageModel, cmdArtworkPage ) =
                    Pages.Artwork.update msgArtworkPage model.modelArtworkPage
            in
            ( { model | modelArtworkPage = newArtworkPageModel }, Cmd.map MsgArtworkPage cmdArtworkPage )

        MsgAuthPage msgAuthPage ->
            let
                ( newAuthPageModel, cmdAuthPage ) =
                    Pages.Auth.update msgAuthPage model.modelAuthPage
            in
            ( { model | modelAuthPage = newAuthPageModel }, Cmd.map MsgAuthPage cmdAuthPage )

        MsgExhibitionPage msgExhibitionPage ->
            let
                ( newExhibitionPageModel, cmdExhibitionPage ) =
                    Pages.Exhibition.update msgExhibitionPage model.modelExhibitionPage
            in
            ( { model | modelExhibitionPage = newExhibitionPageModel }, Cmd.map MsgExhibitionPage cmdExhibitionPage )

        MsgExhibitionsPage msgExhibitionsPage ->
            let
                ( newExhibitionsPageModel, cmdExhibitionsPage ) =
                    Pages.Exhibitions.update msgExhibitionsPage model.modelExhibitionsPage
            in
            ( { model | modelExhibitionsPage = newExhibitionsPageModel }, Cmd.map MsgExhibitionsPage cmdExhibitionsPage )

        MsgHomePage msgHomePage ->
            let
                ( newHomePageModel, cmdHomePage ) =
                    Pages.Home.update msgHomePage model.modelHomePage
            in
            ( { model | modelHomePage = newHomePageModel }, Cmd.map MsgHomePage cmdHomePage )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


onUrlChange : Url.Url -> Msg
onUrlChange url =
    MsgUrlChange url


onUrlRequest : Browser.UrlRequest -> Msg
onUrlRequest urlRequest =
    MsgUrlRequested urlRequest


view : Model -> Browser.Document Msg
view model =
    { title = "Artmorph"
    , body = [ viewContent model ]
    }


viewContent : Model -> Html Msg
viewContent model =
    Html.main_ [ HA.class "bg-bgLight" ]
        [ Html.Extra.viewIf (isNotAuthPage model.url) Components.Header.view
        , viewPage model
        , Html.Extra.viewIf (isNotAuthPage model.url) Components.Footer.view
        ]


isNotAuthPage : Url -> Bool
isNotAuthPage url =
    case Route.fromUrl url of
        Just Route.RouteAuthPage ->
            False

        _ ->
            True


viewPage : Model -> Html Msg
viewPage model =
    case Route.fromUrl model.url of
        Just Route.RouteAboutPage ->
            Html.map MsgAboutPage (Pages.About.view model.modelAboutPage)

        Just Route.RouteArtistPage ->
            Html.map MsgArtistPage (Pages.Artist.view model.modelArtistPage)

        Just Route.RouteArtistsPage ->
            Html.map MsgArtistsPage (Pages.Artists.view model.modelArtistsPage)

        Just Route.RouteArtworkPage ->
            Html.map MsgArtworkPage (Pages.Artwork.view model.modelArtworkPage)

        Just Route.RouteAuthPage ->
            Html.map MsgAuthPage (Pages.Auth.view model.modelAuthPage)

        Just Route.RouteExhibitionPage ->
            Html.map MsgExhibitionPage (Pages.Exhibition.view model.modelExhibitionPage)

        Just Route.RouteExhibitionsPage ->
            Html.map MsgExhibitionsPage (Pages.Exhibitions.view model.modelExhibitionsPage)

        Just Route.RouteHomePage ->
            Html.map MsgHomePage (Pages.Home.view model.modelHomePage)

        Nothing ->
            Html.text "Not Found 404"


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
