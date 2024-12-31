module Pages.AboutPage exposing (..)

import Html exposing (Html, a, article, button, div, figure, form, h2, h3, img, input, label, li, nav, p, section, span, text, textarea, ul)
import Html.Attributes exposing (class, href, src)


type alias Model =
    { title : String
    }


initModel : Model
initModel =
    { title = "About"
    }


view : model -> Html msg
view _ =
    div [ class "bg-bgLight" ]
        [ viewHero
        , viewAbout
        , viewArtists
        , viewExhibitions
        , viewSpotlight
        , viewContact
        , viewNewsletter
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
            [ h2 [ class "font-title text-3xl mb-4" ] [ text "The Vision Behind ArtMorph" ]
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
        [ h2 [ class "font-title text-3xl mb-4 text-center col-span-full" ] [ text "Meet the Creators Behind the Art" ]
        , ul [ class "flex overflow-hidden justify-between" ]
            [ viewArtistCard
            , viewArtistCard
            ]
        , section [ class "col-span-2" ]
            [ p [ class "font-bread text-base mb-2" ] [ text "ArtMorph collaborates with a diverse group of artists, each with a unique story to tell. From painters and sculptors to digital illustrators and multimedia creators, our gallery highlights talents who dare to push the boundaries of their craft." ]
            , p [ class "font-bread text-base mb-2" ] [ text "Explore their journeys, techniques, and inspirations as you dive into the world of creativity through their art. → Take a look at all our Creators" ]
            ]
        ]


viewArtistCard : Html msg
viewArtistCard =
    article [ class "max-w-44" ]
        [ h2 [ class "font-title text-base mb-2 overflow-hidden text-ellipsis text-nowrap underline underline-offset-2 cursor-pointer" ] [ text "Name of artist" ]
        , img [ src "https://images.unsplash.com/photo-1587116288118-56068e06763d?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" ] []
        ]


viewExhibitions : Html msg
viewExhibitions =
    section [ class "pt-32 bg-bgDark relative z-0" ]
        [ div [ class "max-w-maxWidth m-auto grid grid-cols-2" ]
            [ h2 [ class "font-title text-3xl mb-8 col-span-full text-primary" ] [ text "Exploring Creativity Through Exhibitions" ]
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
    section [ class "pt-32 bg-bgDark relative z-0" ]
        [ article [ class "max-w-maxWidth m-auto" ]
            [ h2 [ class "font-title text-3xl mb-8 col-span-full text-primary" ] [ text "ArtMorph in the Spotlight" ]
            , ul [ class "flex justify-between items-end" ]
                [ li [ class "text-primary font-title p-4" ]
                    [ p [ class "mb-4" ] [ text "'ArtMorph is a breath of fresh air in the art world. It’s a place where tradition meets innovation, and the results are stunning.'" ]
                    , p [ class "text-right" ] [ text "– Art Insider Magazine" ]
                    ]
                , li [ class "text-primary font-title p-4" ]
                    [ p [ class "mb-4" ] [ text "'Visiting ArtMorph felt like stepping into the future of art. Inspiring and thought-provoking.'" ]
                    , p [ class "text-right" ] [ text "– Gallery Visitor" ]
                    ]
                , li [ class "text-primary font-title p-4" ]
                    [ p [ class "mb-4" ] [ text "'This gallery doesn’t just showcase art—it tells a story of transformation and connection.'" ]
                    , p [ class "text-right" ] [ text "– Creative Review" ]
                    ]
                ]
            ]
        ]


viewContact : Html msg
viewContact =
    article [ class "max-w-maxWidth m-auto py-8 grid grid-cols-2 gap-x-8" ]
        [ section [ class "px-11" ]
            [ h2
                [ class "font-title text-3xl mb-8 text-textDark" ]
                [ text "Let’s Get in Touch" ]
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
            , label []
                [ text "Name:"
                , input [ class "w-full rounded-lg pl-2 py-2" ] []
                ]
            , label []
                [ text "Email:"
                , input [ class "w-full rounded-lg pl-2 py-2" ] []
                ]
            , label []
                [ text "Message:"
                , textarea [ class "w-full rounded-lg pl-2 resize-none h-44 pl-2 pt-2" ] []
                ]
            , button [ class "text-nowrap text-sm py-2 px-4 bg-secondary rounded-2xl font-bold ml-auto w-fit text-textLight" ] [ text "Send message" ]
            ]
        ]


viewNewsletter : Html msg
viewNewsletter =
    article [ class "max-w-maxWidth m-auto py-16 grid grid-cols-2 gap-4" ]
        [ h2 [ class "font-title text-3xl col-span-full" ]
            [ text "Your Journey Into Art Begins Here" ]
        , img
            [ src "https://images.unsplash.com/photo-1460661419201-fd4cecdf8a8b?q=80&w=1760&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", class "max-w-full aspect-video" ]
            []
        , section [ class "py-4" ]
            [ h3 [ class "font-bread font-medium text-xl leading-relaxed mb-4" ] [ text "Whether you’re a collector, an admirer, or an artist, ArtMorph is a space for discovery and connection. Let’s shape the future of art together." ]
            , p [ class "font-bread text-base font-regular leading-normal mb-4" ] [ text "Stay updated with the latest exhibitions, featured artists, and exclusive content delivered straight to your inbox." ]
            , form [ class " w-full flex gap-4 pb-4" ]
                [ input [ class "w-full rounded-lg pl-2 py-2" ] []
                , button [ class "text-nowrap text-sm py-2 px-4 bg-primary rounded-2xl font-bold" ] [ text "Subscribe Now" ]
                ]
            , nav [ class "flex justify-around" ]
                [ a [ href "/exhibition", class "font-title text-base mb-2 overflow-hidden text-ellipsis text-nowrap underline underline-offset-2 cursor-pointer" ] [ text "Start Exploring" ]
                , a [ href "/contact", class "font-title text-base mb-2 overflow-hidden text-ellipsis text-nowrap underline underline-offset-2 cursor-pointer" ] [ text "Start Exploring" ]
                ]
            ]
        ]
