*** Settings ***
Library    RequestsLibrary
Library    Collections
Variables    testdata.py

*** Test Cases ***

Create Booking with Low Level Keywords
    Create Session    booker    url=${url}    headers=${headers}   disable_warnings=True
    # Create Booking
    ${response}    POST On Session    booker    /booking    json=${booking}
    Status Should Be    200
    # Log response and retrieve booking via GET
    ${response}    GET On Session    booker    /booking/${response.json()}[bookingid]
    # Assertions
    Should Be Equal    ${response.json()}[lastname]    ${booking}[lastname]
    Should Be Equal    ${response.json()}[firstname]    ${booking}[firstname]
    Should Be Equal As Numbers    ${response.json()}[totalprice]    ${booking}[totalprice]
    Should Be Equal As Strings    ${response.json()}[depositpaid]    ${booking}[depositpaid]
    Should Be Equal    ${response.json()}[bookingdates][checkin]    ${booking}[bookingdates][checkin]
    Should Be Equal    ${response.json()}[bookingdates][checkout]    ${booking}[bookingdates][checkout]
    Should Be Equal    ${response.json()}[additionalneeds]    ${booking}[additionalneeds]


Create a Booking with High Level Keywords
    Given I Am Authenticated As A User
    When I Create A Correct Booking
    Then I Should Get A 200 Response
    And The Booking Should Be Stored

Delete Booking
    Given I Am Authenticated As An Admin
    And I Create A Correct Booking
    When I Delete The Booking
    Then I Should Get A 201 Response
    And The Booking Should Be Deleted


*** Keywords ***
Authenticate as Admin
    ${response}    POST    url=https://restful-booker.herokuapp.com/auth    json=${auth}
    ${token}    Set Variable    ${response.json()}[token]
    ${header}    Create Dictionary    Cookie=token\=${token}
    Create Session    booker_admin    url=${url}    headers=${header}    disable_warnings=True


I Am Authenticated As A User
    Create Session    booker    url=${url}    headers=${headers}   disable_warnings=True

I Am Authenticated As An Admin
    Authenticate as Admin

I Create A Correct Booking
    ${response}    POST On Session    booker    /booking    json=${booking}
    Set Test Variable    ${response}

I Should Get A 200 Response
    Status Should Be    200

I Should Get A 201 Response
    Status Should Be    201

The Booking Should Be Stored
    ${response}    GET On Session    booker    /booking/${response.json()}[bookingid]
    Log    ${response.json()}
    # Assertions
    Should Be Equal    ${response.json()}[lastname]    ${booking}[lastname]
    Should Be Equal    ${response.json()}[firstname]    ${booking}[firstname]
    Should Be Equal As Numbers    ${response.json()}[totalprice]    ${booking}[totalprice]
    Should Be Equal As Strings    ${response.json()}[depositpaid]    ${booking}[depositpaid]
    Should Be Equal    ${response.json()}[bookingdates][checkin]    ${booking}[bookingdates][checkin]
    Should Be Equal    ${response.json()}[bookingdates][checkout]    ${booking}[bookingdates][checkout]
    Should Be Equal    ${response.json()}[additionalneeds]    ${booking}[additionalneeds]


I Delete The Booking
    ${response}    DELETE On Session    booker_admin    /booking/${response.json()}[bookingid]

The Booking Should Be Deleted
    ${response}    GET On Session    booker    /booking/${response.json()}[bookingid]    expected_status=404