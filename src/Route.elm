module Route exposing (Route(..), fromUrl, toString)

import Url exposing (Url)
import Url.Parser exposing ((<?>), Parser, map, oneOf, s, string, top)
import Url.Parser.Query as Query


type Route
    = Home (Maybe String)
    | NotFound


toString : Route -> String
toString route =
    case route of
        Home (Just speakerName) ->
            "/speakers?name=" ++ speakerName

        Home Nothing ->
            "/"

        NotFound ->
            "/"


fromUrl : Url -> Route
fromUrl =
    Url.Parser.parse
        (oneOf
            [ Url.Parser.map Home (top <?> Query.string "speaker")
            , map (Home Nothing) top
            ]
        )
        >> Maybe.withDefault (Home Nothing)
