port module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Css exposing (..)
import Css.Global exposing (body, global, html)
import Css.Media as Media
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes as Attr exposing (alt, css, href, id, src, target)
import Html.Styled.Events exposing (onClick, onInput)
import Http
import HttpBuilder
import Json.Decode as Decode
import Route exposing (Route(..))
import Shared
import Speaker exposing (Speaker)
import Sponsorship
import Styles
import Svg.Styled as Svg
import Svg.Styled.Attributes as SvgAttr
import Ui
import Url



-- MAIN


type alias Model =
    { name : String
    , email : String
    , key : Nav.Key
    , route : Route
    , speakers : List Speaker
    }


init : a -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( Model "" "" key (Route.fromUrl url) [], loadSpeakers )


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        , onUrlRequest = OnUrlRequest
        , onUrlChange = OnUrlChange
        }


loadSpeakers : Cmd Msg
loadSpeakers =
    HttpBuilder.get "/speaker_data.json"
        |> HttpBuilder.withExpectJson (Decode.list Speaker.decoder)
        |> HttpBuilder.send LoadSpeakers



-- UPDATE


type Field
    = Name
    | Email


type Msg
    = JumpTo String
    | UpdateField Field String
    | SubmitForm
    | OnUrlRequest Browser.UrlRequest
    | OnUrlChange Url.Url
      -- | ClickOpenSpeakerModal
    | LoadSpeakers (Result Http.Error (List Speaker))


port outgoing : ( String, String ) -> Cmd msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        JumpTo id ->
            ( model
            , outgoing ( "JUMP_TO", id )
            )

        UpdateField Name name ->
            ( { model | name = name }
            , Cmd.none
            )

        UpdateField Email email ->
            ( { model | email = email }
            , Cmd.none
            )

        SubmitForm ->
            ( { model | name = "", email = "" }
            , outgoing ( "SUBMIT_FORM", model.email )
            )

        OnUrlChange url ->
            ( { model | route = Route.fromUrl url }, outgoing ( "JUMP_TO", "topScroll" ) )

        OnUrlRequest urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Cmd.batch [ outgoing ( "JUMP_TO", "topScroll" ), Nav.pushUrl model.key (Url.toString url) ] )

                Browser.External href ->
                    ( model, Nav.load href )

        LoadSpeakers (Ok speakers) ->
            let
                _ =
                    Debug.log "model" model
            in
            ( { model | speakers = speakers }
            , Cmd.none
            )

        LoadSpeakers (Err httpError) ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Browser.Document Msg
view model =
    let
        page markupList =
            div [ css Styles.view ] <|
                [ div [ id "topScroll" ] []
                , Styles.global
                ]
                    ++ markupList
                    ++ [ Shared.siteFooter ]
    in
    case model.route of
        Home ->
            let
                homeMarkup =
                    [ navbar
                    , hero
                    , pageSection Details Nothing model
                    , pageSection Speakers Nothing model
                    , pageSection Sponsors (Just sponsorLogos) model
                    ]
            in
            { title = "Elm in the Spring 2019"
            , body = [ homeMarkup |> page |> toUnstyled ]
            }

        Sponsorship ->
            { title = "Elm in the Spring 2019 | Sponsorship"
            , body = [ Sponsorship.markup |> page |> toUnstyled ]
            }

        NotFound ->
            { title = "Elm in the Spring"
            , body = [ toUnstyled <| text "whoops, page not found" ]
            }



-- Section


type Section
    = Details
    | Speakers
    | Sponsors


titleOf : Section -> String
titleOf section =
    case section of
        Details ->
            "Details"

        Speakers ->
            "Speakers"

        Sponsors ->
            "Sponsors"


idOf : Section -> String
idOf =
    titleOf >> String.toLower


contentFor : Section -> Model -> Html Msg
contentFor section model =
    case section of
        Details ->
            ticketContent model

        Speakers ->
            speakerContent model

        Sponsors ->
            sponsorContent


navbar : Html Msg
navbar =
    header [ css Styles.header.wrapper ]
        [ nav [ css Styles.header.top ]
            [ ul [ css Styles.header.links ]
                (List.map
                    headerJumpLink
                    [ Details
                    , Speakers
                    , Sponsors
                    ]
                )
            ]
        ]


headerJumpLink : Section -> Html Msg
headerJumpLink section =
    let
        ( label_, id_ ) =
            ( titleOf section, idOf section )
    in
    li [ css Styles.header.link ]
        [ button
            [ css Styles.link
            , onClick (JumpTo id_)
            ]
            [ text label_ ]
        ]


hero : Html Msg
hero =
    let
        content =
            div []
                [ h1 [ css [ display none ] ] [ logo ]
                , div
                    [ css Styles.hero.wrapper.base
                    , css Styles.hero.wrapper.desktop
                    , css [ Media.withMedia [ Media.only Media.screen [ Media.maxWidth (px 800) ] ] Styles.hero.wrapper.mobile ]
                    ]
                    [ div
                        [ css Styles.hero.grid.desktop
                        , css [ Media.withMedia [ Media.only Media.screen [ Media.maxWidth (px 800) ] ] Styles.hero.grid.mobile ]
                        ]
                        [ div
                            [ css Styles.hero.logoFlower.desktop
                            , css [ Media.withMedia [ Media.only Media.screen [ Media.maxWidth (px 800) ] ] Styles.hero.logoFlower.mobile ]
                            ]
                            [ img
                                [ src "/images/flower.svg"
                                ]
                                []
                            ]
                        , div [ css Styles.hero.logoText ]
                            [ img
                                [ src "/images/text.svg"
                                , css Styles.hero.logoFlower.image
                                , alt "Elm in the Spring 2019"
                                ]
                                []
                            ]
                        , div
                            [ css Styles.hero.textContent.base
                            , css [ Media.withMedia [ Media.only Media.screen [ Media.maxWidth (px 800) ] ] Styles.hero.textContent.mobile ]
                            ]
                            [ text "A day to learn, teach, and share about Elm!" ]
                        , div
                            [ css Styles.hero.buttonWrapper.desktop
                            , css [ Media.withMedia [ Media.only Media.screen [ Media.maxWidth (px 800) ] ] Styles.hero.buttonWrapper.mobile ]
                            ]
                            [ div [ css Styles.hero.buttons ]
                                [ div []
                                    [ Ui.btn button [ onClick (JumpTo (idOf Details)) ] [ text "Attend" ] ]
                                ]
                            ]
                        ]
                    ]
                ]
    in
    { baseFillStyle = Ui.fillStyle <| Ui.SolidFill Ui.hexValues.teal
    , afterShape = Ui.SectionBgShapeData (Ui.fillStyle <| Ui.FlowerFill Ui.hexValues.tealLight) "polygon(0 0, 44% 100%, 0% 100%)"
    , beforeShape = Ui.SectionBgShapeData (Ui.fillStyle <| Ui.LeafFill Ui.hexValues.green) "polygon(100% 68%, 100% 100%, 0% 100%)"
    }
        |> Ui.angledSection content


getTitle : Section -> Html Msg
getTitle section =
    case section of
        Details ->
            { textContent = "Details"
            , outlineColorString = Ui.hexValues.navy
            , fillColor = Ui.theme.tealLight
            , shadowColor = Ui.theme.greenLight
            }
                |> Ui.textOffsetShadow

        Speakers ->
            { textContent = "Speakers"
            , outlineColorString = Ui.hexValues.navy
            , shadowColor = Ui.theme.greenLight
            }
                |> Ui.textOffsetStroke

        Sponsors ->
            { textContent = "Sponsors"
            , outlineColorString = Ui.hexValues.tealLight
            , fillColor = Ui.theme.greenLight
            , shadowColor = Ui.theme.tealLight
            }
                |> Ui.textOffsetShadow


pageSection : Section -> Maybe (Html Msg) -> Model -> Html Msg
pageSection section_ extra model =
    let
        title =
            titleOf section_

        id_ =
            idOf section_

        innerContent =
            contentFor section_ model

        isLeftSide =
            section_ /= Speakers

        content =
            div [ id id_ ]
                [ section
                    [ css Styles.pageSection.top, css [ position relative ] ]
                    [ div
                        [ css Styles.pageSection.container ]
                        [ h3 [ css Styles.pageSection.title ] [ getTitle section_ ] ]
                    , Maybe.withDefault (Html.Styled.text "") extra
                    , div [ css (Styles.pageSection.contentWrapper isLeftSide) ]
                        [ div [ Attr.class "blah", css Styles.pageSection.container ]
                            [ div [ css (Styles.pageSection.content isLeftSide) ]
                                [ innerContent
                                ]
                            ]
                        ]
                    ]
                ]
    in
    case section_ of
        Details ->
            { baseFillStyle = Ui.fillStyle <| Ui.LeafFill Ui.hexValues.green
            , beforeShape = Ui.SectionBgShapeData (Ui.fillStyle <| Ui.LeafFill Ui.hexValues.green) "polygon(80% 0, 100% 40%, 0 84%, 0% 0%)"
            , afterShape = Ui.SectionBgShapeData (Ui.fillStyle <| Ui.SolidFill Ui.hexValues.teal) "polygon(100% 100%, 0 100%, 0 75%)"
            }
                |> Ui.angledSection content

        _ ->
            { baseFillStyle = Ui.fillStyle <| Ui.SolidFill Ui.hexValues.teal
            , beforeShape = Ui.SectionBgShapeData (Ui.fillStyle <| Ui.SolidFill Ui.hexValues.teal) "polygon(80% 0, 100% 40%, 0 84%, 0% 0%)"
            , afterShape = Ui.SectionBgShapeData (Ui.fillStyle <| Ui.SolidFill Ui.hexValues.teal) "polygon(100% 100%, 0 100%, 0 75%)"
            }
                |> Ui.angledSection content



---------------------------------------------------------------------
-- TICKETS
---------------------------------------------------------------------


ticketContent : Model -> Html Msg
ticketContent model =
    div []
        [ h4 [] [ text "All Elm, all day!" ]
        , p []
            [ strong [] [ text "Elm in the Spring" ]
            , text " is a single-track, single-day conference for developers who love Elm. Whether you’re an Elm expert scaling up your production app or you're just starting out with your first Elm project, join us for a great day of learning, teaching, and community!"
            , p []
                [ text "Elm in the Spring 2019 will take place on "
                , strong [] [ text "Friday, April 26th" ]
                , text " at the "
                , a [ href "https://maps.google.com/?q=Newberry+Library+Chicago", target "_blank" ] [ text "Newberry Library" ]
                , text " in Chicago."
                ]
            ]
        , p [ css [ textAlign center ] ]
            [ Ui.btn a
                [ href "https://ti.to/elm-in-the-spring/chicago-2019"
                , Attr.target "_blank"
                ]
                [ text "Get your Tickets!" ]
            ]
        , p [ css [ marginTop (rem 1.9) ] ]
            [ text "All attendees are expected to observe the conference "
            , a [ Attr.href "http://confcodeofconduct.com/", Attr.target "blank" ] [ text "Code of Conduct." ]
            ]
        , br [] []
        , h4 [] [ text "Stay in touch" ]
        , p [] [ text "For conference updates, join our mailing list. No spam. Ever." ]
        , form
            [ Attr.name "mailing-list"
            , Attr.method "POST"
            , Attr.id "mailing-list"
            , Attr.target "_blank"
            , Attr.action "https://elminthespring.us19.list-manage.com/subscribe/post?u=7f1c2d8a3cd0f3008803845ad&amp;id=0a8d03f3de"
            , css Styles.contactForm
            ]
            [ Ui.hide input
                [ Attr.type_ "text"
                , Attr.name "name"
                , Attr.id "b_7f1c2d8a3cd0f3008803845ad_0a8d03f3de" -- real people should not fill this in and expect good things - do not remove this or risk form bot signups
                , onInput (UpdateField Name)
                , Attr.value model.name
                , Attr.tabindex -1
                ]
                []
            , input
                [ Attr.type_ "email"
                , Attr.name "EMAIL"
                , Attr.id "mce-EMAIL"
                , Attr.value model.email
                , Attr.placeholder "email address"
                , Attr.attribute "aria-label" "Email address"
                , css Styles.input
                , onInput (UpdateField Email)
                ]
                []
            , input
                [ Attr.type_ "submit"
                , onClick SubmitForm
                , css Styles.buttonInput
                , Attr.value "Sign Up"
                ]
                []
            ]
        , p []
            [ text "Or, follow us at"
            , a
                [ css [ color Ui.theme.green, marginLeft (rem 1) ]
                , href "https://twitter.com/ElmInTheSpring"
                , target "_blank"
                ]
                [ text "@elminthespring"
                ]
            , text " on Twitter."
            ]
        ]



---------------------------------------------------------------------
-- SPEAKERS
---------------------------------------------------------------------


speakerContent : Model -> Html Msg
speakerContent model =
    div [] (List.map speaker model.speakers)


speaker : Speaker -> Html msg
speaker { name, talkTitle, talkSubtitle, headshotSrc, talkAbstract, bio, social } =
    div [ Attr.class "speaker-grid-container", css [ paddingLeft (rem 3), paddingTop (rem 2) ] ]
        [ div
            [ Attr.class "Speaker-Headshot", css [ boxShadow3 (px -12) (px 12) Ui.theme.greenLight, border3 (px 7) solid Ui.theme.tealLight ] ]
            [ img [ css [ width (pct 100) ], src headshotSrc, alt name ] [] ]
        , div
            [ Attr.class "Speaker-Talk" ]
            [ h5 [ css [ fontSize (rem 1.5), margin2 (px 10) zero ] ] [ text talkTitle ]
            , h6 [ css [ fontSize (rem 1), margin2 (px 10) zero, fontWeight (int 300) ] ] [ text talkSubtitle ]
            ]
        , div
            [ Attr.class "Speaker-Name-Social", css [ color Ui.theme.greenLight ] ]
            [ h4 [ css [ fontSize (rem 2), lineHeight (num 1.2), fontWeight (int 400) ] ] [ text name ]
            , div [ css [ displayFlex, flexDirection row ] ] (List.map speakerSocialLink social)
            ]
        ]


speakerSocialLink : Speaker.Social -> Html msg
speakerSocialLink { network, src } =
    a
        [ href src
        , target "_blank"
        , css
            [ fontSize (rem 1.3)
            , padding (rem 0.3)
            , display block
            , marginRight (px 5)
            , hover [ color Ui.theme.green ]
            , marginBottom (px 10)
            , position relative
            , bottom (px 10)
            ]
        ]
        [ i [ Attr.class (getSocialIconClass network) ] [] ]


getSocialIconClass : Speaker.SocialNetwork -> String
getSocialIconClass network =
    case network of
        Speaker.Website ->
            "fas fa-globe"

        Speaker.Twitter ->
            "fab fa-twitter"

        Speaker.Github ->
            "fab fa-github"



---------------------------------------------------------------------
-- SPONSORS
---------------------------------------------------------------------


sponsorContent : Html Msg
sponsorContent =
    div []
        [ h4 [] [ text "Support the community" ]
        , p []
            [ text "You or your company can become a sponsor for Elm in the Spring 2019." ]
        , p []
            [ text "For more info, check out "
            , a [ href "/sponsorship/" ] [ text "becoming a sponsor" ]
            , text "."
            ]
        ]


sponsorLogos : Html msg
sponsorLogos =
    div [ css [ displayFlex, flexWrap wrap, alignItems baseline, justifyContent center ] ]
        [ sponsor "eSpark Learning" "/images/sponsors/espark-logo.svg" 200
        , sponsor "Hubtran" "/images/sponsors/hubtran-logo.svg" 200
        , sponsor "Spantree" "/images/sponsors/spantree-logo.svg" 200
        , sponsor "NoRedInk" "/images/sponsors/no-red-ink-logo.svg" 200
        ]


sponsor : String -> String -> Float -> Html msg
sponsor name src maxWidthPx =
    div
        [ css [ maxWidth (px maxWidthPx), margin (rem 1) ]
        ]
        [ img
            [ Attr.src src
            , Attr.title name
            , Attr.alt name
            , css [ width (pct 100) ]
            , css [ Media.withMedia [ Media.only Media.screen [ Media.minWidth (px 737) ] ] [ height (px 88) ] ]
            , css [ Media.withMedia [ Media.only Media.screen [ Media.maxWidth (px 736) ] ] [ height (px 60) ] ]
            ]
            []
        ]


logo : Html Msg
logo =
    span []
        [ strong [ css Styles.logo.bigText ] [ text "ELM" ]
        , span [ css Styles.logo.smallText ] [ text " in the " ]
        , br [] []
        , strong [ css Styles.logo.bigText ] [ text "SPRING" ]
        ]
