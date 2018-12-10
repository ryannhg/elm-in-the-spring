module Ui exposing (SectionBgShapeData, angledSection, btn, hexValues, theme)

import Css exposing (..)
import Css.Transitions exposing (transition)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes as Attr exposing (css)


hexValues =
    { pinkLight = "#ff93a6"
    , pinkLightest = "#eebbd1"
    , navy = "#24357b"
    , teal = "#17B6D9"
    , pink = "#ffc7e0"
    }


theme =
    { navy = hex hexValues.navy
    , pinkLightest = hex hexValues.pinkLightest
    , pinkLight = hex hexValues.pinkLight
    , pink = hex hexValues.pink
    , pinkDark = hex "#ca808f"
    , teal = hex hexValues.teal
    , yellow = hex "#fff98e"
    , green = hex "#d6fd8c"
    }


btn : (List (Attribute msg) -> List (Html msg) -> Html msg) -> List (Attribute msg) -> List (Html msg) -> Html msg
btn element =
    styled element
        [ border3 (px 5) solid theme.navy
        , color theme.navy
        , display inlineBlock
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
        , zIndex (int 10)
        , before
            [ property "content" "''"
            , backgroundColor theme.pink

            -- can't do multiple box shadows directly with elm-css, as far as I can determine.
            , property "box-shadow" ("-5px 5px 0 " ++ hexValues.pinkLight ++ ", -10px 10px 0 " ++ hexValues.pinkLightest)
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
        , after
            [ property "content" "''"
            , top (px -5)
            , left (px -5)
            , height (pct 100)
            , width (pct 100)
            , border3 (px 5) solid theme.navy
            , position absolute
            , zIndex (int 0)
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


type alias SectionBgShapeData =
    { backgroundColor : Color
    , clipPath : String
    }


angledSection :
    Html msg
    ->
        { backgroundColor_ : ColorValue a
        , beforeShape : SectionBgShapeData
        , afterShape : SectionBgShapeData
        }
    -> Html msg
angledSection content { backgroundColor_, beforeShape, afterShape } =
    let
        sectionWrapper =
            styled div
                [ position relative
                , backgroundColor backgroundColor_
                , zIndex (int 3)
                ]

        wrappedContent =
            div [ css [ zIndex (int 2) ] ] [ content ]

        sectionBg =
            styled div
                [ position absolute
                , height (pct 100)
                , width (pct 100)
                , zIndex (int -10)
                , before
                    [ property "content" "''"
                    , position absolute
                    , height (pct 100)
                    , width (pct 100)
                    , backgroundColor beforeShape.backgroundColor
                    , property "clip-path" beforeShape.clipPath
                    , zIndex (int -8)
                    ]
                , after
                    [ property "content" "''"
                    , position absolute
                    , height (pct 100)
                    , width (pct 100)
                    , backgroundColor afterShape.backgroundColor
                    , property "clip-path" afterShape.clipPath
                    , zIndex (int -10)
                    ]
                ]
    in
    sectionWrapper [] [ sectionBg [] [], wrappedContent ]
