module Sponsorship exposing (markup)

import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes as Attr exposing (alt, css, href, id, src, target)
import Styles


type alias Tier =
    { title : String
    , cost : String
    , perks : List String
    , iconAssetSrc : String
    }


markup =
    [ div [ Attr.class "sponsorship", css Styles.sponsorship.wrapper ] <|
        [ escape
        , hero
        ]
            ++ List.map tierView sponsorList
    ]


hero =
    div [ css Styles.sponsorship.hero ]
        [ h1 [ Attr.class "page-headline", css [ fontSize (Css.em 3) ] ] [ text "Sponsor Elm in the Spring" ]
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
    div [ Attr.class "grid-container-sponsorship" ]
        [ div [ Attr.class "Tier-Icon" ]
            [ img [ Attr.src tier.iconAssetSrc ] [] ]
        , div [ Attr.class "Tier-Name" ]
            [ h1 [ css [ paddingRight (Css.em 0.5) ] ] [ text tier.title ]
            , h2 [ css [ fontWeight (int 300) ] ] [ text tier.cost ]
            ]
        , div [ Attr.class "Tier-Perks" ]
            [ ul [] <|
                List.map
                    (\x -> li [] [ text x ])
                    tier.perks
            ]
        ]


sponsorList : List Tier
sponsorList =
    [ { title = "Old Grove"
      , cost = "$2,500"
      , perks = [ "20% discount on ticket purchases", "On-stage banner and speaker introduction opportunity. Limited space, first come first served!", "Logo included in videos and displayed on presentation screen between talks" ]
      , iconAssetSrc = "/images/sponsorship/old-grove.svg"
      }
    , { title = "Shade Tree"
      , cost = "$1,000"
      , perks = [ "15% discount on ticket purchases", "Special thank-you from the organizers during announcements", "Logo displayed on presentation screen between talks" ]
      , iconAssetSrc = "/images/sponsorship/shade-tree.svg"
      }
    , { title = "Spring Sapling"
      , cost = "$500"
      , perks = [ "10% discount on ticket purchases" ]
      , iconAssetSrc = "/images/sponsorship/spring-sapling.svg"
      }

    --, { title = "Video Recording"
    --  , cost = "..."
    --  , perks =  [ ... ]
    --  , iconAssetSrc = "/images/sponsorship/camera.svg"
    --  }
    ]
