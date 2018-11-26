port module Main exposing (main)

import Browser
import Css exposing (..)
import Css.Global exposing (body, global, html)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes as Attr exposing (css, href, id, src)
import Html.Styled.Events exposing (onClick, onInput, onSubmit)


styles =
    { html =
        [ height (pct 100)
        ]
    , body =
        [ height (pct 100)
        , margin zero
        , fontFamilies [ "Biko", "sans-serif" ]
        , backgroundColor colors.navy
        , color colors.yellow
        ]
    , view = []
    , header =
        { top =
            [ fontSize (rem 1.5)
            , padding (rem 1.5)
            ]
        , links =
            [ displayFlex
            , maxWidth (px 960)
            , margin2 zero auto
            , width (pct 100)
            , justifyContent center
            , listStyle none
            , padding zero
            ]
        , link =
            [ marginLeft (rem 1.5)
            , firstChild [ marginLeft zero ]
            ]
        }
    , hidden =
        [ height zero
        , width zero
        , margin zero
        , overflow hidden
        ]
    , link =
        [ backgroundColor transparent
        , color inherit
        , fontFamily inherit
        , fontSize inherit
        , padding zero
        , border zero
        , cursor pointer
        , opacity (num 0.75)
        , hover [ opacity (num 1) ]
        ]
    , hero =
        { top =
            [ padding2 (rem 4) zero
            , displayFlex
            , alignItems center
            , flexDirection column
            ]
        , container =
            [ backgroundColor colors.yellow
            , color colors.navy
            , padding (rem 1.5)
            , maxWidth (pct 100)
            , width (px 540)
            , fontSize (px 20)
            , lineHeight (num 1.4)
            , marginTop (rem 1.5)
            ]
        }
    , buttons =
        { row =
            [ displayFlex
            , justifyContent center
            , marginTop (rem 1.5)
            ]
        }
    , button =
        [ backgroundColor colors.navy
        , color colors.yellow
        , padding2 (px 12) (px 24)
        , fontFamily inherit
        , fontSize inherit
        , textTransform uppercase
        , border zero
        , marginLeft (rem 1.5)
        , firstChild [ marginLeft zero ]
        , cursor pointer
        , whiteSpace noWrap
        , textDecoration none
        ]
    , contactForm =
        [ displayFlex
        , alignItems center
        ]
    , input =
        [ backgroundColor (rgba 0 0 0 0)
        , fontSize inherit
        , fontFamily inherit
        , border3 (px 1) solid colors.navy
        , padding2 (rem 0.6) (rem 1)
        ]
    , pageSection =
        { top =
            [ padding2 (rem 4) zero
            , color colors.green
            ]
        , container =
            [ margin2 zero auto
            , maxWidth (px 960)
            , width (pct 100)
            , padding2 zero (rem 1.5)
            ]
        , title =
            [ fontSize (rem 3)
            ]
        , contentWrapper =
            [ position relative
            , before
                [ property "content" "''"
                , position absolute
                , top zero
                , left zero
                , right (pct 50)
                , bottom zero
                , backgroundColor colors.green
                , zIndex (int -1)
                ]
            ]
        , content =
            [ maxWidth (pct 100)
            , width (px 540)
            , marginTop (rem 2)
            , fontSize (px 20)
            , lineHeight (num 1.4)
            , padding (rem 1.5)
            , paddingLeft zero
            , backgroundColor colors.green
            , color colors.navy
            ]
        }
    , logo =
        { h1 =
            [ fontSize (rem 6)
            , lineHeight (num 0.9)
            , whiteSpace noWrap
            , margin zero
            ]
        , bigText =
            [ fontSize (Css.em 1)
            ]
        , smallText =
            [ fontSize (Css.em (5 / 8))
            ]
        }
    , footer =
        { top =
            [ padding (rem 1.5)
            , color colors.yellow
            ]
        , container =
            [ width (pct 100)
            , maxWidth (px 960)
            , margin2 zero auto
            , displayFlex
            , justifyContent spaceBetween
            ]
        , left = []
        , right = [ color colors.yellow ]
        }
    }


globalStyles : Html Msg
globalStyles =
    global
        [ html styles.html
        , body styles.body
        , Css.Global.selector "body *" [ boxSizing borderBox ]
        ]


colors =
    { navy = hex "#21377b"
    , yellow = hex "#fff98e"
    , teal = hex "#8bc7cb"
    , green = hex "#d6fd8c"
    }



-- MAIN


type alias Model =
    { name : String
    , email : String
    }


main : Program () Model Msg
main =
    Browser.element
        { init = always ( Model "" "", Cmd.none )
        , update = update
        , view = view >> toUnstyled
        , subscriptions = always Sub.none
        }



-- UPDATE


type Field
    = Name
    | Email


type Msg
    = JumpTo String
    | UpdateField Field String
    | SubmitForm


port outgoing : ( String, String ) -> Cmd msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        JumpTo id ->
            ( model
            , outgoing ( "JUMP_TO", id )
            )

        UpdateField Name name ->
            ( { model | name = name }
            , Cmd.none
            )

        UpdateField Email email ->
            ( { model | email = email }
            , Cmd.none
            )

        SubmitForm ->
            ( Model "" ""
            , outgoing ( "SUBMIT_FORM", model.email )
            )



-- VIEW


view : Model -> Html Msg
view _ =
    div [ css styles.view ]
        [ globalStyles
        , navbar
        , hero
        , div [ id "tickets" ]
            [ pageSection "Tickets" ticketContent ]
        , div [ id "speakers" ]
            [ pageSection "Speakers" speakerContent ]
        , div [ id "sponsors" ]
            [ pageSection "Sponsors" sponsorContent ]
        , siteFooter
        ]


navbar : Html Msg
navbar =
    header [ css styles.header.top ]
        [ ul [ css styles.header.links ]
            (List.map
                headerJumpLink
                [ ( "Tickets", "tickets" )
                , ( "Speakers", "speakers" )
                , ( "Sponsors", "sponsors" )
                ]
            )
        ]


headerJumpLink : ( String, String ) -> Html Msg
headerJumpLink ( label_, id_ ) =
    li [ css styles.header.link ]
        [ button
            [ css styles.link
            , onClick (JumpTo id_)
            ]
            [ text label_ ]
        ]


hero : Html Msg
hero =
    div [ css styles.hero.top ]
        [ h1 [ css styles.logo.h1 ] [ logo ]
        , div [ css styles.hero.container ]
            [ p []
                [ text "Let's all get together in Chicago and spend the day talking/teaching/learning all about Elm!"
                ]
            , div [ css styles.buttons.row ]
                [ button [ css styles.button, onClick (JumpTo "tickets") ] [ text "Attend" ]
                , button [ css styles.button, onClick (JumpTo "speakers") ] [ text "Speak" ]
                ]
            ]
        ]


pageSection : String -> Html Msg -> Html Msg
pageSection title content =
    section [ css styles.pageSection.top ]
        [ div [ css styles.pageSection.container ]
            [ h3 [ css styles.pageSection.title ] [ text title ]
            ]
        , div [ css styles.pageSection.contentWrapper ]
            [ div [ css styles.pageSection.container ]
                [ div [ css styles.pageSection.content ]
                    [ content
                    ]
                ]
            ]
        ]


ticketContent : Html Msg
ticketContent =
    div []
        [ h4 [] [ text "Ticket sales will begin soon!" ]
        , p [] [ text "For conference updates, join our mailing list." ]
        , p [] [ text "No spam. Ever." ]
        , form
            [ Attr.name "mailing-list"
            , Attr.method "POST"
            , Attr.attribute "data-netlify-honeypot" "name"
            , Attr.attribute "data-netlify" "true"
            , css styles.contactForm
            , onSubmit SubmitForm
            ]
            [ p [ css styles.hidden ]
                [ input
                    [ Attr.type_ "text"
                    , Attr.name "name"
                    , Attr.attribute "aria-label"
                        "Do not fill out this field, it's for spam bots."
                    , onInput (UpdateField Name)
                    ]
                    []
                ]
            , p []
                [ input
                    [ Attr.type_ "email"
                    , Attr.name "email"
                    , Attr.placeholder "Email address"
                    , Attr.attribute "aria-label" "Email address"
                    , css styles.input
                    , onInput (UpdateField Email)
                    ]
                    []
                ]
            , p []
                [ button
                    [ Attr.type_ "submit"
                    , css (styles.button ++ [ fontSize (rem 1) ])
                    ]
                    [ text "Keep me posted!" ]
                ]
            ]
        ]


speakerContent : Html Msg
speakerContent =
    div []
        [ p [] [ text "If you're interested in becoming a speaker, great!" ]
        , p [] [ text "You can submit a Call for Proposal below:" ]
        , p []
            [ a
                [ href "#cfp-link-goes-here"
                , Attr.target "_blank"
                , css styles.button
                ]
                [ text "Submit a CFP" ]
            ]
        ]


sponsorContent : Html Msg
sponsorContent =
    div []
        [ h4 [] [ text "Interested in supporting the community?" ]
        , p []
            [ text "You or your company can become a sponsor for Elm in the Spring 2019." ]
        , p []
            [ text "More details to come!" ]
        ]


siteFooter : Html Msg
siteFooter =
    footer
        [ css styles.footer.top ]
        [ div [ css styles.footer.container ]
            [ div [ css styles.footer.left ] [ text "© Elm in the Spring 2019" ]
            , a [ css styles.footer.right, href "https://github.com/ryannhg/elm-in-the-spring", Attr.target "_blank" ]
                [ text "This site is open-source and written with Elm!" ]
            ]
        ]


logo : Html Msg
logo =
    span []
        [ strong [ css styles.logo.bigText ] [ text "ELM" ]
        , span [ css styles.logo.smallText ] [ text " in the " ]
        , br [] []
        , strong [ css styles.logo.bigText ] [ text "SPRING" ]
        ]
