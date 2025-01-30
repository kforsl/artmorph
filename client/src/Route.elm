module Route exposing (..)

import Url exposing (Url)
import Url.Parser exposing ((</>))


type Route
    = RouteAboutPage
    | RouteArtistPage ArtistId
    | RouteArtistsPage
    | RouteArtworkPage ArtworkId
    | RouteAuthPage
    | RouteExhibitionPage ExhibitionId
    | RouteExhibitionsPage
    | RouteHomePage


type alias ArtistId =
    String


type alias ArtworkId =
    String


type alias ExhibitionId =
    String


routerParser : Url.Parser.Parser (Route -> c ) c
routerParser =
    Url.Parser.oneOf
        [ Url.Parser.map RouteAboutPage ( Url.Parser.s "about" )
        , Url.Parser.map RouteArtistPage (Url.Parser.s "artists" </> Url.Parser.string)
        , Url.Parser.map RouteArtistsPage (Url.Parser.s "artists")
        , Url.Parser.map RouteArtworkPage (Url.Parser.s "artwork" </> Url.Parser.string)
        , Url.Parser.map RouteAuthPage (Url.Parser.s "auth")
        , Url.Parser.map RouteExhibitionPage (Url.Parser.s "exhibitions" </> Url.Parser.string)
        , Url.Parser.map RouteExhibitionsPage (Url.Parser.s "exhibitions")
        , Url.Parser.map RouteHomePage Url.Parser.top
        ]


fromUrl : Url -> Maybe Route
fromUrl url =
    -- Url.Parser.parse routerParser url
    let
        parsedRoute = Url.Parser.parse routerParser url
    in
    Debug.log "Parsed Route: " parsedRoute


asPath : Route -> String
asPath route =
    case route of
        RouteAboutPage ->
            "/about"

        RouteArtistPage id->
            "/artists/" ++ id

        RouteArtistsPage ->
            "/artists"

        RouteArtworkPage id ->
            "/artwork/" ++ id

        RouteAuthPage ->
            "/auth"

        RouteExhibitionPage id ->
            "/exhibitions/" ++ id

        RouteExhibitionsPage ->
            "/exhibitions"

        RouteHomePage ->
            "/"
