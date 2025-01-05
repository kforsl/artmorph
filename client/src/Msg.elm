module Msg exposing (..)

import Browser
import Pages.AboutPage as AboutPage
import Pages.AuthPage as AuthPage
import Pages.HomePage as HomePage
import Url


type Msg
    = MsgUrlChange Url.Url
    | MsgUrlRequest Browser.UrlRequest
    | MsgAuthPage AuthPage.Msg
    | MsgAboutPage AboutPage.Msg
    | MsgHomePage HomePage.Msg
