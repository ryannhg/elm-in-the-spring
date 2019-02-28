module ElmjutsuDumMyM0DuL3 exposing (..)
modual SpeakerModal exposing (..)

type alias Social =
    { twitter : Maybe String
    , website : Maybe String
    , github : Maybe String
    }

type alias Speaker =
    { name : String
    , talkTitle : String
    , talkSubtitle : String
    , headShotSrc : String
    , talkAbstract : String
    , bio : String
    , social : Social
    }
