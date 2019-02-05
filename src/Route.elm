module Route exposing (Route(..), fromUrl, toString)

import Url exposing (Url)
import Url.Parser exposing ((</>), Parser, map, oneOf, s, top)
import Url.Parser.Query as Query


type Route
    = Home
    | Sponsorship
    | NotFound


toString : Route -> String
toString route =
    case route of
        Home ->
            "/"

        Sponsorship ->
            "/sponsorship"

        NotFound ->
            "/"


fromUrl : Url -> Route
fromUrl =
    Url.Parser.parse
        (oneOf
            [ map Home top
            , map Sponsorship (s "sponsorship")
            ]
        )
        >> Maybe.withDefault NotFound
