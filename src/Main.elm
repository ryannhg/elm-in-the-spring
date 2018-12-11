port module Main exposing (main)

import Browser
import Css exposing (..)
import Css.Global exposing (body, global, html)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes as Attr exposing (alt, css, href, id, src, target)
import Html.Styled.Events exposing (onClick, onInput, onSubmit)
import Svg.Styled as Svg
import Svg.Styled.Attributes as SvgAttr
import Ui



-- STYLES


styles =
    { html =
        [ height (pct 100)
        ]
    , body =
        [ height (pct 100)
        , margin zero
        , fontFamilies [ "Biko", "sans-serif" ]
        , backgroundColor Ui.theme.teal
        , color Ui.theme.navy
        ]
    , view = []
    , header =
        { wrapper =
            [ position absolute
            , top zero
            , zIndex (int 10)
            , width (pct 100)
            ]
        , top =
            [ fontSize (rem 1.5)
            , padding2 (rem 2) (rem 1.5)
            ]
        , links =
            [ displayFlex
            , maxWidth (px 960)
            , margin2 zero auto
            , width (pct 100)
            , justifyContent center
            , listStyle none
            , padding zero
            ]
        , link =
            [ marginLeft (rem 1.5)
            , firstChild [ marginLeft zero ]
            ]
        }
    , hidden =
        [ height zero
        , width zero
        , margin zero
        , overflow hidden
        ]
    , link =
        [ backgroundColor transparent
        , color inherit
        , fontFamily inherit
        , fontSize inherit
        , padding zero
        , border zero
        , cursor pointer
        , opacity (num 0.75)
        , hover [ opacity (num 1) ]
        ]
    , hero =
        { top =
            [ padding2 (rem 8) zero
            , displayFlex
            , alignItems center
            , flexDirection column
            ]
        , wrapper =
            [ displayFlex
            , justifyContent center
            , width (pct 100)
            , maxWidth (px 960)
            , alignItems center
            , flexWrap wrap
            ]
        , topRow = [ width (pct 100), displayFlex ] -- flower and logo (separate)
        , bottomRow = [ width (pct 50) ]
        , leftSide =
            [ width (pct 30)
            ]
        , rightSide =
            [ width (pct 50) ]

        , buttons =
            [ displayFlex
            , width (pct 50)
            , alignSelf center
            , justifyContent spaceAround
            , marginTop (rem 1.5)
            ]
        , flowerImage = [ margin (px 20) ]
        -- , logoText =
        --     [ width (pct 50) ]
        -- , introText =
        --     []
        -- , image =
        --     [ width (pct 30)

            -- , maxWidth (pct 100)
            -- , margin2 zero auto
            -- , padding (rem 1)
            -- , boxSizing borderBox
            -- ]
        , container =
            [ color Ui.theme.navy
            , padding2 (rem 2.5) (rem 2)
            , maxWidth (pct 100)
            , width (px 640)
            , fontSize (px 20)
            , lineHeight (num 1.4)
            , marginTop (rem 1.5)
            , textAlign center
            , zIndex (int 1)
            ]
        }

    , contactForm =
        []
    , input =
        [ backgroundColor Ui.theme.pinkLightest
        , fontSize inherit
        , fontFamily inherit
        , border3 (px 2) solid Ui.theme.teal
        , padding2 (rem 0.6) (rem 1)
        ]
    , pageSection =
        { top =
            [ padding2 (rem 4) zero
            , color Ui.theme.greenLight
            ]
        , container =
            [ margin2 zero auto
            , maxWidth (px 960)
            , width (pct 100)
            , padding2 zero (rem 3)
            ]
        , title =
            [ fontSize (rem 5)
            , textTransform uppercase
            , letterSpacing (px 4)
            , textAlign center
            ]
        , contentWrapper =
            \isLeftSide ->
                [ position relative
                , before
                    [ property "content" "''"
                    , position absolute
                    , top zero
                    , if isLeftSide then
                        left zero

                      else
                        left (pct 50)
                    , if isLeftSide then
                        right (pct 50)

                      else
                        right zero
                    , bottom zero
                    , backgroundColor Ui.theme.navy
                    , zIndex (int -1)
                    ]
                ]
        , content =
            \isLeftSide ->
                [ maxWidth (pct 100)
                , margin2 zero auto
                , marginTop (rem 2)
                , fontSize (px 20)
                , lineHeight (num 1.4)
                , padding2 (rem 3) (rem 2)
                , if isLeftSide then
                    paddingLeft zero

                  else
                    paddingLeft (rem 2)
                , backgroundColor Ui.theme.navy
                , color Ui.theme.teal
                ]
        }
    , logo =
        { h1 =
            [ fontSize (rem 6)
            , lineHeight (num 0.9)
            , whiteSpace noWrap
            , margin zero
            ]
        , h2 =
            [ backgroundColor Ui.theme.green
            , color Ui.theme.teal
            , padding (rem 2)
            , textTransform uppercase
            ]
        , bigText =
            [ fontSize (Css.em 1)
            , letterSpacing (Css.em (1 / 16))
            ]
        , smallText =
            [ fontSize (Css.em (5 / 8))
            ]
        }
    , footer =
        { top =
            [ padding (rem 1.5)
            , color Ui.theme.green
            ]
        , container =
            [ width (pct 100)
            , maxWidth (px 960)
            , margin2 zero auto
            , displayFlex
            , justifyContent spaceBetween
            ]
        , left = []
        , right = [ color Ui.theme.greenLight ]
        }
    }


globalStyles : Html Msg
globalStyles =
    global
        [ html styles.html
        , body styles.body
        , Css.Global.selector "body *" [ boxSizing borderBox, outline none ]
        , Css.Global.p
            [ fontSize (rem 1.65)
            , margin zero
            , firstChild [ marginTop zero ]
            , marginTop (rem 1.5)
            , lineHeight (num 1.4)
            ]
        , Css.Global.h4
            [ fontSize (rem 2)
            , lineHeight (num 1)
            , margin zero
            , firstChild [ marginTop zero ]
            , marginTop (rem 1.5)
            ]
        , Css.Global.h5
            [ fontSize (rem 1.75)
            , lineHeight (num 1)
            , margin zero
            , firstChild [ marginTop zero ]
            , marginTop (rem 1.5)
            ]
        , Css.Global.form [ margin zero ]
        ]



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
    | SubmitForm


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
            ( Model "" ""
            , if String.isEmpty model.name && not (String.isEmpty model.email) then
                outgoing ( "SUBMIT_FORM", model.email )

              else
                Cmd.none
            )



-- VIEW


view : Model -> Html Msg
view _ =
    div [ css styles.view ]
        [ globalStyles
        , navbar
        , hero
        , pageSection Tickets

        -- , speakerCta
        , pageSection Speakers
        , pageSection Sponsors
        , siteFooter
        ]


speakerCta : Html Msg
speakerCta =
    div [ css [ backgroundColor Ui.theme.green ] ]
        [ div
            [ css
                [ maxWidth (pct 100)
                , width (px 360)
                , margin2 zero auto
                , padding2 (rem 2) (rem 1)
                , border3 (px 3) solid Ui.theme.teal
                , backgroundColor Ui.theme.pink
                , color Ui.theme.navy
                , textAlign center
                ]
            ]
            [ p [] [ text "Interested in speaking?" ]
            , p [ css [ marginTop zero ] ]
                [ strong []
                    [ a
                        [ href "#proposal-link"
                        , Attr.target "_blank"
                        , css [ color Ui.theme.navy ]
                        ]
                        [ text "Submit" ]
                    , text " a proposal!"
                    ]
                ]
            ]
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


contentFor : Section -> Html Msg
contentFor section =
    case section of
        Tickets ->
            ticketContent

        Speakers ->
            speakerContent

        Sponsors ->
            sponsorContent


navbar : Html Msg
navbar =
    header [ css styles.header.wrapper ]
        [ nav [ css styles.header.top ]
            [ ul [ css styles.header.links ]
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
    li [ css styles.header.link ]
        [ button
            [ css styles.link
            , onClick (JumpTo id_)
            ]
            [ text label_ ]
        ]


hero : Html Msg
hero =
    let
        content =
            div [ css styles.hero.top ]
                [ h1 [ css [ display none ] ] [ logo ]
                , div
                    [ css styles.hero.wrapper ]
                    [ div [ css styles.hero.leftSide ]
                        [ img
                            [ css styles.hero.flowerImage
                            , src "/images/flower.svg"
                            , alt "Elm in the Spring 2019"
                            ]
                            []
                        ]
                    , div [ css styles.hero.rightSide ]
                        [ img
                            [ src "/images/text.svg"
                            , alt "Elm in the Spring 2019"
                            ]
                            []
                        , p [] [ text "Let's all get together in Chicago and spend the day talking/teaching/learning all about Elm!" ]
                        ]
                    , div [ css styles.hero.buttons ]
                        [ Ui.btn button [ onClick (JumpTo (idOf Tickets)) ] [ text "Attend" ]
                        , Ui.btn button [ onClick (JumpTo (idOf Speakers)) ] [ text "Speak" ]
                        ]
                    ]

                -- , img
                --     [ css styles.hero.image
                --     , src "/images/flower+text.svg"
                --     , alt "Elm in the Spring 2019"
                --     ]
                --     []
                -- , div [ css styles.hero.container ]
                --     [ p []
                --         [ text "Let's all get together in Chicago and spend the day talking/teaching/learning all about Elm!"
                --         ]
                --     ]
                ]
    in
    { baseFillStyle = Ui.fillStyle <| Ui.SolidFill Ui.hexValues.teal
    , afterShape = Ui.SectionBgShapeData (Ui.fillStyle <| Ui.FlowerFill Ui.hexValues.tealLight) "polygon(0 0, 44% 100%, 0% 100%)"
    , beforeShape = Ui.SectionBgShapeData (Ui.fillStyle <| Ui.LeafFill Ui.hexValues.green) "polygon(100% 68%, 100% 100%, 0% 100%)"
    }
        |> Ui.angledSection content


getSectionBg : Section -> { baseFillStyle : Css.Style, beforeShape : Ui.SectionBgShapeData, afterShape : Ui.SectionBgShapeData }
getSectionBg section_ =
    case section_ of
        Tickets ->
            { baseFillStyle = Ui.fillStyle <| Ui.LeafFill Ui.hexValues.green
            , beforeShape = Ui.SectionBgShapeData (Ui.fillStyle <| Ui.LeafFill Ui.hexValues.green) "polygon(80% 0, 100% 40%, 0 84%, 0% 0%)"
            , afterShape = Ui.SectionBgShapeData (Ui.fillStyle <| Ui.SolidFill Ui.hexValues.teal) "polygon(100% 100%, 0 100%, 0 75%)"
            }

        _ ->
            { baseFillStyle = Ui.fillStyle <| Ui.SolidFill Ui.hexValues.teal
            , beforeShape = Ui.SectionBgShapeData (Ui.fillStyle <| Ui.SolidFill Ui.hexValues.teal) "polygon(80% 0, 100% 40%, 0 84%, 0% 0%)"
            , afterShape = Ui.SectionBgShapeData (Ui.fillStyle <| Ui.SolidFill Ui.hexValues.teal) "polygon(100% 100%, 0 100%, 0 75%)"
            }


getTitle : Section -> Html Msg
getTitle section =
    case section of
        Tickets ->
            { textContent = "Tickets", outlineColorString = Ui.hexValues.navy, fillColor = Ui.theme.tealLight, shadowColor = Ui.theme.greenLight }
                |> Ui.textOffsetShadow

        Speakers ->
            { textContent = "Speakers", outlineColorString = Ui.hexValues.navy, shadowColor = Ui.theme.greenLight }
                |> Ui.textOffsetStroke

        Sponsors ->
            { textContent = "Sponsors", outlineColorString = Ui.hexValues.tealLight, fillColor = Ui.theme.greenLight, shadowColor = Ui.theme.tealLight }
                |> Ui.textOffsetShadow


pageSection : Section -> Html Msg
pageSection section_ =
    let
        title =
            titleOf section_

        id_ =
            idOf section_

        innerContent =
            contentFor section_

        isLeftSide =
            section_ /= Speakers

        content =
            div [ id id_ ]
                [ section [ css styles.pageSection.top, css [ position relative ] ]
                    [ div [ css styles.pageSection.container ]
                        [ h3 [ css styles.pageSection.title ] [ getTitle section_ ]
                        ]
                    , div [ css (styles.pageSection.contentWrapper isLeftSide) ]
                        [ div [ css styles.pageSection.container ]
                            [ div [ css (styles.pageSection.content isLeftSide) ]
                                [ innerContent
                                ]
                            ]
                        ]
                    ]
                ]
    in
    getSectionBg section_
        |> Ui.angledSection content


ticketContent : Html Msg
ticketContent =
    div []
        [ h4 [] [ text "Interested in attending?" ]
        , p []
            [ text "Elm in the Spring 2019 will take place on "
            , strong [] [ text "Friday, April 26th" ]
            , text " at the "
            , a [ href "https://maps.google.com/?q=Newberry+Library+Chicago", target "_blank" ] [ text "Newberry Library" ]
            , text ". We'd love to see you there!"
            ]
        , p [ css [ textAlign center ] ]
            [ Ui.btn a
                [ href "https://ti.to/elm-in-the-spring/chicago-2019"
                , Attr.target "_blank"
                ]
                [ text "Get your tickets" ]
            ]
        , br [] []
        , h4 [] [ text "Stay in touch" ]
        , p [] [ text "For conference updates, join our mailing list." ]
        , p [] [ text "No spam. Ever." ]
        , form
            [ Attr.name "mailing-list"
            , Attr.method "POST"
            , Attr.attribute "data-netlify-honeypot" "name"
            , Attr.attribute "data-netlify" "true"
            , css styles.contactForm
            , onSubmit SubmitForm
            ]
            [ p [ css styles.hidden ]
                [ input
                    [ Attr.type_ "text"
                    , Attr.name "name"
                    , Attr.attribute "aria-label"
                        "Do not fill out this field, it's for spam bots."
                    , onInput (UpdateField Name)
                    ]
                    []
                ]
            , p []
                [ input
                    [ Attr.type_ "email"
                    , Attr.name "email"
                    , Attr.placeholder "email address"
                    , Attr.attribute "aria-label" "Email address"
                    , css styles.input
                    , css
                        []
                    , onInput (UpdateField Email)
                    ]
                    []
                ]
            ]
        ]


speakerContent : Html Msg
speakerContent =
    div []
        [ h4 [] [ text "Become a speaker" ]
        , p []
            [ text "Have something to share with the Elm community? Please, let us know!"
            ]
        , p [ css [ textAlign center ] ]
            [ Ui.btn a
                [ href "#cfp-link-goes-here"
                , Attr.target "_blank"
                ]
                [ text "Submit your talk" ]
            ]
        , br [] []
        , h4 [] [ text "Speaker Lineup" ]
        , div [ css [ marginTop (rem 2) ] ]
            [ speaker
                "Richard Feldman"
                [ ( "twitter", "https://twitter.com/rtfeldman" )
                , ( "github", "https://github.com/rtfeldman" )
                ]
                "/images/speakers/richard-feldman.jpg"
                []
            ]
        ]


speaker : String -> List ( String, String ) -> String -> List (Html msg) -> Html msg
speaker name socialLinks image bio =
    div []
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
        [ css styles.footer.top
        , css
            [ lineHeight (num 1.4)
            , paddingTop (rem 4)
            ]
        ]
        [ div [ css styles.footer.container ]
            [ div [ css (styles.footer.left ++ [ displayFlex, alignItems center ]) ]
                [ text "© Elm in the Spring 2019"
                , div [ css [ fontSize (rem 1.5) ] ]
                    [ a
                        [ css [ color Ui.theme.green, marginLeft (rem 1) ]
                        , href "https://twitter.com/ElmInTheSpring"
                        , target "_blank"
                        ]
                        [ i [ Attr.class "fa fa-twitter-square" ] []
                        ]
                    ]
                ]
            , a
                [ css styles.footer.right
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
        [ strong [ css styles.logo.bigText ] [ text "ELM" ]
        , span [ css styles.logo.smallText ] [ text " in the " ]
        , br [] []
        , strong [ css styles.logo.bigText ] [ text "SPRING" ]
        ]
