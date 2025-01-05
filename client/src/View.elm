module View exposing (..)

import Browser
import Components.Footer exposing (viewFooter)
import Components.Header exposing (viewHeader)
import Html exposing (Html, div, h1, text)
import Html.Attributes exposing (class)
import Msg exposing (Msg(..))
import Pages.AboutPage as AboutPage
import Pages.ArtistPage as ArtistPage
import Pages.ArtworkPage as ArtworkPage
import Pages.AuthPage as AuthPage
import Pages.ExhibitionPage as ExhibitionPage
import Pages.HomePage as HomePage
import Router
import Update exposing (Model)
import Url exposing (Url)


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


viewPage : Model -> Html Msg
viewPage model =
    case Router.fromUrl model.url of
        Just Router.RouteAboutPage ->
            Html.map MsgAboutPage (AboutPage.view model.modelAboutPage)

        Just Router.RouteArtistPage ->
            ArtistPage.view model.modelArtistPage

        Just Router.RouteArtworkPage ->
            ArtworkPage.view model.modelArtworkPage

        Just Router.RouteAuthPage ->
            Html.map MsgAuthPage (AuthPage.view model.modelAuthPage)

        Just Router.RouteExhibitionPage ->
            ExhibitionPage.view model.modelExhibitionPage

        Just Router.RouteHomePage ->
            Html.map MsgHomePage (HomePage.view model.modelHomePage)

        Nothing ->
            div [] [ h1 [ class "text-center" ] [ text "Error" ] ]
