*** Settings ***
Library    Browser
Library    totp.py
Test Setup    New Browser    browser=${BROWSER}    headless=${HEADLESS}
Test Teardown    Close Browser

*** Variables ***
${BROWSER}    chromium
${HEADLESS}    True

*** Test Cases ***
Login with MFA
    Open Login Page
    Enter Username and Password    demo_user    secret_pass
    Enter TOTP Code    GAXG2MTEOR3DMMDG
    Sign In and Verify Welcome Message
    
*** Keywords ***
Open Login Page
    New Page    https://seleniumbase.io/realworld/login

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