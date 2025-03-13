module Components.Carousel exposing (..)

import Html exposing (Html)
import Html.Attributes as HA
import Html.Events as HE
import Api.Exhibitions exposing (Exhibition)
import Svg
import Svg.Attributes as SA
import Html.Extra

type alias Model = 
    { activeCarouselItemIndex : Int
    }

init : Model 
init = 
    { activeCarouselItemIndex = 0
    }

type Msg 
    = NextCarouselItem Int
    | PrevCarouselItem Int


update : Msg -> Model -> (Model , Cmd Msg )
update msg model = 
    case msg of         
        NextCarouselItem maxIndex -> 
            let
                newActiveIndex = 
                    if (model.activeCarouselItemIndex < (maxIndex - 1) ) then
                            model.activeCarouselItemIndex + 1
                    else
                            0
            in
            ( { model | activeCarouselItemIndex = newActiveIndex } , Cmd.none)

        PrevCarouselItem maxIndex-> 
            let
                newActiveIndex = 
                    if (model.activeCarouselItemIndex == 0 ) then 
                        (maxIndex - 1)
                    else 
                        model.activeCarouselItemIndex - 1
                    
            in
            ( { model | activeCarouselItemIndex = newActiveIndex } , Cmd.none)


view : Model -> List Exhibition -> Html Msg 
view model exhibitions =
     Html.article
        [ HA.class "max-w-maxWidth w-full m-auto py-16 px-4 py-8" ]
        [ Html.section
            [ HA.class "flex flex-wrap justify-between mb-4" ]
            [ Html.h2
                [ HA.class "font-title md:text-3xl text-2xl mb-4 text-textDark col-span-full" ]
                [ Html.text "Featured Exhibitions" ]
            , Html.a
                [ HA.href "/exhibitions"
                , HA.class "place-self-center text-nowrap sm:text-base text-sm h-fit py-2.5 px-4 bg-primary rounded font-bold hover:opacity-80 focus-within:opacity-80"
                ]
                [ Html.text "Checkout all our exhibitions" ]
            ]
        , Html.ul
            [ HA.class "relative h-87 perspective-normal perspective-origin-top-center transition ease-in-out duration-200" ]
            ( List.append 
                (List.indexedMap
                    (\x exhibition -> viewExhibitionCard x model.activeCarouselItemIndex exhibition  )
                    exhibitions
                ) 
                [ Html.button 
                    [ HE.onClick (PrevCarouselItem (List.length exhibitions))
                    , HA.class "absolute z-20 left-0 top-0 h-87 sm:w-1/6 cursor-pointer grid place-items-center bg-bgLight hover:text-primary focus-within:text-primary"
                    ] 
                    [ prevItemSvg ] 
                , Html.button 
                    [ HE.onClick (NextCarouselItem (List.length exhibitions))
                    , HA.class "absolute z-20 right-0 top-0 h-87 sm:w-1/6 cursor-pointer grid place-items-center bg-bgLight hover:text-primary focus-within:text-primary"
                    ]
                    [ nextItemSvg ]
                ] 
            )
        ]


viewExhibitionCard : Int -> Int -> Exhibition -> Html Msg
viewExhibitionCard x activeIndex exhibition =
    Html.li
        [ HA.class ("p-1 -translate-x-1/2 absolute sm:max-w-md max-w-xs hover:opacity-80 focus-within:opacity-80 pointer-event-none") 
        , HA.classList 
            [ ("hidden", ( x /= activeIndex && (x > ( activeIndex + 2 ) || x < (activeIndex - 2))) )
            , ("top-0 left-1/2 z-20 pointer-event-auto", x == activeIndex )
            , ("top-0 left-3/4 z-10 -rotate-y-40 origin-right -translate-z-50", x == activeIndex + 1 )
            , ("top-0 left-1/4 z-10 rotate-y-40 origin-left -translate-z-50", x == activeIndex - 1 )
            , ("top-0 left-full -rotate-y-90 origin-right -translate-z-100", x == activeIndex + 2 )
            , ("top-0 left-0 rotate-y-90 origin-left -translate-z-100", x == activeIndex - 2 )
            ]
        ]
        [ Html.img
            [ HA.src exhibition.thumbnailUrl
            , HA.alt exhibition.description
            , HA.class "max-w-3xs object-cover object-top rounded"
            ]
            []
        , (Html.Extra.viewIf 
            (x == activeIndex) 
            ( Html.a
                [ HA.href ("/exhibitions/" ++ exhibition.id)
                , HA.class "absolute w-full h-full top-0 left-0"
                ]
                []
            )
            ) 
          
        ]

nextItemSvg : Html Msg
nextItemSvg = 
    Svg.svg
        [ SA.fill "none"
        , SA.viewBox "0 0 24 24"
        , SA.strokeWidth "1.5"
        , SA.stroke "currentColor"
        , SA.class "sm:size-10 size-8"
        ]
        [ Svg.path
            [ SA.strokeLinecap "round"
            , SA.strokeLinejoin "round"
            , SA.d "m5.25 4.5 7.5 7.5-7.5 7.5m6-15 7.5 7.5-7.5 7.5"
            ]
            []
        ]

prevItemSvg : Html Msg
prevItemSvg = 
    Svg.svg
        [ SA.fill "none"
        , SA.viewBox "0 0 24 24"
        , SA.strokeWidth "1.5"
        , SA.stroke "currentColor"
        , SA.class "sm:size-10 size-8"
        ]
        [ Svg.path
            [ SA.strokeLinecap "round"
            , SA.strokeLinejoin "round"
            , SA.d "m18.75 4.5-7.5 7.5 7.5 7.5m-6-15L5.25 12l7.5 7.5"
            ]
            []
        ]       
