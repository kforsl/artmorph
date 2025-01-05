module Pages.AboutPage exposing (..)

import Components.UI
import Html exposing (Html, article, div, figure, form, h2, h3, img, label, li, p, section, span, text, textarea, ul)
import Html.Attributes exposing (class, src)


type alias Model =
    { title : String
    }


type Msg
    = MsgSignUpToNewsletter


initModel : Model
initModel =
    { title = "About"
    }


view : Model -> Html Msg
view _ =
    div [ class "bg-bgLight" ]
        [ viewHero
        , viewAbout
        , viewArtists
        , viewExhibitions
        , viewSpotlight
        , viewContact
        , Components.UI.viewNewsletter MsgSignUpToNewsletter
        ]


viewHero : Html msg
viewHero =
    section [ class "pt-32 bg-bgDark relative z-0" ]
        [ div [ class "max-w-maxWidth m-auto grid gap-20 grid-cols-7 pt-24" ]
            [ figure [ class "col-span-3" ]
                [ img [ src "https://images.unsplash.com/photo-1682680215210-d385fa4ea8a5?q=80&w=1935&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" ] []
                ]
            , section
                [ class "col-span-4 relative" ]
                [ h2 [ class "text-5xl font-title text-primary flex flex-col gap-6 " ] [ span [ class "font-logo" ] [ text "About Artmorph" ], span [ class "text-right" ] [ text "Transforming Art," ], span [ class "text-center" ] [ text "From Canvas to Code" ] ]
                , h3 [ class "absolute top-1/2 -z-[1] left-0 text-5xl font-title text-secondary flex flex-col gap-6 text-nowrap " ]
                    [ span [] [ text "Blending tradition with " ]
                    , span [ class "text-right pl-16" ] [ text "innovation to showcase" ]
                    , span [ class "text-center" ] [ text "art in all its forms." ]
                    ]
                ]
            ]
        ]


viewAbout : Html msg
viewAbout =
    article [ class "max-w-maxWidth m-auto py-8 grid grid-cols-2 border-b-2 border-black" ]
        [ section [ class "p-4" ]
            [ Components.UI.titleDark "The Vision Behind ArtMorph"
            , p [ class "font-bread text-base mb-2" ] [ text "ArtMorph was born from a passion for bridging the timeless beauty of traditional art with the endless possibilities of digital expression. Founded in [Year], our gallery was envisioned as a space where artists and art lovers could explore the evolution of creativity. From classical brushstrokes to digital masterpieces, we celebrate the transformation of art and its ability to inspire, challenge, and connect." ]
            , p [ class "font-bread text-base mb-2" ] [ text "Our mission is simple—to honor tradition while embracing innovation. By showcasing art that spans mediums and styles, we aim to spark curiosity, conversation, and appreciation for the ever-changing world of artistic expression. Whether you’re an artist, collector, or admirer, ArtMorph is your gateway to a world where creativity knows no boundaries." ]
            ]
        , figure []
            [ img [ src "https://images.unsplash.com/photo-1682680215210-d385fa4ea8a5?q=80&w=1935&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", class "h-full aspect-video" ] []
            ]
        ]


viewArtists : Html msg
viewArtists =
    article [ class "max-w-maxWidth m-auto py-8 grid grid-cols-3 gap-x-8" ]
        [ Components.UI.titleDark "Meet the Creators Behind the Art"
        , ul [ class "flex overflow-hidden justify-between" ]
            [ Components.UI.viewArtistCard
            , Components.UI.viewArtistCard
            ]
        , section [ class "col-span-2" ]
            [ p [ class "font-bread text-base mb-2" ] [ text "ArtMorph collaborates with a diverse group of artists, each with a unique story to tell. From painters and sculptors to digital illustrators and multimedia creators, our gallery highlights talents who dare to push the boundaries of their craft." ]
            , p [ class "font-bread text-base mb-2" ] [ text "Explore their journeys, techniques, and inspirations as you dive into the world of creativity through their art. → Take a look at all our Creators" ]
            ]
        ]


viewExhibitions : Html msg
viewExhibitions =
    section [ class "pt-32 bg-bgDark relative z-0" ]
        [ div [ class "max-w-maxWidth m-auto grid grid-cols-2" ]
            [ Components.UI.titlePrimary "Exploring Creativity Through Exhibitions"
            , figure []
                [ img [ src "https://images.unsplash.com/photo-1682680215210-d385fa4ea8a5?q=80&w=1935&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", class "h-full aspect-video" ] []
                ]
            , section [ class "p-4 text-textLight" ]
                [ p [ class "font-bread text-base mb-4" ] [ text "Our exhibitions are designed to take you on a journey through transformation—both artistic and emotional. We curate collections that explore themes of evolution, identity, and innovation, blending traditional art forms with contemporary techniques." ]
                , ul [ class "list-disc mb-4 ml-8 leading-relaxed" ]
                    [ h3 [] [ text "Current Highlights:" ]
                    , li [ class "ml-8" ] [ text "'Pixels & Paint' – A showcase of works that fuse digital design with classical artistry." ]
                    , li [ class "ml-8" ] [ text "'Metamorphosis' – An exploration of change and growth through mixed-media installations." ]
                    , li [ class "ml-8" ] [ text "'Echoes of Tradition' – Celebrating timeless techniques reimagined for the modern age." ]
                    ]
                , p [ class "font-bread text-base mb-2" ] [ text "Whether you’re here to admire, learn, or collect, our exhibitions promise an unforgettable experience." ]
                ]
            ]
        ]


viewSpotlight : Html msg
viewSpotlight =
    section [ class "py-32 bg-bgDark relative z-0" ]
        [ article [ class "max-w-maxWidth m-auto" ]
            [ Components.UI.titlePrimary "ArtMorph in the Spotlight"
            , ul [ class "grid grid-cols-3" ]
                [ viewSpotlightQuote """ "ArtMorph is a breath of fresh air in the art world. It’s a place where tradition meets innovation, and the results are stunning." """ "Art Insider Magazine"
                , viewSpotlightQuote """ "This gallery doesn’t just showcase art—it tells a story of transformation and connection." """ "Creative Review"
                , viewSpotlightQuote """ "Visiting ArtMorph felt like stepping into the future of art. Inspiring and thought-provoking." """ "Gallery Visitor"
                ]
            ]
        ]


viewSpotlightQuote : String -> String -> Html msg
viewSpotlightQuote quote author =
    li [ class "text-primary font-title p-4 grid" ]
        [ p [ class "mb-4" ] [ text quote ]
        , p [ class "text-right content-end" ] [ text ("– " ++ author) ]
        ]


viewContact : Html msg
viewContact =
    article [ class "max-w-maxWidth m-auto py-8 grid grid-cols-2 gap-x-8" ]
        [ section [ class "px-11 grid gap-4" ]
            [ Components.UI.titleDark "Let’s Get in Touch"
            , p [ class "font-bread text-base text-textDark mb-8" ]
                [ text "We’d love to hear from you! Whether you’re an artist looking to collaborate, a collector with inquiries, or someone who simply loves art, don’t hesitate to reach out."
                ]
            , ul [ class "mb-8" ]
                [ h3
                    [ class "font-title text-2xl text-center mb-4" ]
                    [ text "Contact Details:" ]
                , li [ class "flex gap-4 items-center" ]
                    [ img [ src "https://cdn-icons-png.flaticon.com/256/646/646094.png", class "w-8" ] []
                    , p []
                        [ text "info@artmorph.com" ]
                    ]
                , li [ class "flex gap-4 items-center justify-self-end" ]
                    [ img [ src "https://cdn-icons-png.flaticon.com/512/902/902613.png", class "w-8" ] []
                    , p [ class "flex flex-col" ]
                        [ span [] [ text "45 Artisan Avenue" ]
                        , span [] [ text "Aurora Heights" ]
                        , span [] [ text "Artville" ]
                        ]
                    ]
                , li [ class "flex gap-4 items-center" ]
                    [ img [ src "https://www.iconpacks.net/icons/1/free-phone-icon-1-thumb.png", class "w-8" ] []
                    , p []
                        [ text "+123 456 7890" ]
                    ]
                ]
            , p [ class "font-bread text-base text-textDark mb-8" ] [ text "We’re here to answer your questions and keep the conversation about art alive!" ]
            ]
        , form [ class "p-8 bg-primary rounded-2xl flex flex-col gap-4" ]
            [ h3 [ class "font-title text-3xl text-center" ] [ text "Contact Form:" ]
            , Components.UI.formInput "Name:"
            , Components.UI.formInput "Email:"
            , label []
                [ text "Message:"
                , textarea [ class "w-full rounded-lg resize-none h-44 pl-2 pt-2" ] []
                ]
            , Components.UI.buttonSecondary "Send Message"
            ]
        ]


update msg model =
    case msg of
        MsgSignUpToNewsletter ->
            ( model, Cmd.none )
