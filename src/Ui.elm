module Ui exposing (btn, hexValues, theme)

import Css exposing (..)
import Css.Transitions exposing (transition)
import Html
import Html.Styled exposing (..)


hexValues =
    { lightPink = "#ff93a6"
    , lightestPink = "#eebbd1"
    , navy = "#24357b"
    , teal = "#8bc7cb"
    , pink = "#ffc7e0"
    }


theme =
    { navy = hex hexValues.navy
    , lightestPink = hex hexValues.lightestPink
    , lightPink = hex hexValues.lightPink
    , pink = hex hexValues.pink
    , darkPink = hex "#ca808f"
    , teal = hex hexValues.teal
    , yellow = hex "#fff98e"
    , green = hex "#d6fd8c"
    }


btn : (List (Attribute msg) -> List (Html msg) -> Html msg) -> List (Attribute msg) -> List (Html msg) -> Html msg
btn element =
    styled element
        [ border3 (px 5) solid theme.navy
        , color theme.navy
        , display block
        , fontSize (rem 1.5)
        , textAlign center
        , padding3 (rem 1.2) (rem 1) (rem 1)
        , letterSpacing (rem 0.1)
        , lineHeight (rem 1)
        , position relative
        , textDecoration none
        , textTransform uppercase
        , backgroundColor transparent
        , cursor pointer
        , before
            [ property "content" "''"
            , backgroundColor theme.pink

            -- can't do multiple box shadows directly with elm-css, as far as I can determine.
            , property "box-shadow" ("-5px 5px 0 " ++ hexValues.lightPink ++ ", -10px 10px 0 " ++ hexValues.lightestPink)
            , position absolute
            , top zero
            , left zero
            , height (rem 3.25)
            , width (pct 102)
            , transform (translate2 (px -12) (px 7))
            , transition
                [ Css.Transitions.transform 200
                , Css.Transitions.boxShadow 200
                ]
            , property "will-change" "transform, box-shadow"
            , zIndex (int -1)
            ]
        , hover
            [ before
                [ boxShadow none
                , transform (translate2 zero zero)
                ]
            ]
        , active
            [ transform (translateY (px 3))
            , before
                [ width (pct 100)
                , height (pct 100)
                ]
            ]
        ]
