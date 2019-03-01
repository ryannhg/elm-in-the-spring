module Shared exposing (siteFooter)

import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes as Attr exposing (css, href, target)
import Styles


siteFooter : Html msg
siteFooter =
    footer
        [ css Styles.footer.top
        , css
            [ lineHeight (num 1.4)
            , paddingTop (rem 4)
            ]
        ]
        [ div [ css Styles.footer.container ]
            [ div [ css (Styles.footer.left ++ [ displayFlex, alignItems center ]) ]
                [ text "© Elm in the Spring 2019"
                , div [ css [ fontSize (rem 1.5) ] ]
                    [ a
                        [ css [ marginLeft (rem 1) ]
                        , href "https://twitter.com/ElmInTheSpring"
                        , target "_blank"
                        ]
                        [ i [ Attr.class "fab fa-twitter" ] []
                        ]
                    ]
                ]
            , a
                [ css Styles.footer.right
                , css [ textAlign right ]
                , href "https://github.com/ryannhg/elm-in-the-spring"
                , Attr.target "_blank"
                ]
                [ text "This site is open-source and written with Elm!" ]
            , p [ Attr.class "preload-cursors" ]
                [ b [] [ text "preloading" ]
                , a [ href "#" ] [ text "cursors" ]
                , u [] [ text "before use!" ]
                ]
            ]
        ]
