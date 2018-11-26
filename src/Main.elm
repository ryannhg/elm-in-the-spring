port module Main exposing (main)

import Browser
import Css exposing (..)
import Css.Global exposing (body, global, html)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, href, id, src)
import Html.Styled.Events exposing (onClick)


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
            [ marginLeft (rem 1)
            , firstChild [ marginLeft zero ]
            ]
        }
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
        [ padding2 (rem 4) zero
        , displayFlex
        , justifyContent center
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
    Maybe Int


main : Program () Model Msg
main =
    Browser.element
        { init = always ( Nothing, Cmd.none )
        , update = update
        , view = view >> toUnstyled
        , subscriptions = always Sub.none
        }



-- UPDATE


type Msg
    = JumpTo String


port outgoing : ( String, String ) -> Cmd msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        JumpTo id ->
            ( model
            , outgoing ( "JUMP_TO", id )
            )



-- VIEW


view : Model -> Html Msg
view _ =
    div [ css styles.view ]
        [ globalStyles
        , navbar
        , hero
        , div [ id "tickets" ] [ pageSection "Tickets" ]
        , div [ id "speakers" ] [ pageSection "Speakers" ]
        , div [ id "sponsors" ] [ pageSection "Sponsors" ]
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
    div [ css styles.hero ]
        [ h1 [ css styles.logo.h1 ] [ logo ]
        ]


pageSection : String -> Html Msg
pageSection title =
    section [ css styles.pageSection.top ]
        [ div [ css styles.pageSection.container ]
            [ h3 [ css styles.pageSection.title ] [ text title ]
            ]
        , div [ css styles.pageSection.contentWrapper ]
            [ div [ css styles.pageSection.container ]
                [ div [ css styles.pageSection.content ]
                    [ p []
                        [ text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam consectetur dui eget imperdiet rhoncus. Sed at mauris ac sapien finibus congue id non eros. Proin sit amet semper risus, a luctus tortor. Praesent eget porta purus. Ut velit tellus, euismod sit amet sollicitudin nec, congue a felis. Curabitur sit amet eleifend massa. Vivamus luctus rhoncus ornare. Pellentesque venenatis sapien sagittis velit iaculis, pulvinar vehicula nisi euismod. Praesent volutpat, neque eu scelerisque laoreet, purus velit fringilla nulla, eu pretium augue orci nec arcu." ]
                    ]
                ]
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
