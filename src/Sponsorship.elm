module Sponsorship exposing (markup)

import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes as Attr exposing (alt, css, href, id, src, target)
import Styles


type alias Tier =
    { title : String, cost : String, perks : List String }


markup =
    [ div [ css Styles.sponsorship.wrapper ] <|
        [ escape
        , hero
        ]
            ++ List.map tierView sponsorList
    ]


hero =
    div [ css Styles.sponsorship.hero ]
        [ h1 [] [ text "Sponsor Elm in the Spring" ]
        ]


escape =
    a
        [ href "/"
        ]
        [ img
            [ css
                Styles.sponsorship.logo
            , src "/images/flower.svg"
            ]
            []
        ]


tierView tier =
    div []
        [ div []
            [ h2 [] [ text tier.title ]
            , span [] [ text tier.cost ]
            ]
        , div [] <|
            List.map
                (\x -> li [] [ text x ])
                tier.perks
        ]


sponsorList : List Tier
sponsorList =
    [ Tier "Old Grove" "$2,500" [ "20% discount on ticket purchases", "On-stage banner and speaker introduction opportunity. Limited space, first come first served!", "Logo included in videos and displayed on presentation screen between talks" ]
    , Tier "Shade Tree" "$1,000" [ "15% discount on ticket purchases", "Special thank-you from the organizers during announcements", "Logo displayed on presentation screen between talks" ]
    , Tier "Spring Sapling" "$500" [ "10% discount on ticket purchases" ]
    ]
