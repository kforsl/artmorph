module Route exposing (..)

import Url exposing (Url)
import Url.Parser exposing ((</>))


type Route
    = RouteAboutPage
    | RouteArtistPage
    | RouteArtistsPage
    | RouteArtworkPage
    | RouteAuthPage
    | RouteExhibitionPage
    | RouteExhibitionsPage
    | RouteHomePage


aboutPageParser : Url.Parser.Parser a a
aboutPageParser =
    Url.Parser.s "about"


artistPageParser : Url.Parser.Parser a a
artistPageParser =
    Url.Parser.s "artists" </> Url.Parser.s "id"


artistsPageParser : Url.Parser.Parser a a
artistsPageParser =
    Url.Parser.s "artists"


artworkPageParser : Url.Parser.Parser a a
artworkPageParser =
    Url.Parser.s "artwork" </> Url.Parser.s "id"


authPageParser : Url.Parser.Parser a a
authPageParser =
    Url.Parser.s "auth"


exhibitionPageParser : Url.Parser.Parser a a
exhibitionPageParser =
    Url.Parser.s "exhibitions" </> Url.Parser.s "id"


exhibitionsPageParser : Url.Parser.Parser a a
exhibitionsPageParser =
    Url.Parser.s "exhibitions"


homePageParser : Url.Parser.Parser a a
homePageParser =
    Url.Parser.top


routerParser : Url.Parser.Parser (Route -> c) c
routerParser =
    Url.Parser.oneOf
        [ Url.Parser.map RouteAboutPage aboutPageParser
        , Url.Parser.map RouteArtistPage artistPageParser
        , Url.Parser.map RouteArtistsPage artistsPageParser
        , Url.Parser.map RouteArtworkPage artworkPageParser
        , Url.Parser.map RouteAuthPage authPageParser
        , Url.Parser.map RouteExhibitionPage exhibitionPageParser
        , Url.Parser.map RouteExhibitionsPage exhibitionsPageParser
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
            "/artists/id"

        RouteArtistsPage ->
            "/artists"

        RouteArtworkPage ->
            "/artwork/id"

        RouteAuthPage ->
            "auth"

        RouteExhibitionPage ->
            "/exhibitions/id"

        RouteExhibitionsPage ->
            "/exhibitions"

        RouteHomePage ->
            "/"
