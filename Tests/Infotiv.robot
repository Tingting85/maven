*** Settings ***
Documentation           This is information about testsuite for Infotiv car rental
Resource             ../Resources/keywords.robot
Library                 SeleniumLibrary
Library                 Collections
Test Setup              Begin Web Test
Test Teardown           End Web Test

*** Variables ***
${BROWSER} =            chrome
${URL} =                http://rental7.infotiv.net/
${VALID EMAIL} =        tingting.jin@iths.se
${VALID PASSWORD} =     tingting

*** Test Cases ***
Login Success
    [Documentation]  Tests the login function with success result
    [Tags]  Header Log in
    Given Go to Web Page
     When Login   ${VALID EMAIL}      ${VALID PASSWORD}
     Then Verify Login Success

Login Empty Password
    [Documentation]  Tests the login function failed empty password
    [Tags]  Header Log in
    Given Go to Web Page
     When Login   ${VALID EMAIL}     ${empty}
     Then Verify Invalid Password

Login Wrong Password
    [Documentation]  Tests the login function failed wrong password
    [Tags]  Header Log in
    Given Go to Web Page
     When Login   ${VALID EMAIL}     12345678
     Then Verify Login Error

Set Valid Date
    [Documentation]  Tests the date selecting function with success result
    [Tags]  Date Selection
    Given Go to Web Page
     When Set Start Date                      Now +2 day
          Set End Date                        Now +10 day
     Then Verify Valid Date

Invalid Start Date
    [Documentation]  Tests the date selecting function failed invalid start date
    [Tags]  Date Selection
    Given Go to Web Page
     When Set Start Date                      NOW - 1 day
          Continue Button
     Then Wait until element is visible       CSS:#start:invalid

Invalid End Date
    [Documentation]  Tests the date selecting function failed invalid end date
    [Tags]  Date Selection
    Given Go to Web Page
     When Set End Date                        NOW + 32 day
          Continue Button
     Then Wait until element is visible       CSS:#end:invalid

#Book A Car and Cancel Booking
    #[Documentation]  Tests the car selecting function to successfully book a car and cancel booking afterwards
    #[Tags]  Car Selection
          #Go to Web Page
          #Login   ${VALID EMAIL}      ${VALID PASSWORD}
    #Given Booking
     #When Go to My Page
     #Then Cancel Booking Verified

#Car Booked Error Message
    #[Documentation]  Tests the booking function get to the successful booking page in a new window
    #[Tags]  Successful Booking
         #Go to Web Page
         #Login   ${VALID EMAIL}      ${VALID PASSWORD}
    #Given Booking
     #When Verify Error in New Tab
          #Go to My Page
     #Then Verify Car Booked





