*** Keywords ***
Begin Web Test
    Open Browser                 about:blank     ${BROWSER}
    Maximize Browser Window


Go to Web Page
    Load Page
    Verify Page Loaded

Load Page
    Go To                     ${URL}

Verify Page Loaded
    ${link_title} =            Get Text  id:title
    Should Be Equal           ${link_title}  Infotiv Car Rental

Login
    [Arguments]       ${email}        ${password}
    Enter Email       ${email}
    Enter Password    ${password}
    Click Login Button

Enter Email
    [Arguments]  ${email}
    Input Text       id:email            ${email}
Enter Password
    [Arguments]  ${password}
    Input Text       id:password         ${password}

Click Login Button
    Click Button     id:login

Verify Invalid Password
    Wait until element is visible              CSS:#password:invalid

Verify Login Success
    Wait Until Element Contains          id:welcomePhrase          You are signed in as Tingting

Verify Login Error
    Element should contain      id:signInError          Wrong e-mail or password

Continue Button
    Click Button        id:continue

Go to My Page
    Click Button        id:mypage

Select Car
    Click Button             xpath://div[@id='ms-list-1']//button
    ${CAR DICT}=             Create Dictionary
                             Set To Dictionary        ${CarDict}      Audi     2
                             Set To Dictionary        ${CarDict}      Opel     9
                             Set To Dictionary        ${CarDict}      Tesla    7
                             Set To Dictionary        ${CarDict}      Volvo    5
    ${random_car}=           Evaluate        random.choice(list(${CAR DICT}.keys()))        modules=random
    Select Checkbox          ${random_car}
    ${car_name}=             Get Text        xpath://div[@id='ms-list-1']//button
    Click Button             xpath://div[@id='ms-list-2']//button
    ${car_seats}=            Get From Dictionary     ${CAR DICT}      ${car_name}
    Select Checkbox          ${car_seats}
    Sleep                    5
    Click Button             id:carSelect1

Booking Confirm
    Input Text          id:cardNum          1234567890123456
    Input Text          id:fullName         ting
    Input Text          id:cvc              123
    Click Button        id:confirm

Booking
    Go to Web Page
    Login   ${VALID EMAIL}      ${VALID PASSWORD}
    Continue Button
    Select Car
    Booking Confirm

Set Start Date
    [Arguments]       ${day}
    ${date}=           Get Time         day month   ${day}
    Input Text      id:start        ${date}
Set End Date
    [Arguments]       ${day}
    ${date}=           Get Time         day month   ${day}
    Input Text      id:end        ${date}

Verify Error in New Tab
    ${linkLog}=         Get Location
    Execute Javascript    window.open()
    Switch Window       locator=NEW
    Go to           ${linkLog}
    Element should contain          id:questionTextSmall         Unfortunately your selected car became unavailable during your booking. Please go back to car selection and try again.

Click Cancel
    Element should be visible       id:unBook1
    Click Button        id:unBook1

Verify Valid Date
    Continue Button
    Page Should Contain                 What would you like to drive?

Cancel Booking Verified
    ${licensNr}=        Get Text        xpath://td[@id='licenseNumber1']
    Click Cancel
    Handle Alert
    Page should contain        Your car: ${licensNr} has been Returned

Verify Car Booked
    Element Should Be Visible           id:order1

End Web Test
    Close Browser
