module Main exposing (main)

import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Html exposing (Html)


type alias Model =
    { body : String }


type Msg
    = UpdateBody String


initModel : Model
initModel =
    { body = "" }


channelPanel : List String -> String -> Element msg
channelPanel channels activeChannel =
    let
        activeChannelAttrs =
            [ Background.color (rgb255 117 179 201), Font.bold ]

        channelAttrs =
            [ width fill, paddingXY 15 5 ]

        channelEl channel =
            el
                (if channel == activeChannel then
                    activeChannelAttrs ++ channelAttrs

                 else
                    channelAttrs
                )
                (text ("# " ++ channel))
    in
    column
        [ height fill
        , width (fillPortion 1)
        , Background.color (rgb255 92 99 118)
        , Font.color (rgb255 255 255 255)
        , paddingXY 0 10
        ]
        (List.map channelEl channels)


chatPanel : Element msg
chatPanel =
    column
        [ height fill, width (fillPortion 5) ]
        [ text "chat" ]


view : Model -> Html Msg
view model =
    layout []
        (row [ height fill, width fill ]
            [ channelPanel [ "hello", "world" ] "hello"
            , chatPanel
            ]
        )


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateBody newBody ->
            { model | body = newBody }


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initModel
        , view = view
        , update = update
        }
