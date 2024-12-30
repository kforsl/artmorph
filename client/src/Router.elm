module Router exposing (..)

import Url
import Url.Parser


type Route
    = RouteAboutPage
    | RouteArtistPage
    | RouteArtworkPage
    | RouteAuthPage
    | RouteExhibitionPage
    | RouteHomePage


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
