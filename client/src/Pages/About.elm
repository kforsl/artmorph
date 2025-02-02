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


viewHero : Html msg
viewHero =
    Html.section
        [ HA.class "bg-bgDark relative z-0" ]
        [ Html.div
            [ HA.class "max-w-maxWidth m-auto grid gap-20 grid-cols-7 pt-24" ]
            [ Html.figure
                [ HA.class "col-span-3" ]
                [ Html.img
                    [ HA.src "https://images.unsplash.com/photo-1682680215210-d385fa4ea8a5?q=80&w=1935&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" ]
                    []
                ]
            , Html.section
                [ HA.class "col-span-4 relative" ]
                [ Html.h2
                    [ HA.class "text-5xl font-title text-primary flex flex-col gap-6 " ]
                    [ Html.span
                        [ HA.class "font-logo" ]
                        [ Html.text "About Artmorph" ]
                    , Html.span
                        [ HA.class "text-right" ]
                        [ Html.text "Transforming Art," ]
                    , Html.span
                        [ HA.class "text-center" ]
                        [ Html.text "From Canvas to Code" ]
                    ]
                , Html.h3
                    [ HA.class "absolute top-1/2 -z-[1] left-0 text-5xl font-title text-secondary flex flex-col gap-6 text-nowrap " ]
                    [ Html.span
                        []
                        [ Html.text "Blending tradition with " ]
                    , Html.span
                        [ HA.class "text-right pl-16" ]
                        [ Html.text "innovation to showcase" ]
                    , Html.span
                        [ HA.class "text-center" ]
                        [ Html.text "art in all its forms." ]
                    ]
                ]
            ]
        ]


viewAbout : Html msg
viewAbout =
    Html.article
        [ HA.class "max-w-maxWidth m-auto py-8 grid grid-cols-2 border-b-2 border-black" ]
        [ Html.section
            [ HA.class "p-4" ]
            [ Html.h2
                [ HA.class "font-title text-3xl mb-4 text-textDark col-span-full" ]
                [ Html.text "The Vision Behind ArtMorph" ]
            , Html.p
                [ HA.class "font-bread text-base mb-2" ]
                [ Html.text "ArtMorph was born from a passion for bridging the timeless beauty of traditional art with the endless possibilities of digital expression. Founded in [Year], our gallery was envisioned as a space where artists and art lovers could explore the evolution of creativity. From classical brushstrokes to digital masterpieces, we celebrate the transformation of art and its ability to inspire, challenge, and connect." ]
            , Html.p
                [ HA.class "font-bread text-base mb-2" ]
                [ Html.text """Our mission is simple—to honor tradition while embracing innovation. By showcasing art that spans mediums and styles, we aim to spark curiosity, conversation, and appreciation for the ever-changing world of artistic expression. Whether you’re an artist, collector, or admirer, ArtMorph is your gateway to a world where creativity knows no boundaries.""" ]
            ]
        , Html.figure []
            [ Html.img
                [ HA.src "https://images.unsplash.com/photo-1682680215210-d385fa4ea8a5?q=80&w=1935&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
                , HA.class "h-full aspect-video"
                ]
                []
            ]
        ]


viewArtists : Api.Artist.Model -> Html msg
viewArtists artists =
    Html.article
        [ HA.class "max-w-maxWidth m-auto py-8 grid grid-cols-3 gap-x-8" ]
        [ Html.h2
            [ HA.class "font-title text-3xl mb-4 text-textDark col-span-full" ]
            [ Html.text "Meet the Creators Behind the Art" ]
        , Html.ul
            [ HA.class "flex overflow-hidden justify-between" ]
            (List.indexedMap viewArtistCard artists)
        , Html.section
            [ HA.class "col-span-2" ]
            [ Html.p
                [ HA.class "font-bread text-base mb-2" ]
                [ Html.text "ArtMorph collaborates with a diverse group of artists, each with a unique story to tell. From painters and sculptors to digital illustrators and multimedia creators, our gallery highlights talents who dare to push the boundaries of their craft." ]
            , Html.p
                [ HA.class "font-bread text-base mb-2" ]
                [ Html.text "Explore their journeys, techniques, and inspirations as you dive into the world of creativity through their art. → Take a look at all our Creators" ]
            ]
        ]


viewArtistCard : Int -> Artist -> Html msg
viewArtistCard x artist =
    if x < 2 then
        Html.article
            [ HA.class "max-w-44 grid gap-0.5" ]
            [ Html.a
                [ HA.href ("/artist/" ++ artist.id)
                , HA.class "font-title text-base overflow-hidden text-ellipsis text-nowrap underline underline-offset-2 cursor-pointer"
                ]
                [ Html.text artist.name ]
            , Html.img
                [ HA.src "https://images.unsplash.com/photo-1587116288118-56068e06763d?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" ]
                []
            ]

    else
        Html.text ""


viewExhibitions : Html msg
viewExhibitions =
    Html.section
        [ HA.class "pt-32 bg-bgDark relative z-0" ]
        [ Html.div
            [ HA.class "max-w-maxWidth m-auto grid grid-cols-2" ]
            [ Html.h2
                [ HA.class "font-title text-3xl mb-4 text-primary col-span-full" ]
                [ Html.text "Exploring Creativity Through Exhibitions" ]
            , Html.figure
                []
                [ Html.img
                    [ HA.src "https://images.unsplash.com/photo-1682680215210-d385fa4ea8a5?q=80&w=1935&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
                    , HA.class "h-full aspect-video"
                    ]
                    []
                ]
            , Html.section
                [ HA.class "p-4 text-textLight" ]
                [ Html.p
                    [ HA.class "font-bread text-base mb-4" ]
                    [ Html.text "Our exhibitions are designed to take you on a journey through transformation—both artistic and emotional. We curate collections that explore themes of evolution, identity, and innovation, blending traditional art forms with contemporary techniques." ]
                , Html.ul
                    [ HA.class "list-disc mb-4 ml-8 leading-relaxed" ]
                    [ Html.h3
                        []
                        [ Html.text "Current Highlights:" ]
                    , Html.li
                        [ HA.class "ml-8" ]
                        [ Html.text "'Pixels & Paint' – A showcase of works that fuse digital design with classical artistry." ]
                    , Html.li
                        [ HA.class "ml-8" ]
                        [ Html.text "'Metamorphosis' – An exploration of change and growth through mixed-media installations." ]
                    , Html.li
                        [ HA.class "ml-8" ]
                        [ Html.text "'Echoes of Tradition' – Celebrating timeless techniques reimagined for the modern age." ]
                    ]
                , Html.p
                    [ HA.class "font-bread text-base mb-2" ]
                    [ Html.text "Whether you’re here to admire, learn, or collect, our exhibitions promise an unforgettable experience." ]
                ]
            ]
        ]


viewSpotlight : Html msg
viewSpotlight =
    Html.section
        [ HA.class "py-32 bg-bgDark relative z-0" ]
        [ Html.article
            [ HA.class "max-w-maxWidth m-auto" ]
            [ Html.h2
                [ HA.class "font-title text-3xl mb-4 text-primary col-span-full" ]
                [ Html.text "ArtMorph in the Spotlight" ]
            , Html.ul
                [ HA.class "grid grid-cols-3" ]
                [ viewSpotlightQuote """ "ArtMorph is a breath of fresh air in the art world. It’s a place where tradition meets innovation, and the results are stunning." """ "Art Insider Magazine"
                , viewSpotlightQuote """ "This gallery doesn’t just showcase art—it tells a story of transformation and connection." """ "Creative Review"
                , viewSpotlightQuote """ "Visiting ArtMorph felt like stepping into the future of art. Inspiring and thought-provoking." """ "Gallery Visitor"
                ]
            ]
        ]


viewSpotlightQuote : String -> String -> Html msg
viewSpotlightQuote quote author =
    Html.li
        [ HA.class "text-primary font-title p-4 grid" ]
        [ Html.p
            [ HA.class "mb-4" ]
            [ Html.text quote ]
        , Html.p
            [ HA.class "text-right content-end" ]
            [ Html.text ("– " ++ author) ]
        ]


viewContact : Html msg
viewContact =
    Html.article
        [ HA.class "max-w-maxWidth m-auto py-8 grid grid-cols-2 gap-x-8" ]
        [ Html.section
            [ HA.class "px-11 grid gap-4" ]
            [ Html.h2
                [ HA.class "font-title text-3xl mb-4 text-textDark col-span-full" ]
                [ Html.text "Let’s Get in Touch" ]
            , Html.p
                [ HA.class "font-bread text-base text-textDark mb-8" ]
                [ Html.text "We’d love to hear from you! Whether you’re an artist looking to collaborate, a collector with inquiries, or someone who simply loves art, don’t hesitate to reach out."
                ]
            , Html.ul
                [ HA.class "mb-8" ]
                [ Html.h3
                    [ HA.class "font-title text-2xl text-center mb-4" ]
                    [ Html.text "Contact Details:" ]
                , Html.li
                    [ HA.class "flex gap-4 items-center" ]
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
                        [ HA.class "flex flex-col" ]
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
                [ HA.class "font-bread text-base text-textDark mb-8" ]
                [ Html.text "We’re here to answer your questions and keep the conversation about art alive!" ]
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
