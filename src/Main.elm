module Main exposing (main)

import Browser
import Html exposing (Html, div, h1, p, span, text, textarea)
import Html.Attributes exposing (class, rows, value)
import Html.Events exposing (onInput)
import List exposing (drop, head)


type alias Model =
    { body : String }


template_OOPD : String
template_OOPD =
    """# Name:
NHI:

# History and exam

# PMHx

# Meds

# Allergy

# SHx
_HD
Work:

# Smoker

# Impression / X-ray

# Plan
"""


initModel : Model
initModel =
    { body = template_OOPD }


view : Model -> Html Msg
view model =
    let
        sections =
            String.split "#" model.body
    in
    div [ class "columns" ]
        [ div [ class "column is-half" ]
            [ textarea
                [ value model.body
                , onInput UpdateBody
                , class "textarea"
                , rows 50
                ]
                []
            ]
        , div [ class "column is-half" ]
            (List.map viewSection sections)
        ]


viewSection : String -> Html Msg
viewSection section =
    let
        trimmed_section s =
            s
                |> String.trim
    in
    case section of
        "" ->
            span [] []

        _ ->
            div [ class "box" ]
                [ p [ class "has-text-left" ] [ viewSectionTitle (trimmed_section section) ] ]


viewSectionTitle : String -> Html Msg
viewSectionTitle section =
    let
        lines =
            String.lines section

        first =
            head lines

        rest =
            drop 1 lines
    in
    case first of
        Just title ->
            div []
                [ h1 [ class "title is-5" ] [ text title ]
                , p [] [ text (String.join "\n" rest) ]
                ]

        Nothing ->
            span [] []


type Msg
    = UpdateBody String


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
