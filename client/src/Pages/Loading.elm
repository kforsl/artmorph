module Pages.Loading exposing (..)
import Svg
import Html exposing (Html)
import Html.Attributes as HA
import Svg 
import Svg.Attributes as SA


view : Html msg
view =
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
    Html.figure [ HA.class "min-h-full grid place-content-center bg-bgDark bg-text" ]
        [ svgLoader
        ]