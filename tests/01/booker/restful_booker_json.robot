*** Settings ***
Library   JSONLibrary
Library  RequestsLibrary
Library   Collections

*** Test Cases ***
Create a Booking
    ${body}    Load Json From File    file_name=${CURDIR}${/}booking.json
    ${body}    JSONLibrary.Update Value To Json   json_object=${body}   json_path=$.firstname    new_value=Peter
    Log Dictionary    ${body}
    ${response}    POST      https://restful-booker.herokuapp.com/booking    json=${body}
    ${id}    Set Variable    ${response.json()}[bookingid]
    ${response}    GET   https://restful-booker.herokuapp.com/booking/${id}
    Should Be Equal As Strings    ${response.json()}[firstname]    Peter
