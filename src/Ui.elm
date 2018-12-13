module Ui exposing
    ( BackgroundFill(..)
    , SectionBgShapeData
    , angledSection
    , btn
    , fillStyle
    , hexValues
    , textOffsetShadow
    , textOffsetStroke
    , theme
    )

import Css exposing (..)
import Css.Transitions exposing (transition)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes as Attr exposing (css)
import Url


hexValues =
    { pinkLight = "#ff93a6"
    , pinkLightest = "#eebbd1"
    , pinkDarkest = "#A56783"
    , pink = "#E57C79"
    , tealLightest = "#A7DBD6"
    , tealLight = "#75D3BE"
    , teal = "#5BC1B3"
    , green = "#99D653"
    , white = "#ffffff"
    , navy = "#284F86"
    }


theme =
    { teal = hex hexValues.teal
    , pinkLightest = hex hexValues.pinkLightest
    , pinkLight = hex hexValues.pinkLight
    , pink = hex hexValues.pink
    , pinkDark = hex "#ca808f"
    , yellow = hex "#fff98e"
    , green = hex hexValues.green
    , greenLight = hex "#d6fd8c"
    , tealLight = hex hexValues.tealLight
    , tealLightest = hex hexValues.tealLightest
    , white = hex hexValues.white
    , navy = hex hexValues.navy
    , pinkDarkest = hex hexValues.pinkDarkest
    }


type BackgroundFill a
    = LeafFill a
    | SolidFill a
    | FlowerFill a



-- TODO: desctructure out the color string from compatable? dunno


fillStyle : BackgroundFill String -> Css.Style
fillStyle bgFill =
    case bgFill of
        LeafFill colorString ->
            Css.batch
                [ backgroundColor (hex colorString)
                , backgroundImage (url <| "\"data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 80 40' width='80' height='40'%3E%3Cpath fill='" ++ Url.percentEncode colorString ++ "' fill-opacity='0.42' d='M0 40a19.96 19.96 0 0 1 5.9-14.11 20.17 20.17 0 0 1 19.44-5.2A20 20 0 0 1 20.2 40H0zM65.32.75A20.02 20.02 0 0 1 40.8 25.26 20.02 20.02 0 0 1 65.32.76zM.07 0h20.1l-.08.07A20.02 20.02 0 0 1 .75 5.25 20.08 20.08 0 0 1 .07 0zm1.94 40h2.53l4.26-4.24v-9.78A17.96 17.96 0 0 0 2 40zm5.38 0h9.8a17.98 17.98 0 0 0 6.67-16.42L7.4 40zm3.43-15.42v9.17l11.62-11.59c-3.97-.5-8.08.3-11.62 2.42zm32.86-.78A18 18 0 0 0 63.85 3.63L43.68 23.8zm7.2-19.17v9.15L62.43 2.22c-3.96-.5-8.05.3-11.57 2.4zm-3.49 2.72c-4.1 4.1-5.81 9.69-5.13 15.03l6.61-6.6V6.02c-.51.41-1 .85-1.48 1.33zM17.18 0H7.42L3.64 3.78A18 18 0 0 0 17.18 0zM2.08 0c-.01.8.04 1.58.14 2.37L4.59 0H2.07z'%3E%3C/path%3E%3C/svg%3E\"")
                , property "background-blend-mode" "screen"
                ]

        SolidFill colorString ->
            backgroundColor (hex colorString)

        FlowerFill colorString ->
            Css.batch
                [ backgroundColor (hex colorString)
                , backgroundImage (url "data:image/svg+xml;base64,PHN2ZyB2ZXJzaW9uPSIxLjEiCiAgICAgIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIKICAgICAgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiICBpZD0ic25hcHNob3QtODk3OTUiIHdpZHRoPSIyNTAiIGhlaWdodD0iMjUwIiB2aWV3Qm94PSIwIDAgMjUwIDI1MCI+PGRlc2M+VGhpcyBpbWFnZSB3YXMgbWFkZSBvbiBQYXR0ZXJuaW5qYS5jb208L2Rlc2M+PGRlZnM+CjwhLS0gaW1hZ2UgMjA5MDEgLS0+CjxnIGlkPSJ0cmFuc2Zvcm1lZC0yMDkwMSIgZGF0YS1pbWFnZT0iMjA5MDEiIHRyYW5zZm9ybT0idHJhbnNsYXRlKDE4OS40ODk2MjM1MDM2NjkxMiwgMTcwLjE5OTYyMzUwMzY2OTE2KSByb3RhdGUoMCwgMzguMzgwMzc2NDk2MzMwODksIDM4LjM4MDM3NjQ5NjMzMDg3KSI+PGc+PHN2ZyB2ZXJzaW9uPSIxLjEiIHdpZHRoPSI3Ni43NjA3NTI5OTI2NjE3OHB4IiBoZWlnaHQ9Ijc2Ljc2MDc1Mjk5MjY2MTc0cHgiIHZpZXdCb3g9IjAgMCA3Ni43NjA3NTI5OTI2NjE3OCA3Ni43NjA3NTI5OTI2NjE3NCI+PGcgaWQ9Im9yaWdpbmFsLTIwOTAxIj48c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgdmlld0JveD0iMCAwIDM1MSAzNTEiIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB2ZXJzaW9uPSIxLjEiIHByZXNlcnZlQXNwZWN0UmF0aW89InhNaWRZTWlkIG1lZXQiPgogIDxwYXRoIGZpbGwtcnVsZT0ibm9uemVybyIgc3Ryb2tlLXdpZHRoPSI0IiBkPSJNMyAyaDM0NWExIDEgMCAwIDEgMSAxdjM0NWExIDEgMCAwIDEtMSAxSDNhMSAxIDAgMCAxLTEtMVYzYTEgMSAwIDAgMSAxLTF6bTE3Mi44NjYgMTY0Ljg2NkwyNDUuNzMxIDk3SDEwNmw2OS44NjYgNjkuODY2ek0yMyAxNGw3MC4zNzQgNzAuMzc1aDE1Mi45NzJMMTc1Ljk3MSAxNEgyM3ptMjM3LjQ4NSA4NUwxODQgMTc1LjQ4NWw3Ni4xMzggNzYuMTM4IDc2LjQ4NS03Ni40ODVMMjYwLjQ4NSA5OXptNzYuMjQgNTguNzI0VjE0SDE5M2wxNDMuNzI1IDE0My43MjR6bS0xNjkuOTQ0IDE4LjA1N0wxNCAyM3YzMDUuNTY0bDE1Mi43ODEtMTUyLjc4M3pNMjY5IDI2MC43NzZsNjcuNzc2IDY3Ljc3N1YxOTNMMjY5IDI2MC43NzZ6TTE3NS43OCAxODVMMjMgMzM3Ljc4MWgzMDUuNTYxTDE3NS43OCAxODV6IiBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIGZpbGw9InJnYmEoMCwgMCwgMCwgMSkiIHN0cm9rZT0icmdiYSgwLCAwLCAwLCAxKSIvPgo8L3N2Zz4KPC9nPjwvc3ZnPjwvZz48L2c+CjwhLS0gL2ltYWdlIDIwOTAxIC0tPgoKPCEtLSBpbWFnZSAyMTk4NyAtLT4KPGcgaWQ9InRyYW5zZm9ybWVkLTIxOTg3IiBkYXRhLWltYWdlPSIyMTk4NyIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoNTIuMzUxNTY1ODYwOTA4NzY0LCAyNy4xNjk4NTQ1ODYzMTA1MTQpIHJvdGF0ZSgwLCA0OC4zMDg0MzQxMzkwOTEyMywgNTguMTEwMTQ1NDEzNjg5NDkpIj48Zz48c3ZnIHZlcnNpb249IjEuMSIgd2lkdGg9Ijk2LjYxNjg2ODI3ODE4MjQ3cHgiIGhlaWdodD0iMTE2LjIyMDI5MDgyNzM3ODk3cHgiIHZpZXdCb3g9IjAgMCA5Ni42MTY4NjgyNzgxODI0NyAxMTYuMjIwMjkwODI3Mzc4OTciPjxnIGlkPSJvcmlnaW5hbC0yMTk4NyI+PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAxMjYgMTUyIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgdmVyc2lvbj0iMS4xIiBwcmVzZXJ2ZUFzcGVjdFJhdGlvPSJ4TWlkWU1pZCBtZWV0Ij4KICA8cGF0aCBkPSJNMTcuNSA0Ni41bDE5IDE5di0zOHoiIGZpbGwtcnVsZT0iZXZlbm9kZCIgc3Ryb2tlLWxpbmVjYXA9InJvdW5kIiBzdHJva2UtbGluZWpvaW49InJvdW5kIiBmaWxsPSJyZ2JhKDAsIDAsIDAsIDEpIiBzdHJva2U9InJnYmEoMCwgMCwgMCwgMSkiLz4KICA8cGF0aCBkPSJNNDIgMjdsMTkgMTkuMjJWODhMNDIgNjguNzc5eiIgZmlsbC1ydWxlPSJldmVub2RkIiBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIGZpbGw9InJnYmEoMCwgMCwgMCwgMSkiIHN0cm9rZT0icmdiYSgwLCAwLCAwLCAxKSIvPgogIDxwYXRoIGQ9Ik02NC4wNDggMEw4NSAyMC45NTIgNjMuOTUyIDQyIDQzIDIxLjA0OHoiIGZpbGwtcnVsZT0iZXZlbm9kZCIgc3Ryb2tlLWxpbmVjYXA9InJvdW5kIiBzdHJva2UtbGluZWpvaW49InJvdW5kIiBmaWxsPSJyZ2JhKDAsIDAsIDAsIDEpIiBzdHJva2U9InJnYmEoMCwgMCwgMCwgMSkiLz4KICA8cGF0aCBkPSJNMTA1IDQ5SDY2djM5eiIgZmlsbC1ydWxlPSJldmVub2RkIiBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIGZpbGw9InJnYmEoMCwgMCwgMCwgMSkiIHN0cm9rZT0icmdiYSgwLCAwLCAwLCAxKSIvPgogIDxwYXRoIGQ9Ik02MC44NSA5Mi4xNUgxLjQ1MWw1OS4zOTcgNTkuMzk4eiIgZmlsbC1ydWxlPSJldmVub2RkIiBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIGZpbGw9InJnYmEoMCwgMCwgMCwgMSkiIHN0cm9rZT0icmdiYSgwLCAwLCAwLCAxKSIvPgogIDxwYXRoIGQ9Ik04Ny41IDI1TDY5IDQ0aDM3eiIgZmlsbC1ydWxlPSJldmVub2RkIiBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIGZpbGw9InJnYmEoMCwgMCwgMCwgMSkiIHN0cm9rZT0icmdiYSgwLCAwLCAwLCAxKSIvPgogIDxwYXRoIGQ9Ik02NS42NSA5Mi4xNWwuMzU0IDU5LjA0NCA1OC42OS01OC42OXoiIGZpbGwtcnVsZT0iZXZlbm9kZCIgc3Ryb2tlLWxpbmVjYXA9InJvdW5kIiBzdHJva2UtbGluZWpvaW49InJvdW5kIiBmaWxsPSJyZ2JhKDAsIDAsIDAsIDEpIiBzdHJva2U9InJnYmEoMCwgMCwgMCwgMSkiLz4KPC9zdmc+CjwvZz48L3N2Zz48L2c+PC9nPgo8IS0tIC9pbWFnZSAyMTk4NyAtLT4KPC9kZWZzPjxyZWN0IHg9IjAiIHk9IjAiIHdpZHRoPSIyNTAiIGhlaWdodD0iMjUwIiBmaWxsPSJyZ2JhKDAsIDAsIDAsIDApIj48L3JlY3Q+PHVzZSB4bGluazpocmVmPSIjdHJhbnNmb3JtZWQtMjA5MDEiIHRyYW5zZm9ybT0idHJhbnNsYXRlKC0yNTAsIC0yNTApIj48L3VzZT48dXNlIHhsaW5rOmhyZWY9IiN0cmFuc2Zvcm1lZC0yMDkwMSIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMCwgLTI1MCkiPjwvdXNlPjx1c2UgeGxpbms6aHJlZj0iI3RyYW5zZm9ybWVkLTIwOTAxIiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgyNTAsIC0yNTApIj48L3VzZT48dXNlIHhsaW5rOmhyZWY9IiN0cmFuc2Zvcm1lZC0yMDkwMSIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoLTI1MCwgMCkiPjwvdXNlPjx1c2UgeGxpbms6aHJlZj0iI3RyYW5zZm9ybWVkLTIwOTAxIiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgwLCAwKSI+PC91c2U+PHVzZSB4bGluazpocmVmPSIjdHJhbnNmb3JtZWQtMjA5MDEiIHRyYW5zZm9ybT0idHJhbnNsYXRlKDI1MCwgMCkiPjwvdXNlPjx1c2UgeGxpbms6aHJlZj0iI3RyYW5zZm9ybWVkLTIwOTAxIiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMjUwLCAyNTApIj48L3VzZT48dXNlIHhsaW5rOmhyZWY9IiN0cmFuc2Zvcm1lZC0yMDkwMSIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMCwgMjUwKSI+PC91c2U+PHVzZSB4bGluazpocmVmPSIjdHJhbnNmb3JtZWQtMjA5MDEiIHRyYW5zZm9ybT0idHJhbnNsYXRlKDI1MCwgMjUwKSI+PC91c2U+PHVzZSB4bGluazpocmVmPSIjdHJhbnNmb3JtZWQtMjE5ODciIHRyYW5zZm9ybT0idHJhbnNsYXRlKC0yNTAsIC0yNTApIj48L3VzZT48dXNlIHhsaW5rOmhyZWY9IiN0cmFuc2Zvcm1lZC0yMTk4NyIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMCwgLTI1MCkiPjwvdXNlPjx1c2UgeGxpbms6aHJlZj0iI3RyYW5zZm9ybWVkLTIxOTg3IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgyNTAsIC0yNTApIj48L3VzZT48dXNlIHhsaW5rOmhyZWY9IiN0cmFuc2Zvcm1lZC0yMTk4NyIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoLTI1MCwgMCkiPjwvdXNlPjx1c2UgeGxpbms6aHJlZj0iI3RyYW5zZm9ybWVkLTIxOTg3IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgwLCAwKSI+PC91c2U+PHVzZSB4bGluazpocmVmPSIjdHJhbnNmb3JtZWQtMjE5ODciIHRyYW5zZm9ybT0idHJhbnNsYXRlKDI1MCwgMCkiPjwvdXNlPjx1c2UgeGxpbms6aHJlZj0iI3RyYW5zZm9ybWVkLTIxOTg3IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMjUwLCAyNTApIj48L3VzZT48dXNlIHhsaW5rOmhyZWY9IiN0cmFuc2Zvcm1lZC0yMTk4NyIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMCwgMjUwKSI+PC91c2U+PHVzZSB4bGluazpocmVmPSIjdHJhbnNmb3JtZWQtMjE5ODciIHRyYW5zZm9ybT0idHJhbnNsYXRlKDI1MCwgMjUwKSI+PC91c2U+PC9zdmc+")
                , property "background-blend-mode" "soft-light"
                , backgroundSize (pct 7.5)
                ]


btn : (List (Attribute msg) -> List (Html msg) -> Html msg) -> List (Attribute msg) -> List (Html msg) -> Html msg
btn element =
    styled element
        [ border3 (px 5) solid theme.greenLight
        , color theme.greenLight
        , display inlineBlock
        , fontSize (rem 1.5)
        , textAlign center
        , padding3 (rem 1) (rem 1) (rem 1)
        , letterSpacing (rem 0.1)
        , lineHeight (num 1)
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
            , bottom zero
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
            , border3 (px 5) solid theme.greenLight
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
    { fill : Css.Style
    , clipPath : String
    }


angledSection :
    Html msg
    ->
        { baseFillStyle : Css.Style
        , beforeShape : SectionBgShapeData
        , afterShape : SectionBgShapeData
        }
    -> Html msg
angledSection content { baseFillStyle, beforeShape, afterShape } =
    let
        sectionWrapper =
            styled div
                [ position relative
                , baseFillStyle
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
                    , beforeShape.fill
                    , property "clip-path" beforeShape.clipPath
                    , zIndex (int -8)
                    ]
                , after
                    [ property "content" "''"
                    , position absolute
                    , height (pct 100)
                    , width (pct 100)
                    , afterShape.fill
                    , property "clip-path" afterShape.clipPath
                    , zIndex (int -10)
                    ]
                ]
    in
    sectionWrapper [] [ sectionBg [] [], wrappedContent ]


textOffsetStroke : { textContent : String, outlineColorString : String, shadowColor : Color } -> Html msg
textOffsetStroke { textContent, outlineColorString, shadowColor } =
    styled span
        [ property "-webkit-text-stroke-width" "2px"
        , property "text-stroke-width" "3px"
        , property "-webkit-text-stroke-color" outlineColorString
        , textShadow3 (px 7) (px 7) shadowColor
        , color transparent
        ]
        []
        [ text textContent ]


textOffsetShadow : { textContent : String, outlineColorString : String, fillColor : Color, shadowColor : Color } -> Html msg
textOffsetShadow { textContent, outlineColorString, shadowColor, fillColor } =
    styled span
        [ property "-webkit-text-stroke-width" "3px"
        , property "text-stroke-width" "3px"
        , property "-webkit-text-stroke-color" outlineColorString
        , textShadow3 (px 7) (px 7) shadowColor
        , color fillColor
        , property "background-clip" "text"
        ]
        []
        [ text textContent ]
