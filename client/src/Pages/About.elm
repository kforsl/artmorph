module Pages.About exposing (..)

import Api.Artist exposing (Artist)
import Components.Newsletter
import Html exposing (Html)
import Html.Attributes as HA
import Svg exposing (Svg)
import Svg.Attributes as SA


type alias Model =
    { artistData : List Artist
    }


initModel : Model
initModel =
    { artistData = []
    }


type Msg
    = None


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        None ->
            ( model, Cmd.none )


view : Model -> Html Msg
view model =
    Html.div []
        [ viewHero
        , viewAbout
        , viewArtists model.artistData
        , viewExhibitions
        , viewSpotlight
        , viewContact
        , Components.Newsletter.view
        ]


viewHero : Html Msg
viewHero =
    Html.section
        [ HA.class "bg-bgDark relative z-0 h-3/4 bg-text" ]
        [ Html.div
            [ HA.class "h-full max-w-maxWidth m-auto grid grid-cols-12 gap-8 pt-24" ]
            [ Html.figure
                [ HA.class "col-span-5 grid place-content-end" ]
                [ Html.img
                    [ HA.src "https://artmorph-images.s3.eu-north-1.amazonaws.com/about-hero.png"
                    , HA.class "rounded"
                    ]
                    []
                ]
            , Html.section
                [ HA.class "col-span-7 relative" ]
                [ Html.h2
                    [ HA.class "text-5xl text-primary flex flex-col justify-end gap-6 h-1/2 " ]
                    [ Html.span
                        [ HA.class "font-logo text-7xl text-right" ]
                        [ Html.text "About Artmorph" ]
                    , Html.span
                        [ HA.class "text-center font-title" ]
                        [ Html.text "Where every stroke" ]
                    , Html.span
                        [ HA.class "font-title" ]
                        [ Html.text "Tells a new story" ]
                    ]
                ]
            ]
        ]


viewAbout : Html Msg
viewAbout =
    Html.article
        [ HA.class "max-w-maxWidth m-auto pt-12 pb-24 grid grid-cols-12 border-b-2 border-bgDark" ]
        [ Html.section
            [ HA.class "p-4 col-span-7" ]
            [ Html.h2
                [ HA.class "font-title text-3xl mb-6 text-textDark col-span-full " ]
                [ Html.text "The Vision Behind ArtMorph" ]
            , Html.p
                [ HA.class "  text-base mb-4 leading-7" ]
                [ Html.text "Art is constantly evolving. It transforms, reinvents itself, and tells new stories with each passing era. At Artmorph, we believe in capturing these moments of change—curating digital exhibitions that explore art’s endless possibilities." ]
            , Html.p
                [ HA.class "  text-base mb-4 leading-7" ]
                [ Html.text """Our platform is more than a gallery; it’s a living, breathing space where artists and audiences connect across time, culture, and imagination. Through carefully curated themes, Artmorph showcases how creativity transcends boundaries, offering a unique journey through the worlds of transformation, history, nature, the supernatural, and beyond.""" ]
            , Html.p
                [ HA.class "  text-base mb-4 leading-7" ]
                [ Html.text """Every piece featured here is a reflection of this vision—a celebration of artistic evolution in all its forms. Welcome to Artmorph, where art never stays still.""" ]
            ]
        , Html.img
            [ HA.src "https://artmorph-images.s3.eu-north-1.amazonaws.com/about.png"
            , HA.class "h-full col-span-5"
            ]
            []
        ]


viewArtists : List Artist -> Html Msg
viewArtists artists =
    Html.article
        [ HA.class "max-w-maxWidth m-auto py-24 grid grid-cols-3 gap-x-8" ]
        [ Html.h2
            [ HA.class "font-title text-3xl mb-4 text-textDark col-span-full" ]
            [ Html.text "Meet the Visionaries Behind Artmorph" ]
        , Html.ul
            [ HA.class "flex overflow-hidden justify-between" ]
            (List.indexedMap viewArtistCard artists)
        , Html.section
            [ HA.class "col-span-2 flex flex-col justify-center" ]
            [ Html.p
                [ HA.class "  text-base mb-4 leading-7" ]
                [ Html.text "Artmorph is shaped by the vision of talented artists who explore transformation, history, nature, and the unknown through their work. Each artist brings their own unique approach, style, and storytelling to the exhibitions. Discover the creatives behind the collections and explore their artistic worlds." ]
            , Html.a
                [ HA.class "  text-base mb-2 text-primary underline underline-offset-2 hover:opacity-80 focus-within:opacity-80 p-2"
                , HA.href "/artists"
                ]
                [ Html.text " Discover the creatives behind the collections and explore their artistic worlds." ]
            ]
        ]


viewArtistCard : Int -> Artist -> Html Msg
viewArtistCard x artist =
    if x < 2 then
        Html.article
            [ HA.class "max-w-44 grid gap-0.5 hover:opacity-80 relative focus-within:opacity-80 p-1" ]
            [ Html.h3
                [ HA.class "font-title text-base overflow-hidden text-ellipsis text-nowrap underline underline-offset-2"
                ]
                [ Html.text artist.name ]
            , Html.img
                [ HA.src artist.profileImgUrl
                , HA.class "rounded"
                ]
                []
            , Html.a
                [ HA.href ("/artists/" ++ artist.id)
                , HA.class "h-full w-full absolute top-0 left-0"
                ]
                []
            ]

    else
        Html.text ""


viewExhibitions : Html Msg
viewExhibitions =
    Html.section
        [ HA.class "pt-24 bg-bgDark relative z-0" ]
        [ Html.div
            [ HA.class "max-w-maxWidth m-auto grid grid-col-12" ]
            [ Html.h2
                [ HA.class "font-title text-3xl mb-8 text-primary col-span-12" ]
                [ Html.text "Exploring Creativity Through Exhibitions" ]
            , Html.img
                [ HA.src "https://artmorph-images.s3.eu-north-1.amazonaws.com/about-exhibition.png"
                , HA.class "h-full col-span-5"
                ]
                []
            , Html.section
                [ HA.class "p-12 text-textLight col-span-7" ]
                [ Html.p
                    [ HA.class "  text-base mb-4 leading-7" ]
                    [ Html.text "Step into a world where art transforms, history whispers, nature comes alive, and the unseen takes shape. Each Artmorph exhibition is a curated collection that explores unique themes and artistic expressions. Immerse yourself in creativity and discover stories told through brushstrokes, textures, and imagination." ]
                , Html.ul
                    [ HA.class "list-disc mb-8 ml-8 leading-relaxed" ]
                    [ Html.h3
                        []
                        [ Html.text "Current Highlights:" ]
                    , Html.li
                        [ HA.class "ml-8" ]
                        [ Html.text "“Metamorphosis: The Art of Transformation”" ]
                    , Html.li
                        [ HA.class "ml-8" ]
                        [ Html.text "“Whispers Through Time: Art Echoing History”" ]
                    , Html.li
                        [ HA.class "ml-8" ]
                        [ Html.text "“Nature Reimagined: The Soul of the Wild”" ]
                    ]
                , Html.p
                    [ HA.class "  text-base mb-2" ]
                    [ Html.text "Immerse yourself in captivating themes and explore the artistic worlds within each exhibition." ]
                ]
            ]
        ]


viewSpotlight : Html Msg
viewSpotlight =
    Html.section
        [ HA.class "pt-16 pb-24 bg-bgDark relative z-0" ]
        [ Html.article
            [ HA.class "max-w-maxWidth m-auto" ]
            [ Html.h2
                [ HA.class "font-title text-3xl mb-4 text-primary col-span-full" ]
                [ Html.text "ArtMorph in the Spotlight" ]
            , Html.ul
                [ HA.class "grid grid-cols-4 grid-rows-5 gap-4" ]
                [ Html.li
                    [ HA.class "text-primary font-title grid row-start-1 col-start-1 row-span-2" ]
                    [ Html.p
                        [ HA.class "mb-4" ]
                        [ Html.text """A breathtaking fusion of creativity and storytelling. Each exhibition feels like stepping into another world.""" ]
                    , Html.p
                        [ HA.class "content-end" ]
                        [ Html.text ("– " ++ "Sofia L., Art Enthusiast") ]
                    ]
                , Html.li
                    [ HA.class "text-primary font-title grid row-start-2 col-start-2 row-span-2" ]
                    [ Html.p
                        [ HA.class "mb-4" ]
                        [ Html.text """“Artmorph is a beautifully curated space that brings digital art to life. A must-visit for anyone who loves contemporary art!”""" ]
                    , Html.p
                        [ HA.class "content-end" ]
                        [ Html.text ("– " ++ "Gallery Review Weekly") ]
                    ]
                , Html.li
                    [ HA.class "text-primary font-title grid row-start-3 col-start-3 row-span-2" ]
                    [ Html.p
                        [ HA.class "mb-4" ]
                        [ Html.text """ "A mesmerizing experience that showcases the power of visual storytelling. The themes are thought-provoking and immersive." """ ]
                    , Html.p
                        [ HA.class "content-end" ]
                        [ Html.text ("– " ++ "Mark R., Digital Artist") ]
                    ]
                , Html.li
                    [ HA.class "text-primary font-title grid row-start-4 col-start-4 row-span-2" ]
                    [ Html.p
                        [ HA.class "mb-4" ]
                        [ Html.text """ "A masterful blend of tradition and innovation. Every collection offers something unique and deeply moving." """ ]
                    , Html.p
                        [ HA.class "content-end" ]
                        [ Html.text ("– " ++ "Lena K., Art Collector") ]
                    ]
                ]
            ]
        ]


viewContact : Html Msg
viewContact =
    Html.article
        [ HA.class "max-w-maxWidth m-auto py-24 grid grid-cols-2 gap-x-8 border-b-2 border-bgDark" ]
        [ Html.section
            [ HA.class "px-11 grid gap-4" ]
            [ Html.h2
                [ HA.class "font-title text-3xl mb-4 text-textDark col-span-full" ]
                [ Html.text "Let’s Get in Touch" ]
            , Html.p
                [ HA.class "text-base text-textDark mb-4 leading-7" ]
                [ Html.text "Have questions, collaboration ideas, or just want to learn more about Artmorph? We'd love to hear from you! Reach out via email, phone, or visit us at our studio. Fill out the form, and we'll get back to you as soon as possible."
                ]
            , Html.ul
                [ HA.class "mb-8 text-sm" ]
                [ Html.h3
                    [ HA.class "font-title text-2xl text-center mb-4" ]
                    [ Html.text "Contact Details:" ]
                , Html.li
                    [ HA.class "flex gap-4 items-center uppercase" ]
                    [ Svg.svg
                        [ SA.fill "none"
                        , SA.viewBox "0 0 24 24"
                        , SA.strokeWidth "1.5"
                        , SA.stroke "currentColor"
                        , SA.class "size-6"
                        ]
                        [ Svg.path
                            [ SA.strokeLinecap "round"
                            , SA.strokeLinejoin "round"
                            , SA.d "M21.75 6.75v10.5a2.25 2.25 0 0 1-2.25 2.25h-15a2.25 2.25 0 0 1-2.25-2.25V6.75m19.5 0A2.25 2.25 0 0 0 19.5 4.5h-15a2.25 2.25 0 0 0-2.25 2.25m19.5 0v.243a2.25 2.25 0 0 1-1.07 1.916l-7.5 4.615a2.25 2.25 0 0 1-2.36 0L3.32 8.91a2.25 2.25 0 0 1-1.07-1.916V6.75"
                            ]
                            []
                        ]
                    , Html.p
                        []
                        [ Html.text "info@artmorph.com" ]
                    ]
                , Html.li
                    [ HA.class "flex gap-4 items-center justify-self-end" ]
                    [ Svg.svg
                        [ SA.fill "none"
                        , SA.viewBox "0 0 24 24"
                        , SA.strokeWidth "1.5"
                        , SA.stroke "currentColor"
                        , SA.class "size-6"
                        ]
                        [ Svg.path
                            [ SA.strokeLinecap "round"
                            , SA.strokeLinejoin "round"
                            , SA.d "M15 10.5a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z"
                            ]
                            []
                        , Svg.path
                            [ SA.strokeLinecap "round"
                            , SA.strokeLinejoin "round"
                            , SA.d "M19.5 10.5c0 7.142-7.5 11.25-7.5 11.25S4.5 17.642 4.5 10.5a7.5 7.5 0 1 1 15 0Z"
                            ]
                            []
                        ]
                    , Html.p
                        [ HA.class "flex flex-col uppercase" ]
                        [ Html.span
                            []
                            [ Html.text "45 Artisan Avenue" ]
                        , Html.span
                            []
                            [ Html.text "Aurora Heights" ]
                        , Html.span
                            []
                            [ Html.text "Artville" ]
                        ]
                    ]
                , Html.li
                    [ HA.class "flex gap-4 items-center" ]
                    [ Svg.svg
                        [ SA.fill "none"
                        , SA.viewBox "0 0 24 24"
                        , SA.strokeWidth "1.5"
                        , SA.stroke "currentColor"
                        , SA.class "size-6"
                        ]
                        [ Svg.path
                            [ SA.strokeLinecap "round"
                            , SA.strokeLinejoin "round"
                            , SA.d "M2.25 6.75c0 8.284 6.716 15 15 15h2.25a2.25 2.25 0 0 0 2.25-2.25v-1.372c0-.516-.351-.966-.852-1.091l-4.423-1.106c-.44-.11-.902.055-1.173.417l-.97 1.293c-.282.376-.769.542-1.21.38a12.035 12.035 0 0 1-7.143-7.143c-.162-.441.004-.928.38-1.21l1.293-.97c.363-.271.527-.734.417-1.173L6.963 3.102a1.125 1.125 0 0 0-1.091-.852H4.5A2.25 2.25 0 0 0 2.25 4.5v2.25Z"
                            ]
                            []
                        ]
                    , Html.p
                        []
                        [ Html.text "+123 456 7890" ]
                    ]
                ]
            , Html.p
                [ HA.class "  text-base text-textDark leading-7" ]
                [ Html.text "Art is all about connection. Whether you have a question, a collaboration idea, or just want to say hello—drop us a message. We look forward to hearing from you!" ]
            ]
        , Html.form
            [ HA.class "p-8 bg-primary rounded-2xl flex flex-col gap-4" ]
            [ Html.h3
                [ HA.class "font-title text-3xl text-center font-semibold" ]
                [ Html.text "Contact Form:" ]
            , Html.label []
                [ Html.text "Name:"
                , Html.input
                    [ HA.class "w-full rounded-lg pl-2 py-2" ]
                    []
                ]
            , Html.label []
                [ Html.text "Email:"
                , Html.input
                    [ HA.class "w-full rounded-lg pl-2 py-2" ]
                    []
                ]
            , Html.label
                []
                [ Html.text "Message:"
                , Html.textarea [ HA.class "w-full rounded-lg resize-none h-44 pl-2 pt-2" ] []
                ]
            , Html.button
                [ HA.class "text-nowrap text-sm py-2 px-4 bg-secondary rounded-2xl font-bold ml-auto w-fit text-textLight hover:opacity-80 focus-within:opacity-80" ]
                [ Html.text "Send Message" ]
            ]
        ]
