*** Settings ***
Library    Browser    #enable_presenter_mode=True
Library    String
Suite Setup    New Browser    browser=${BROWSER}    headless=${HEADLESS}
Test Setup    New Context    viewport={'width': 1280, 'height': 720}    #recordVideo={'dir':'videos', 'size':{'width':400, 'height':200}}
Test Teardown    Close Context
Suite Teardown    Close Browser

*** Variables ***
${BROWSER}    chromium
${HEADLESS}    True

*** Test Cases ***
Add Two ToDos And Check Items
    [Documentation]    Checks if ToDos can be added and ToDo count increases
    [Tags]    Add ToDo
    Given ToDo App is open
    When I Add A New ToDo "Learn Robot Framework"
    And I Add A New ToDo "Write Test Cases"
    Then Open ToDos should show "2 items left"

Add Two ToDos And Check Wrong Number Of Items
    [Documentation]    Checks if ToDos can be added and ToDo count increases
    [Tags]    Add ToDo
    Given ToDo App is open
    When I Add A New ToDo "Learn Robot Framework"
    And I Add A New ToDo "Write Test Cases"
    Then Open ToDos should show "1 items left"

Add ToDo And Mark Same ToDo
    [Tags]    Mark ToDo
    Given ToDo App is open
    When I Add A New ToDo "Learn Robot Framework"
    And I Mark ToDo "Learn Robot Framework"
    Then Open ToDos should show "0 items left"


*** Keywords ***
ToDo App is open
    New Page    https://todomvc.com/examples/react/

I Add A New ToDo "${todo}"   
    Fill Text  .new-todo  ${todo}
    Press Keys  .new-todo  Enter
    
Open ToDos should show "${text}"
    Get Text    span.todo-count    ==    ${text}

I Mark ToDo "${todo}"
    Click    "${todo}" >> .. >> input.toggle