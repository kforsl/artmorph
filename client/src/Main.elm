module Main exposing (..)

import Api.Artist
import Api.Artwork
import Api.Exhibitions
import Browser
import Browser.Dom exposing (setViewport)
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
import Pages.Error
import Pages.Exhibition
import Pages.Exhibitions
import Pages.Home
import Pages.Loading
import Pages.NotFound
import Route
import Task
import Url exposing (Url)


type alias Model =
    { url : Url
    , navigationKey : Navigation.Key
    , isHeaderShowing : Bool
    , isPageLoading : Bool
    , isPageError : Bool
    , modelAboutPage : Pages.About.Model
    , modelArtistPage : Pages.Artist.Model
    , modelArtistsPage : Pages.Artists.Model
    , modelArtworkPage : Pages.Artwork.Model
    , modelAuthPage : Pages.Auth.Model
    , modelExhibitionPage : Pages.Exhibition.Model
    , modelExhibitionsPage : Pages.Exhibitions.Model
    , modelHomePage : Pages.Home.Model
    , modelErrorPage : Pages.Error.Model
    , modelHeader : Components.Header.Model
    }


init : () -> Url -> Navigation.Key -> ( Model, Cmd Msg )
init _ url navigationKey =
    ( initModel url navigationKey
    , Cmd.batch
        [ Cmd.map MsgFetchArtistData Api.Artist.fetchArtists
        , Cmd.map MsgFetchArtworkData Api.Artwork.fetchArtwork
        , Cmd.map MsgFetchExhibitionData Api.Exhibitions.fetchExhibition
        ]
    )


initModel : Url -> Navigation.Key -> Model
initModel url navigationKey =
    { url = url
    , navigationKey = navigationKey
    , isHeaderShowing = False
    , isPageLoading = True
    , isPageError = False
    , modelAboutPage = Pages.About.initModel
    , modelArtistPage = Pages.Artist.initModel
    , modelArtistsPage = Pages.Artists.initModel
    , modelArtworkPage = Pages.Artwork.initModel
    , modelAuthPage = Pages.Auth.initModel
    , modelExhibitionPage = Pages.Exhibition.initModel
    , modelExhibitionsPage = Pages.Exhibitions.initModel
    , modelHomePage = Pages.Home.initModel
    , modelErrorPage = Pages.Error.initModel
    , modelHeader = Components.Header.init
    }


type Msg
    = None
    | MsgScrollToTop 
    | MsgUrlChange Url
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
    | MsgHeader Components.Header.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        None ->
            ( model
            , Cmd.none
            )

        MsgScrollToTop -> 
            let
                scrollCmd = 
                        setViewport 0 0
                            |> Task.perform (always None)
            in
            ( model 
            , Cmd.batch 
                [ scrollCmd
                ] 
            )

        MsgUrlChange url ->
            let
                scrollCmd =
                    setViewport 0 0
                        |> Task.perform (always None)

                newIsHeaderShowing =
                    url.path /= "/auth"
            in
            ( { model
                | url = url
                , isHeaderShowing = newIsHeaderShowing
                , isPageLoading = False
              }
            , Cmd.batch
                [ scrollCmd
                ]
            )

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
                    Api.Artist.update msgApiArtist Api.Artist.initModel

                updatedHomePageModel =
                    { artistData = newArtistData
                    , artworkData = model.modelHomePage.artworkData
                    , exhibitionData = model.modelHomePage.exhibitionData
                    , newsletterModel = model.modelHomePage.newsletterModel
                    }

                updatedArtistsPageModel =
                    { artistData = newArtistData
                    , artworkData = model.modelArtistsPage.artworkData
                    }

                updatedArtistPageModel =
                    { artistData = newArtistData
                    , artworkData = model.modelArtistPage.artworkData
                    }

                updatedAboutPageModel =
                    { artistData = newArtistData
                    , newsletterModel = model.modelAboutPage.newsletterModel
                    , formState = model.modelAboutPage.formState
                    }

                updatedExhibitionModel =
                    { artistData = newArtistData
                    , exhibitionData = model.modelExhibitionPage.exhibitionData
                    }

                isPageLoading =
                    List.length newArtistData
                        == 0
                        && List.length model.modelArtistPage.artworkData
                        == 0
                        && List.length model.modelHomePage.exhibitionData
                        == 0

                isHeaderShowing =
                    if not isPageLoading then
                        model.url.path /= "/auth"

                    else
                        False
            in
            ( { model
                | modelHomePage = updatedHomePageModel
                , modelArtistsPage = updatedArtistsPageModel
                , modelArtistPage = updatedArtistPageModel
                , modelAboutPage = updatedAboutPageModel
                , modelExhibitionPage = updatedExhibitionModel
                , isPageLoading = isPageLoading
                , isHeaderShowing = isHeaderShowing
              }
            , Cmd.map MsgFetchArtistData cmdArtistApi
            )

        MsgFetchArtworkData msgApiArtwork ->
            let
                ( newArtworkData, cmdArtworkApi ) =
                    Api.Artwork.update msgApiArtwork Api.Artwork.initModel

                updatedHomePageModel =
                    { artistData = model.modelHomePage.artistData
                    , artworkData = newArtworkData
                    , exhibitionData = model.modelHomePage.exhibitionData
                    , newsletterModel = model.modelHomePage.newsletterModel
                    }

                updatedArtistPageModel =
                    { artistData = model.modelArtistPage.artistData
                    , artworkData = newArtworkData
                    }

                updatedArtistsPageModel =
                    { artistData = model.modelArtistsPage.artistData
                    , artworkData = newArtworkData
                    }

                updatedArtworkPageModel =
                    { artworkData = newArtworkData
                    }

                isPageLoading =
                    List.length model.modelHomePage.artistData
                        == 0
                        && List.length newArtworkData
                        == 0
                        && List.length model.modelHomePage.exhibitionData
                        == 0

                isHeaderShowing =
                    if not isPageLoading then
                        model.url.path /= "/auth"

                    else
                        False
            in
            ( { model
                | modelHomePage = updatedHomePageModel
                , modelArtistPage = updatedArtistPageModel
                , modelArtworkPage = updatedArtworkPageModel
                , modelArtistsPage = updatedArtistsPageModel
                , isPageLoading = isPageLoading
                , isHeaderShowing = isHeaderShowing
              }
            , Cmd.map MsgFetchArtworkData cmdArtworkApi
            )

        MsgFetchExhibitionData msgApiExhibitions ->
            let
                ( newExhibitionsData, cmdExhibitionsApi ) =
                    Api.Exhibitions.update msgApiExhibitions Api.Exhibitions.initModel

                updatedHomePageModel =
                    { artistData = model.modelHomePage.artistData
                    , artworkData = model.modelHomePage.artworkData
                    , exhibitionData = newExhibitionsData
                    , newsletterModel = model.modelHomePage.newsletterModel
                    }

                updatedExhibitionsPageModel =
                    { exhibitionData = newExhibitionsData
                    }

                updatedExhibitionPageModel =
                    { exhibitionData = newExhibitionsData
                    , artistData = model.modelHomePage.artistData
                    }

                isPageLoading =
                    List.length model.modelHomePage.artistData
                        == 0
                        && List.length model.modelArtistPage.artworkData
                        == 0
                        && List.length newExhibitionsData
                        == 0

                isHeaderShowing =
                    if not isPageLoading then
                        model.url.path /= "/auth"

                    else
                        False
            in
            ( { model
                | modelHomePage = updatedHomePageModel
                , modelExhibitionsPage = updatedExhibitionsPageModel
                , modelExhibitionPage = updatedExhibitionPageModel
                , isPageLoading = isPageLoading
                , isHeaderShowing = isHeaderShowing
              }
            , Cmd.map MsgFetchExhibitionData cmdExhibitionsApi
            )

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

        MsgHeader msgHeader -> 
            let
                ( newHeaderModel, cmdHeader ) =
                    Components.Header.update msgHeader model.modelHeader
            in
            ( { model | modelHeader = newHeaderModel } , Cmd.map MsgHeader cmdHeader)


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
    , body =
        [ viewContent model
        ]
    }


viewContent : Model -> Html Msg
viewContent model =
    Html.div [ HA.class "bg-bgLight max-w-screen overflow-x-hidden" ]
        [ Html.Extra.viewIf model.isHeaderShowing
            (Html.map MsgHeader (Components.Header.view model.modelHeader))

        , case ( model.isPageLoading, model.isPageError ) of
            ( True, False ) ->
                Pages.Loading.view

            ( False, True ) ->
                Pages.Error.view model.modelErrorPage

            _ ->
                viewPage model
        , Html.Extra.viewIf (not model.isPageLoading)( Components.Footer.view MsgScrollToTop )
        ]


viewPage : Model -> Html Msg
viewPage model =
    case Route.fromUrl model.url of
        Just Route.RouteAboutPage ->
            Html.map MsgAboutPage (Pages.About.view model.modelAboutPage)

        Just (Route.RouteArtistPage id) ->
            Html.map MsgArtistPage (Pages.Artist.view model.modelArtistPage id)

        Just Route.RouteArtistsPage ->
            Html.map MsgArtistsPage (Pages.Artists.view model.modelArtistsPage)

        Just (Route.RouteArtworkPage id) ->
            Html.map MsgArtworkPage (Pages.Artwork.view model.modelArtworkPage id model.navigationKey)

        Just Route.RouteAuthPage ->
            Html.map MsgAuthPage (Pages.Auth.view model.modelAuthPage model.navigationKey)

        Just (Route.RouteExhibitionPage id) ->
            Html.map MsgExhibitionPage (Pages.Exhibition.view model.modelExhibitionPage id)

        Just Route.RouteExhibitionsPage ->
            Html.map MsgExhibitionsPage (Pages.Exhibitions.view model.modelExhibitionsPage)

        Just Route.RouteHomePage ->
            Html.map MsgHomePage (Pages.Home.view model.modelHomePage)

        Nothing ->
            Pages.NotFound.view


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
