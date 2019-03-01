module Route exposing (Route(..), fromUrl, toString)

import Url exposing (Url)
import Url.Parser exposing ((<?>), Parser, map, oneOf, s, string, top)
import Url.Parser.Query as Query


type Route
    = Home (Maybe String)
    | Sponsorship
    | NotFound


toString : Route -> String
toString route =
    case route of
        Home (Just speakerName) ->
            "/speakers?name=" ++ speakerName

        Home Nothing ->
            "/"

        Sponsorship ->
            "/sponsorship"

        NotFound ->
            "/"


fromUrl : Url -> Route
fromUrl =
    Url.Parser.parse
        (oneOf
            [ Url.Parser.map Home (top <?> Query.string "speaker")
            , map (Home Nothing) top
            , Url.Parser.map Sponsorship (s "sponsorship")
            ]
        )
        >> Maybe.withDefault (Home Nothing)
