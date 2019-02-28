module Styles exposing (body, buttonInput, contactForm, footer, global, header, hero, html, input, link, logo, pageSection, sponsorship, view)

import Css exposing (..)
import Css.Global
import Css.Media as Media
import Html exposing (Html)
import Html.Styled exposing (..)
import Ui


html =
    [ height (pct 100)
    , Css.batch [ Media.withMedia [ Media.only Media.screen [ Media.minWidth (px 720) ] ] [ fontSize (px 18) ] ]
    , Css.batch [ Media.withMedia [ Media.only Media.screen [ Media.minWidth (px 481) ] ] [ fontSize (px 17) ] ]
    , Css.batch [ Media.withMedia [ Media.only Media.screen [ Media.maxWidth (px 480) ] ] [ fontSize (px 15) ] ]
    ]


body =
    [ height (pct 100)
    , margin zero
    , fontFamilies [ "Hind Madurai", "sans-serif" ]
    , fontWeight (int 300)
    , backgroundColor Ui.theme.teal
    , color Ui.theme.navy
    ]


global : Html.Styled.Html msg
global =
    Css.Global.global
        [ Css.Global.html html
        , Css.Global.body body
        , Css.Global.selector "body *" [ boxSizing borderBox, outline none ]
        , Css.Global.h1 [ fontFamilies [ "Biko", "Hind Madurai", "sans-serif" ] ]
        , Css.Global.h2 [ fontFamilies [ "Biko", "Hind Madurai", "sans-serif" ] ]
        , Css.Global.h3 [ fontFamilies [ "Biko", "Hind Madurai", "sans-serif" ] ]
        , Css.Global.h4 [ fontFamilies [ "Biko", "Hind Madurai", "sans-serif" ] ]
        , Css.Global.h5 [ fontFamilies [ "Biko", "Hind Madurai", "sans-serif" ] ]
        , Css.Global.h6 [ fontFamilies [ "Biko", "Hind Madurai", "sans-serif" ] ]
        , Css.Global.p
            [ fontSize (rem 1.45)
            , margin zero
            , firstChild [ marginTop zero ]
            , marginTop (rem 1.5)
            , lineHeight (num 1.4)
            ]
        , Css.Global.h4
            [ fontSize (rem 2)
            , lineHeight (num 1)
            , margin zero
            , firstChild [ marginTop zero ]
            , marginTop (rem 1.5)
            ]
        , Css.Global.h5
            [ fontSize (rem 1.75)
            , lineHeight (num 1)
            , margin zero
            , firstChild [ marginTop zero ]
            , marginTop (rem 1.5)
            ]
        , Css.Global.h3
            [ fontSize (rem 3.5)
            , lineHeight (num 1)
            ]
        , Css.Global.form [ margin zero ]
        ]


view =
    []


header =
    { wrapper =
        [ position absolute
        , top zero
        , zIndex (int 10)
        , width (pct 100)
        ]
    , top =
        [ fontSize (rem 1.5)
        , padding2 (rem 2) (rem 1.5)
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


link =
    [ backgroundColor transparent
    , color inherit
    , fontFamily inherit
    , fontSize inherit
    , padding zero
    , border zero
    , opacity (num 0.75)
    , hover [ opacity (num 1) ]
    ]


hero =
    { top =
        [ padding2 (rem 8) zero
        , displayFlex
        , alignItems center
        , flexDirection column
        ]
    , wrapper = { base = [ margin3 (px 200) auto zero, maxWidth (px 960) ], desktop = [ maxWidth (pct 60) ], mobile = [ maxWidth (pct 100) ] }
    , grid =
        { desktop =
            [ property "display" "grid"
            , property "grid-gap" "30px 20px"
            , property "grid-template-rows" "auto auto auto"
            , property "grid-template-columns" "30% auto 0%"
            , paddingBottom (px 50)
            , maxWidth (pct 95)
            , margin2 zero auto
            ]
        , mobile = [ property "grid-gap" "20px" ]
        }
    , logoText = [ property "justify-self" "center", property "grid-column" "2 / span 2" ]
    , logoFlower =
        { image = [ width (px 400), maxWidth (pct 100) ]
        , desktop =
            [ property "grid-row" "1 / span 3"
            , property "grid-column" "1"
            ]
        , mobile = [ property "grid-row" "1" ]
        }
    , textContent =
        { base = [ fontWeight (int 400), textAlign center, fontSize (rem 1.6), lineHeight (rem 2) ], mobile = [ property "grid-row" "2", property "grid-column" "1 / span 3" ] }
    , buttonWrapper =
        { desktop = [ property "grid-column" "2 / span 2" ], mobile = [ property "grid-column" "1 / span 3" ] }
    , buttons = [ displayFlex, alignSelf center, justifyContent center ]
    }


contactForm =
    [ property "display" "grid"
    , property "grid-gap" "10px"
    , property "grid-template-columns" "1fr 1fr"
    , Css.batch
        [ Media.withMedia [ Media.only Media.screen [ Media.maxWidth (px 720) ] ]
            [ property "grid-template-columns" "1fr" ]
        ]
    , maxWidth (px 610)
    , marginTop (px 20)
    ]


input =
    [ backgroundColor Ui.theme.pinkLight
    , fontSize (rem 1.5)
    , lineHeight (int 1)
    , fontFamily inherit
    , height (px 66)
    , border3 (px 5) solid Ui.theme.pink
    , padding2 (rem 0.6) (rem 1)
    , maxWidth (px 300)
    ]


buttonInput =
    [ fontSize (rem 1.5)
    , lineHeight (int 1)
    , height (px 66)
    , fontFamily inherit
    , border3 (px 5) solid Ui.theme.greenLight
    , padding2 (rem 0.6) (rem 1)
    , textTransform uppercase
    , color Ui.theme.greenLight
    , active [ transform (translateY (px 3)) ]
    , backgroundColor transparent
    , maxWidth (px 300)
    ]


pageSection =
    { top =
        [ padding2 (rem 4) zero
        , color Ui.theme.greenLight
        ]
    , container =
        [ margin2 zero auto
        , maxWidth (px 960)
        , width (pct 100)
        , padding2 zero (rem 3)
        , Css.batch [ Media.withMedia [ Media.only Media.screen [ Media.maxWidth (px 480) ] ] [ padding zero ] ]
        ]
    , title =
        [ textTransform uppercase
        , letterSpacing (px 4)
        , textAlign center
        , margin2 zero (rem -3)
        , Css.batch [ Media.withMedia [ Media.only Media.screen [ Media.maxWidth (px 480) ] ] [ margin zero ] ]
        ]
    , contentWrapper =
        \isLeftSide ->
            [ position relative
            , before
                [ property "content" "''"
                , position absolute
                , top zero
                , if isLeftSide then
                    left zero

                  else
                    left (pct 50)
                , if isLeftSide then
                    right (pct 50)

                  else
                    right zero
                , bottom zero
                , backgroundColor Ui.theme.navy
                , zIndex (int -1)
                ]
            ]
    , content =
        \isLeftSide ->
            [ maxWidth (pct 100)
            , margin2 zero auto
            , marginTop (rem 2)
            , fontSize (px 20)
            , lineHeight (num 1.4)
            , padding2 (rem 3) (rem 1)
            , Css.batch
                [ Media.withMedia [ Media.only Media.screen [ Media.minWidth (px 481) ] ]
                    [ if isLeftSide then
                        paddingLeft zero

                      else
                        paddingLeft (rem 2)
                    ]
                ]
            , backgroundColor Ui.theme.navy
            , color Ui.theme.teal
            ]
    }


logo =
    { h1 =
        [ fontSize (rem 6)
        , lineHeight (num 0.9)
        , whiteSpace noWrap
        , margin zero
        ]
    , h2 =
        [ backgroundColor Ui.theme.green
        , color Ui.theme.teal
        , padding (rem 2)
        , textTransform uppercase
        ]
    , bigText =
        [ fontSize (Css.em 1)
        , letterSpacing (Css.em (1 / 16))
        ]
    , smallText =
        [ fontSize (Css.em (5 / 8))
        ]
    }


footer =
    { top =
        [ padding (rem 1.5)
        , color Ui.theme.greenLight
        ]
    , container =
        [ width (pct 100)
        , maxWidth (px 960)
        , margin2 zero auto
        , displayFlex
        , justifyContent spaceBetween
        ]
    , left = []
    , right = [ color Ui.theme.greenLight ]
    }


sponsorship =
    { logo = [ height (px 80) ]
    , wrapper =
        [ width (pct 100)
        , maxWidth (px 960)
        , margin2 zero auto
        , padding2 zero (rem 3)
        ]
    , hero = [ textAlign center ]
    }
