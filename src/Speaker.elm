module Speaker exposing (Social, SocialNetwork(..), Speaker, decoder)

import Json.Decode as Decode exposing (Decoder, int, string)
import Json.Decode.Pipeline exposing (custom, optional, required)


type alias Speaker =
    { name : String
    , talkTitle : String
    , talkSubtitle : String
    , headshotSrc : String
    , talkAbstract : String
    , bio : String
    , social : List Social
    }


type SocialNetwork
    = Website
    | Twitter
    | Github


type alias Social =
    { network : SocialNetwork
    , src : String
    }


socialDecoder : Decoder Social
socialDecoder =
    Decode.succeed Social
        |> required "network" (Decode.string |> Decode.andThen decodeSocialNetwork)
        |> required "src" Decode.string


decodeSocialNetwork : String -> Decoder SocialNetwork
decodeSocialNetwork network =
    case network of
        "website" ->
            Decode.succeed Website

        "twitter" ->
            Decode.succeed Twitter

        "github" ->
            Decode.succeed Github

        _ ->
            Decode.fail ("unknown network " ++ network)


decoder : Decoder Speaker
decoder =
    Decode.succeed Speaker
        |> required "name" Decode.string
        |> required "talk_title" Decode.string
        |> required "talk_subtitle" Decode.string
        |> required "headshot" Decode.string
        |> required "talk_abstract" Decode.string
        |> required "bio" Decode.string
        |> optional "social" (Decode.list socialDecoder) []
