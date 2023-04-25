module Main exposing (main)

import Browser
import Html exposing (Html, div, h1, text)
import Html.Attributes exposing (class)
import PortedComponent exposing (SidebarStatus(..))
import Process
import Task



-- MODEL


type alias Model =
    { sideNavStatus : SidebarStatus
    }



-- INITIAL MODEL


initialModel : Model
initialModel =
    { sideNavStatus = Open
    }



-- MSG


type Msg
    = NoOp
    | ToggleSideNav
    | FinishSideNavAnimation



-- INIT


init : () -> ( Model, Cmd Msg )
init _ =
    ( initialModel, Cmd.none )



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case Debug.log "MSG" msg of
        NoOp ->
            ( model, Cmd.none )

        ToggleSideNav ->
            case model.sideNavStatus of
                Open ->
                    ( { model | sideNavStatus = Closing }
                      -- wait 300 ms then call FinishSideNavAnimation
                    , Task.perform (\_ -> FinishSideNavAnimation) (Process.sleep 300)
                    )

                Closed ->
                    ( { model | sideNavStatus = Opening }
                      -- wait 300 ms then call FinishSideNavAnimation
                    , Task.perform (\_ -> FinishSideNavAnimation) (Process.sleep 300)
                    )

                _ ->
                    ( model, Cmd.none )

        FinishSideNavAnimation ->
            case model.sideNavStatus of
                Opening ->
                    ( { model | sideNavStatus = Open }, Cmd.none )

                Closing ->
                    ( { model | sideNavStatus = Closed }, Cmd.none )

                _ ->
                    ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    PortedComponent.component model.sideNavStatus ToggleSideNav



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
