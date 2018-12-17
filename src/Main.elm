port module Main exposing (main)

import Browser
import Css exposing (..)
import Css.Global exposing (body, global, html)
import Css.Media as Media
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes as Attr exposing (alt, css, href, id, src, target)
import Html.Styled.Events exposing (onClick, onInput)
import Styles
import Svg.Styled as Svg
import Svg.Styled.Attributes as SvgAttr
import Ui



-- MAIN


type alias Model =
    { name : String
    , email : String
    }


main : Program () Model Msg
main =
    Browser.element
        { init = always ( Model "" "", Cmd.none )
        , update = update
        , view = view >> toUnstyled
        , subscriptions = always Sub.none
        }



-- UPDATE


type Field
    = Name
    | Email


type Msg
    = JumpTo String
    | UpdateField Field String
    | ClearForm


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

        ClearForm ->
            ( { model | name = "", email = "" }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div [ css Styles.view ]
        [ Styles.global
        , navbar
        , hero
        , pageSection Tickets model
        , pageSection Speakers model
        , pageSection Sponsors model
        , siteFooter
        ]



-- Section


type Section
    = Tickets
    | Speakers
    | Sponsors


titleOf : Section -> String
titleOf section =
    case section of
        Tickets ->
            "Tickets"

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
        Tickets ->
            ticketContent model

        Speakers ->
            speakerContent

        Sponsors ->
            sponsorContent


navbar : Html Msg
navbar =
    header [ css Styles.header.wrapper ]
        [ nav [ css Styles.header.top ]
            [ ul [ css Styles.header.links ]
                (List.map
                    headerJumpLink
                    [ Tickets
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
                            [ text "Let's all get together in Chicago and spend the day talking/teaching/learning all about Elm!" ]
                        , div
                            [ css Styles.hero.buttonWrapper.desktop
                            , css [ Media.withMedia [ Media.only Media.screen [ Media.maxWidth (px 800) ] ] Styles.hero.buttonWrapper.mobile ]
                            ]
                            [ div [ css Styles.hero.buttons ]
                                [ div []
                                    [ Ui.btn button [ onClick (JumpTo (idOf Tickets)) ] [ text "Attend" ] ]
                                , div [ css [ marginLeft (px 24) ] ]
                                    [ Ui.btn button [ onClick (JumpTo (idOf Speakers)) ] [ text "Speak" ] ]
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
        Tickets ->
            { textContent = "Tickets"
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


pageSection : Section -> Model -> Html Msg
pageSection section_ model =
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
                [ section [ css Styles.pageSection.top, css [ position relative ] ]
                    [ div [ css Styles.pageSection.container ]
                        [ h3 [ css Styles.pageSection.title ] [ getTitle section_ ]
                        ]
                    , div [ css (Styles.pageSection.contentWrapper isLeftSide) ]
                        [ div [ css Styles.pageSection.container ]
                            [ div [ css (Styles.pageSection.content isLeftSide) ]
                                [ innerContent
                                ]
                            ]
                        ]
                    ]
                ]
    in
    case section_ of
        Tickets ->
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


ticketContent : Model -> Html Msg
ticketContent model =
    div []
        [ h4 [] [ text "Interested in attending?" ]
        , p []
            [ text "Elm in the Spring 2019 will take place on "
            , strong [] [ text "Friday, April 26th" ]
            , text " at the "
            , a [ href "https://maps.google.com/?q=Newberry+Library+Chicago", target "_blank" ] [ text "Newberry Library" ]
            , text " in Chicago. We'd love to see you there!"
            ]
        , p [ css [ textAlign center ] ]
            [ Ui.btn a
                [ href "https://ti.to/elm-in-the-spring/chicago-2019"
                , Attr.target "_blank"
                ]
                [ text "Get your tickets" ]
            ]
        , p []
            [ text "All attendees are expected to observe the conference "
            , a [ Attr.href "http://confcodeofconduct.com/", Attr.target "blank" ] [ text "Code of Conduct." ]
            ]
        , br [] []
        , h4 [] [ text "Stay in touch" ]
        , p [] [ text "For conference updates, join our mailing list. No spam. Ever." ]
        , form
            [ Attr.name "mailing-list"
            , Attr.method "POST"
            , Attr.target "_blank"
            , Attr.action "https://elminthespring.us19.list-manage.com/subscribe/post?u=7f1c2d8a3cd0f3008803845ad&amp;id=0a8d03f3de"
            , css Styles.contactForm
            ]
            [ Ui.hide p
                []
                [ input
                    [ Attr.type_ "text"
                    , Attr.name "name"
                    , Attr.id "b_7f1c2d8a3cd0f3008803845ad_0a8d03f3de" -- real people should not fill this in and expect good things - do not remove this or risk form bot signups
                    , onInput (UpdateField Name)
                    , Attr.value model.name
                    , Attr.tabindex -1
                    ]
                    []
                ]
            , p []
                [ input
                    [ Attr.type_ "email"
                    , Attr.name "EMAIL"
                    , Attr.id "mce-EMAIL"
                    , Attr.value model.email
                    , Attr.placeholder "email address"
                    , Attr.attribute "aria-label" "Email address"
                    , css Styles.input
                    , css
                        [ position relative, bottom (px 4), marginRight (rem 2.5) ]
                    , onInput (UpdateField Email)
                    ]
                    []
                , Ui.btn input
                    [ Attr.type_ "submit"
                    , onClick ClearForm
                    , css [ marginTop (rem 0.5) ]
                    , Attr.value "Sign Up"
                    ]
                    []
                ]
            ]
        , p []
            [ text "Or, follow us at"
            , a
                [ css [ color Ui.theme.green, marginLeft (rem 1) ]
                , href "https://twitter.com/ElmInTheSpring"
                , target "_blank"
                ]
                [ --i [ Attr.class "fa fa-twitter-square" ] [],
                  text "@elminthespring"
                ]
            , text " on Twitter."
            ]
        ]


speakerContent : Html Msg
speakerContent =
    div []
        [ h4 [] [ text "Become a speaker" ]
        , p []
            [ text "Have a great idea you want to share with the Elm community?"
            ]
        , p [ css [ textAlign center ] ]
            [ Ui.btn a
                [ href "https://www.papercall.io/elm-in-the-spring-2019"
                , Attr.target "_blank"
                ]
                [ text "Submit your talk" ]
            ]
        , p []
            [ text "Never spoken at a conference before? We're reserving two spots for first-time speakers!"
            ]
        , br [] []
        , h4 [] [ text "Speaker Lineup" ]
        , div [ css [ marginTop (rem 2) ] ]
            [ speaker
                "Richard Feldman"
                [ ( "twitter", "https://twitter.com/rtfeldman" )
                , ( "github", "https://github.com/rtfeldman" )
                ]
                "/images/speakers/richard-feldman.jpeg"
                []
            , speaker
                "You??"
                []
                "/images/speakers/you.jpeg"
                []
            ]
        ]


speaker : String -> List ( String, String ) -> String -> List (Html msg) -> Html msg
speaker name socialLinks image bio =
    div [ css [ marginTop (rem 2) ] ]
        [ div [ css [ displayFlex, alignItems center ] ]
            [ div [ css [ boxShadow3 (px 5) (px 5) Ui.theme.pink ] ]
                [ img [ css [ width (px 128) ], src image, alt name ] [] ]
            , div
                [ css
                    [ flex (num 1)
                    , paddingLeft (rem 2)
                    ]
                ]
                [ h5 [ css [ fontSize (rem 2) ] ] [ text name ]
                , if List.isEmpty socialLinks then
                    text ""

                  else
                    p [ css [ fontSize (rem 1.75), marginTop (rem 1), marginLeft (rem -1) ] ]
                        (List.map speakerSocialLink socialLinks)
                ]
            ]
        , div [ css [ marginTop (rem 1) ] ] bio
        ]


speakerSocialLink : ( String, String ) -> Html msg
speakerSocialLink ( icon, url ) =
    a [ href url, target "_blank", css [ paddingLeft (rem 1) ] ]
        [ i [ Attr.class ("fa fa-" ++ icon) ] [] ]


sponsorContent : Html Msg
sponsorContent =
    div []
        [ h4 [] [ text "Support the community" ]
        , p []
            [ text "You or your company can become a sponsor for Elm in the Spring 2019." ]
        , p []
            [ text "For more info, email "
            , a [ href "mailto:hello@elminthespring.org" ] [ text "hello@elminthespring.org" ]
            ]
        ]


siteFooter : Html Msg
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
                        [ i [ Attr.class "fa fa-twitter-square" ] []
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
            ]
        ]


logo : Html Msg
logo =
    span []
        [ strong [ css Styles.logo.bigText ] [ text "ELM" ]
        , span [ css Styles.logo.smallText ] [ text " in the " ]
        , br [] []
        , strong [ css Styles.logo.bigText ] [ text "SPRING" ]
        ]
