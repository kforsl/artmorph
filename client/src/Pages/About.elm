module Pages.About exposing (..)

import Api.Artist exposing (Artist)
import Components.Newsletter
import Html exposing (Html)
import Html.Attributes as HA


type alias Model =
    { artistData : List Artist
    }


initModel : Model
initModel =
    { artistData = []
    }


type Msg
    = MsgDummy


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MsgDummy ->
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
                    [ HA.class "text-5xl font-title text-primary flex flex-col justify-end gap-6 h-1/2 " ]
                    [ Html.span
                        [ HA.class "font-logo text-7xl text-right" ]
                        [ Html.text "About Artmorph" ]
                    , Html.span
                        [ HA.class "text-center" ]
                        [ Html.text "Where every stroke" ]
                    , Html.span
                        [ HA.class "" ]
                        [ Html.text "Tells a new story" ]
                    ]

                -- , Html.h3
                --     [ HA.class "absolute top-1/2 -z-[1] right-0 text-5xl font-title text-secondary flex flex-col gap-6 text-nowrap " ]
                --     [ Html.span
                --         [ HA.class "text-right"]
                --         [ Html.text "Blending tradition with " ]
                --     , Html.span
                --         [ HA.class "text-right pl-16" ]
                --         [ Html.text "innovation to showcase" ]
                --     , Html.span
                --         [ HA.class "text-center" ]
                --         [ Html.text "art in all its forms." ]
                --     ]
                ]
            ]
        ]


viewAbout : Html Msg
viewAbout =
    Html.article
        [ HA.class "max-w-maxWidth m-auto py-16 grid grid-cols-12 border-b-2 border-black" ]
        [ Html.section
            [ HA.class "p-4 col-span-7" ]
            [ Html.h2
                [ HA.class "font-title text-3xl mb-4 text-textDark col-span-full " ]
                [ Html.text "The Vision Behind ArtMorph" ]
            , Html.p
                [ HA.class "font-bread text-base mb-2 leading-7" ]
                [ Html.text "Art is constantly evolving. It transforms, reinvents itself, and tells new stories with each passing era. At Artmorph, we believe in capturing these moments of change—curating digital exhibitions that explore art’s endless possibilities." ]
            , Html.p
                [ HA.class "font-bread text-base mb-2 leading-7" ]
                [ Html.text """Our platform is more than a gallery; it’s a living, breathing space where artists and audiences connect across time, culture, and imagination. Through carefully curated themes, Artmorph showcases how creativity transcends boundaries, offering a unique journey through the worlds of transformation, history, nature, the supernatural, and beyond.""" ]
            , Html.p
                [ HA.class "font-bread text-base mb-2 leading-7" ]
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
        [ HA.class "max-w-maxWidth m-auto py-8 grid grid-cols-3 gap-x-8" ]
        [ Html.h2
            [ HA.class "font-title text-3xl mb-4 text-textDark col-span-full" ]
            [ Html.text "Meet the Visionaries Behind Artmorph" ]
        , Html.ul
            [ HA.class "flex overflow-hidden justify-between" ]
            (List.indexedMap viewArtistCard artists)
        , Html.section
            [ HA.class "col-span-2 flex flex-col justify-center" ]
            [ Html.p
                [ HA.class "font-bread text-base mb-4 leading-7" ]
                [ Html.text "Artmorph is shaped by the vision of talented artists who explore transformation, history, nature, and the unknown through their work. Each artist brings their own unique approach, style, and storytelling to the exhibitions. Discover the creatives behind the collections and explore their artistic worlds." ]
            , Html.a
                [ HA.class "font-bread text-base mb-2 text-primary underline underline-offset-2"
                , HA.href "/artists"
                ]
                [ Html.text " Discover the creatives behind the collections and explore their artistic worlds." ]
            ]
        ]


viewArtistCard : Int -> Artist -> Html Msg
viewArtistCard x artist =
    if x < 2 then
        Html.article
            [ HA.class "max-w-44 grid gap-0.5" ]
            [ Html.a
                [ HA.href ("/artists/" ++ artist.id)
                , HA.class "font-title text-base overflow-hidden text-ellipsis text-nowrap underline underline-offset-2 cursor-pointer"
                ]
                [ Html.text artist.name ]
            , Html.img
                [ HA.src artist.profileImgUrl ]
                []
            ]

    else
        Html.text ""


viewExhibitions : Html Msg
viewExhibitions =
    Html.section
        [ HA.class "pt-16 bg-bgDark relative z-0" ]
        [ Html.div
            [ HA.class "max-w-maxWidth m-auto grid grid-col-12" ]
            [ Html.h2
                [ HA.class "font-title text-3xl mb-4 text-primary col-span-12" ]
                [ Html.text "Exploring Creativity Through Exhibitions" ]
            , Html.img
                    [ HA.src "https://artmorph-images.s3.eu-north-1.amazonaws.com/about-exhibition.png"
                    , HA.class "h-full col-span-5"
                    ]
                    []
            , Html.section
                [ HA.class "p-12 text-textLight col-span-7" ]
                [ Html.p
                    [ HA.class "font-bread text-base mb-4 leading-7" ]
                    [ Html.text "Step into a world where art transforms, history whispers, nature comes alive, and the unseen takes shape. Each Artmorph exhibition is a curated collection that explores unique themes and artistic expressions. Immerse yourself in creativity and discover stories told through brushstrokes, textures, and imagination." ]
                , Html.ul
                    [ HA.class "list-disc mb-4 ml-8 leading-relaxed" ]
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
                    [ HA.class "font-bread text-base mb-2" ]
                    [ Html.text "Immerse yourself in captivating themes and explore the artistic worlds within each exhibition." ]
                ]
            ]
        ]


viewSpotlight : Html Msg
viewSpotlight =
    Html.section
        [ HA.class "pt-8 pb-16 bg-bgDark relative z-0" ]
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
        [ HA.class "max-w-maxWidth m-auto py-16 grid grid-cols-2 gap-x-8" ]
        [ Html.section
            [ HA.class "px-11 grid gap-4" ]
            [ Html.h2
                [ HA.class "font-title text-3xl mb-4 text-textDark col-span-full" ]
                [ Html.text "Let’s Get in Touch" ]
            , Html.p
                [ HA.class "font-bread text-base text-textDark mb-4 leading-7" ]
                [ Html.text "Have questions, collaboration ideas, or just want to learn more about Artmorph? We'd love to hear from you! Reach out via email, phone, or visit us at our studio. Fill out the form, and we'll get back to you as soon as possible."
                ]
            , Html.ul
                [ HA.class "mb-8" ]
                [ Html.h3
                    [ HA.class "font-title text-2xl text-center mb-4" ]
                    [ Html.text "Contact Details:" ]
                , Html.li
                    [ HA.class "flex gap-4 items-center uppercase" ]
                    [ Html.img
                        [ HA.src "https://cdn-icons-png.flaticon.com/256/646/646094.png"
                        , HA.class "w-8"
                        ]
                        []
                    , Html.p
                        []
                        [ Html.text "info@artmorph.com" ]
                    ]
                , Html.li
                    [ HA.class "flex gap-4 items-center justify-self-end" ]
                    [ Html.img
                        [ HA.src "https://cdn-icons-png.flaticon.com/512/902/902613.png"
                        , HA.class "w-8"
                        ]
                        []
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
                    [ Html.img
                        [ HA.src "https://www.iconpacks.net/icons/1/free-phone-icon-1-thumb.png"
                        , HA.class "w-8"
                        ]
                        []
                    , Html.p
                        []
                        [ Html.text "+123 456 7890" ]
                    ]
                ]
            , Html.p
                [ HA.class "font-bread text-base text-textDark leading-7" ]
                [ Html.text "Art is all about connection. Whether you have a question, a collaboration idea, or just want to say hello—drop us a message. We look forward to hearing from you!" ]
            ]
        , Html.form
            [ HA.class "p-8 bg-primary rounded-2xl flex flex-col gap-4" ]
            [ Html.h3
                [ HA.class "font-title text-3xl text-center" ]
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
                [ HA.class "text-nowrap text-sm py-2 px-4 bg-secondary rounded-2xl font-bold ml-auto w-fit text-textLight" ]
                [ Html.text "Send Message" ]
            ]
        ]
