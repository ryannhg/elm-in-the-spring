module Speaker exposing (Social, Speaker, decoder)

import Json.Decode as Decode exposing (Decoder, int, string)
import Json.Decode.Pipeline exposing (custom, optional, required)


type alias Speaker =
    { name : String
    , talkTitle : String
    , talkSubtitle : String
    , headshotSrc : String
    , talkAbstract : String
    , bio : String
    , social : Social
    }


type alias Social =
    { twitter : Maybe String
    , website : Maybe String
    , github : Maybe String
    }


decoder : Decoder Speaker
decoder =
    Decode.succeed Speaker
        |> required "name" Decode.string
        |> required "talk_title" Decode.string
        |> required "talk_subtitle" Decode.string
        |> required "headshot" Decode.string
        |> required "talk_abstract" Decode.string
        |> required "bio" Decode.string
        |> custom socialDecoder


socialDecoder : Decoder Social
socialDecoder =
    Decode.succeed Social
        |> optional "twitter" (Decode.maybe Decode.string) Nothing
        |> optional "website" (Decode.maybe Decode.string) Nothing
        |> optional "github" (Decode.maybe Decode.string) Nothing
