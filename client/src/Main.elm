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
import Pages.Exhibition
import Pages.Exhibitions
import Pages.Home
import Route
import Svg exposing (Svg)
import Svg.Attributes as SA
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
    }


type Msg
    = None
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
    

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        None ->
            ( model
            , Cmd.none
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
                    { artistData = newArtistData }

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
    case ( model.isPageLoading, model.isPageError ) of
        ( True, False ) ->
            viewLoading

        ( False, True ) ->
            viewError model

        _ ->
            Html.main_ [ HA.class "bg-bgLight" ]
                [ Html.Extra.viewIf model.isHeaderShowing Components.Header.view
                , viewPage model
                , Html.Extra.viewIf (not model.isPageLoading) Components.Footer.view
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
            viewPageNotFound


viewLoading : Html Msg
viewLoading =
    let
        svgLoader : Html msg
        svgLoader =
            Svg.svg
                [ SA.width "156"
                , SA.height "218"
                , SA.viewBox "0 0 156 218"
                , SA.fill "none"
                ]
                [ Svg.path
                    [ SA.d "M5 215.5L78 14L149 209.5H30.5"
                    , SA.stroke "#EC5001"
                    , SA.strokeWidth "9"
                    , SA.class "loading"
                    ]
                    []
                ]
    in
    Html.main_ [ HA.class "min-h-full grid place-content-center bg-bgDark bg-text" ]
        [ svgLoader
        ]


viewError : Model -> Html Msg
viewError model =
    Html.div [] [ Html.text "Error" ]


viewPageNotFound : Html Msg
viewPageNotFound =
    Html.div [] [ Html.text "Page not found" ]


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
