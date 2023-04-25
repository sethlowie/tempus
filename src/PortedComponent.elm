module PortedComponent exposing (SidebarStatus(..), component)

import Html exposing (Html, a, button, div, form, img, input, label, li, main_, nav, span, text, ul)
import Html.Attributes as Attr
import Html.Events exposing (onClick)
import Icons


type SidebarStatus
    = Open
    | Opening
    | Closed
    | Closing


component : SidebarStatus -> msg -> Html msg
component status toggle =
    div []
        [ mobileSidebar status toggle
        , desktopSidebar
        , div
            [ Attr.class "lg:pl-72"
            ]
            [ topBar
            , main_
                [ Attr.class "py-10"
                ]
                [ div
                    [ Attr.class "px-4 sm:px-6 lg:px-8"
                    ]
                    [{- Your content -}]
                ]
            ]
        ]



-- TOP BAR


topBar : Html msg
topBar =
    div
        [ Attr.class "sticky top-0 z-40 flex h-16 shrink-0 items-center gap-x-4 border-b border-gray-200 bg-white px-4 shadow-sm sm:gap-x-6 sm:px-6 lg:px-8"
        ]
        [ button
            [ Attr.type_ "button"
            , Attr.class "-m-2.5 p-2.5 text-gray-700 lg:hidden"
            ]
            [ span
                [ Attr.class "sr-only"
                ]
                [ text "Open sidebar" ]
            , Icons.menu
            ]
        , {- Separator -}
          div
            [ Attr.class "h-6 w-px bg-gray-200 lg:hidden"
            , Attr.attribute "aria-hidden" "true"
            ]
            []
        , div
            [ Attr.class "flex flex-1 gap-x-4 self-stretch lg:gap-x-6"
            ]
            [ form
                [ Attr.class "relative flex flex-1"
                , Attr.action "#"
                , Attr.method "GET"
                ]
                [ label
                    [ Attr.for "search-field"
                    , Attr.class "sr-only"
                    ]
                    [ text "Search" ]
                , Icons.search
                , input
                    [ Attr.id "search-field"
                    , Attr.class "block h-full w-full border-0 py-0 pl-8 pr-0 text-gray-900 placeholder:text-gray-400 focus:ring-0 sm:text-sm"
                    , Attr.placeholder "Search..."
                    , Attr.type_ "search"
                    , Attr.name "search"
                    ]
                    []
                ]
            , div
                [ Attr.class "flex items-center gap-x-4 lg:gap-x-6"
                ]
                [ button
                    [ Attr.type_ "button"
                    , Attr.class "-m-2.5 p-2.5 text-gray-400 hover:text-gray-500"
                    ]
                    [ span
                        [ Attr.class "sr-only"
                        ]
                        [ text "View notifications" ]
                    , Icons.bell
                    ]
                , {- Separator -}
                  div
                    [ Attr.class "hidden lg:block lg:h-6 lg:w-px lg:bg-gray-200"
                    , Attr.attribute "aria-hidden" "true"
                    ]
                    []
                , {- Profile dropdown -}
                  div
                    [ Attr.class "relative"
                    ]
                    [ button
                        [ Attr.type_ "button"
                        , Attr.class "-m-1.5 flex items-center p-1.5"
                        , Attr.id "user-menu-button"
                        , Attr.attribute "aria-expanded" "false"
                        , Attr.attribute "aria-haspopup" "true"
                        ]
                        [ span
                            [ Attr.class "sr-only"
                            ]
                            [ text "Open user menu" ]
                        , img
                            [ Attr.class "h-8 w-8 rounded-full bg-gray-50"
                            , Attr.src "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80"
                            , Attr.alt ""
                            ]
                            []
                        , span
                            [ Attr.class "hidden lg:flex lg:items-center"
                            ]
                            [ span
                                [ Attr.class "ml-4 text-sm font-semibold leading-6 text-gray-900"
                                , Attr.attribute "aria-hidden" "true"
                                ]
                                [ text "Tom Cook" ]
                            , Icons.chevronDown
                            ]
                        ]
                    , {-
                         Dropdown menu, show/hide based on menu state.

                         Entering: "transition ease-out duration-100"
                           From: "transform opacity-0 scale-95"
                           To: "transform opacity-100 scale-100"
                         Leaving: "transition ease-in duration-75"
                           From: "transform opacity-100 scale-100"
                           To: "transform opacity-0 scale-95"
                      -}
                      div
                        [ Attr.class "absolute right-0 z-10 mt-2.5 w-32 origin-top-right rounded-md bg-white py-2 shadow-lg ring-1 ring-gray-900/5 focus:outline-none"
                        , Attr.attribute "role" "menu"
                        , Attr.attribute "aria-orientation" "vertical"
                        , Attr.attribute "aria-labelledby" "user-menu-button"
                        , Attr.tabindex -1
                        ]
                        [ {- Active: "bg-gray-50", Not Active: "" -}
                          a
                            [ Attr.href "#"
                            , Attr.class "block px-3 py-1 text-sm leading-6 text-gray-900"
                            , Attr.attribute "role" "menuitem"
                            , Attr.tabindex -1
                            , Attr.id "user-menu-item-0"
                            ]
                            [ text "Your profile" ]
                        , a
                            [ Attr.href "#"
                            , Attr.class "block px-3 py-1 text-sm leading-6 text-gray-900"
                            , Attr.attribute "role" "menuitem"
                            , Attr.tabindex -1
                            , Attr.id "user-menu-item-1"
                            ]
                            [ text "Sign out" ]
                        ]
                    ]
                ]
            ]
        ]



-- MOBILE


mobileSidebar : SidebarStatus -> msg -> Html msg
mobileSidebar status toggle =
    div
        [ Attr.class "relative z-50 lg:hidden"
        , Attr.attribute "role" "dialog"
        , Attr.attribute "aria-modal" "true"
        ]
        [ div
            [ Attr.class "fixed inset-0 bg-gray-900/80"
            , case status of
                Open ->
                    Attr.class "opacity-100"

                Opening ->
                    Attr.class "opacity-100 transition-opacity ease-linear duration-300"

                Closed ->
                    Attr.class "opacity-0"

                Closing ->
                    Attr.class "opacity-0 transition-opacity ease-linear duration-300"
            ]
            []
        , div
            [ Attr.class "fixed inset-0 flex"
            ]
            [ div
                [ Attr.class "relative mr-16 flex w-full max-w-xs flex-1"
                , case status of
                    Open ->
                        Attr.class "translate-x-0"

                    Opening ->
                        Attr.class "translate-x-0 transition ease-in-out duration-300 transform"

                    Closed ->
                        Attr.class "-translate-x-full"

                    Closing ->
                        Attr.class "-translate-x-full transition ease-in-out duration-300 transform"
                ]
                [ div
                    [ Attr.class "absolute left-full top-0 flex w-16 justify-center pt-5"
                    , case status of
                        Open ->
                            Attr.class "opacity-100"

                        Opening ->
                            Attr.class "opacity-100 transition-opacity ease-in duration-300"

                        Closed ->
                            Attr.class "opacity-0"

                        Closing ->
                            Attr.class "opacity-0 transition-opacity ease-linear duration-100"
                    ]
                    [ button
                        [ Attr.type_ "button"
                        , Attr.class "-m-2.5 p-2.5"
                        , onClick toggle
                        ]
                        [ span
                            [ Attr.class "sr-only"
                            ]
                            [ text "Close sidebar" ]
                        , Icons.close
                        ]
                    ]
                , sidebar
                ]
            ]
        ]



-- DESKTOP


desktopSidebar : Html msg
desktopSidebar =
    div
        [ Attr.class "hidden lg:fixed lg:inset-y-0 lg:z-50 lg:flex lg:w-72 lg:flex-col"
        ]
        [ sidebar ]


sidebar : Html msg
sidebar =
    div
        [ Attr.class "flex grow flex-col gap-y-5 overflow-y-auto border-r border-gray-200 bg-white px-6 pb-4"
        ]
        [ div
            [ Attr.class "flex h-16 shrink-0 items-center"
            ]
            [ img
                [ Attr.class "h-8 w-auto"
                , Attr.src "https://tailwindui.com/img/logos/mark.svg?color=indigo&shade=600"
                , Attr.alt "Your Company"
                ]
                []
            ]
        , nav
            [ Attr.class "flex flex-1 flex-col"
            ]
            [ ul
                [ Attr.attribute "role" "list"
                , Attr.class "flex flex-1 flex-col gap-y-7"
                ]
                [ li []
                    [ listGroup ]
                , li []
                    [ div
                        [ Attr.class "text-xs font-semibold leading-6 text-gray-400"
                        ]
                        [ text "Your teams" ]
                    , ul
                        [ Attr.attribute "role" "list"
                        , Attr.class "-mx-2 mt-2 space-y-1"
                        ]
                        [ li []
                            [ {- Current: "bg-gray-50 text-indigo-600", Default: "text-gray-700 hover:text-indigo-600 hover:bg-gray-50" -}
                              a
                                [ Attr.href "#"
                                , Attr.class "text-gray-700 hover:text-indigo-600 hover:bg-gray-50 group flex gap-x-3 rounded-md p-2 text-sm leading-6 font-semibold"
                                ]
                                [ Icons.initial "H"
                                , span
                                    [ Attr.class "truncate"
                                    ]
                                    [ text "Heroicons" ]
                                ]
                            ]
                        , li []
                            [ a
                                [ Attr.href "#"
                                , Attr.class "text-gray-700 hover:text-indigo-600 hover:bg-gray-50 group flex gap-x-3 rounded-md p-2 text-sm leading-6 font-semibold"
                                ]
                                [ Icons.initial "T"
                                , span
                                    [ Attr.class "truncate"
                                    ]
                                    [ text "Tailwind Labs" ]
                                ]
                            ]
                        , li []
                            [ a
                                [ Attr.href "#"
                                , Attr.class "text-gray-700 hover:text-indigo-600 hover:bg-gray-50 group flex gap-x-3 rounded-md p-2 text-sm leading-6 font-semibold"
                                ]
                                [ Icons.initial "W"
                                , span
                                    [ Attr.class "truncate"
                                    ]
                                    [ text "Workcation" ]
                                ]
                            ]
                        ]
                    ]
                , li
                    [ Attr.class "mt-auto"
                    ]
                    [ a
                        [ Attr.href "#"
                        , Attr.class "group -mx-2 flex gap-x-3 rounded-md p-2 text-sm font-semibold leading-6 text-gray-700 hover:bg-gray-50 hover:text-indigo-600"
                        ]
                        [ Icons.settings
                        , text "Settings"
                        ]
                    ]
                ]
            ]
        ]


type alias ListItem msg =
    { label : String
    , icon : Html msg
    , active : Bool
    }


listItem : ListItem msg -> Html msg
listItem l =
    li []
        [ a
            [ Attr.href "#"
            , if l.active then
                Attr.class "bg-gray-50 text-indigo-600 group flex gap-x-3 rounded-md p-2 text-sm leading-6 font-semibold"

              else
                Attr.class "text-gray-700 hover:text-indigo-600 hover:bg-gray-50 group flex gap-x-3 rounded-md p-2 text-sm leading-6 font-semibold"
            ]
            [ l.icon
            , text l.label
            ]
        ]


listGroup : Html msg
listGroup =
    ul
        [ Attr.attribute "role" "list"
        , Attr.class "-mx-2 space-y-1"
        ]
        [ listItem
            { label = "Dashboard"
            , icon = Icons.home
            , active = True
            }
        , listItem
            { label = "Team"
            , icon = Icons.team
            , active = False
            }
        , listItem
            { label = "Projects"
            , icon = Icons.projects
            , active = False
            }
        , listItem
            { label = "Calendar"
            , icon = Icons.calendar
            , active = False
            }
        , listItem
            { label = "Documents"
            , icon = Icons.documents
            , active = False
            }
        , listItem
            { label = "Reports"
            , icon = Icons.reports
            , active = False
            }
        ]
