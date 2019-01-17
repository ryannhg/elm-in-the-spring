module Styles exposing (body, contactForm, footer, global, header, hero, html, input, link, logo, pageSection, view)

import Css exposing (..)
import Css.Global
import Html exposing (Html)
import Html.Styled exposing (..)
import Ui


html =
    [ height (pct 100)
    , fontSize (px 16)
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
        , Css.Global.form [ margin zero ]
        ]



-- , fontFamilies [ "Biko", "sans-serif" ]


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



--hide =
--    [ height zero
--    , width zero
--    , margin zero
--    , overflow hidden
--    ]


link =
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
            , property "grid-template-columns" "30% auto"
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
        { base = [ textAlign center, fontSize (rem 1.6), lineHeight (rem 2) ], mobile = [ property "grid-row" "2", property "grid-column" "1 / span 3" ] }
    , buttonWrapper =
        { desktop = [ property "grid-column" "2 / span 2" ], mobile = [ property "grid-column" "1 / span 3" ] }
    , buttons = [ displayFlex, alignSelf center, justifyContent center ]
    }


contactForm =
    []


input =
    [ backgroundColor Ui.theme.pinkLightest
    , fontSize inherit
    , lineHeight (rem 1)
    , height (rem 3.25)
    , fontFamily inherit
    , border3 (px 2) solid Ui.theme.teal
    , padding2 (rem 0.6) (rem 1)
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
        ]
    , title =
        [ fontSize (rem 4)
        , textTransform uppercase
        , letterSpacing (px 4)
        , textAlign center
        , margin2 zero (rem -3)
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
            , padding2 (rem 3) (rem 2)
            , if isLeftSide then
                paddingLeft zero

              else
                paddingLeft (rem 2)
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
