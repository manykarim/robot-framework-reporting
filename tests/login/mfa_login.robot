*** Settings ***
Library    Browser
Library    totp.py
Test Setup    New Browser    browser=${BROWSER}    headless=${HEADLESS}
Test Teardown    Close Browser

*** Variables ***
${BROWSER}    chromium
${HEADLESS}    True

*** Test Cases ***
Login with valid username, password and totp
    Open Login Page
    Enter Username and Password    demo_user    secret_pass
    Enter TOTP Code    GAXG2MTEOR3DMMDG
    Sign In and Verify Welcome Message

Login with invalid username
    Open Login Page
    Enter Username    invalid
    Sign In and Verify Error Message "Invalid Username!"

Login with invalid password
    Open Login Page
    Enter Username and Password    demo_user    invalid
    Sign In and Verify Error Message "Invalid Password!"

Login with invalid totp
    Open Login Page
    Enter Username and Password    demo_user    secret_pass
    Fill Text    id=totpcode     11111
    Sign In and Verify Error Message "Invalid MFA Code!"

*** Keywords ***
Open Login Page
    New Page    https://seleniumbase.io/realworld/login

Enter Username
    [Arguments]    ${username}
    Fill Text    id=username    ${username}

Enter Password
    [Arguments]    ${password}
    Fill Text    id=password    ${password}    

Enter Username and Password
    [Arguments]    ${username}    ${password}
    Fill Text    id=username    ${username}
    Fill Text    id=password    ${password}    

Enter TOTP Code
    [Arguments]    ${secret}
    ${totp}    Get Totp    ${secret}
    Fill Text    id=totpcode     ${totp}

Sign In and Verify Welcome Message
    Click    "Sign in"
    Get Text  h1  ==  Welcome!
    Take Screenshot

Sign In and Verify Error Message "${message}"
    Click    "Sign in"
    Get Text    id=top_message     ==    ${message} 