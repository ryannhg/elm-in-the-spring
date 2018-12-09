module Ui exposing (btn)

import Css exposing (..)
import Css.Transitions exposing (transition)
import Html
import Html.Styled exposing (..)


theme : { navy : Color, pink : Color, darkPink : Color }
theme =
    { navy = hex "24357B"
    , pink = hex "ffc7e0"
    , darkPink = hex "CA808F"
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
            , property "box-shadow" "-5px 5px 0 #ff93a6, -10px 10px 0 #EEBBD1"
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
        ]
