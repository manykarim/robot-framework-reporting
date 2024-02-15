*** Settings ***
Library    Browser    timeout=30
Library    OperatingSystem
Library    String
Test Template    Configure Car
Suite Setup    New Browser    browser=chromium    headless=True    slowMo=0.5s
Suite Teardown    Close Browser
Test Tags    car-configurator


*** Variables ***
${4SPACES}    ${SPACE}${SPACE}${SPACE}${SPACE}

*** Test Cases ***    {MODEL}=0    ${ENGINE}=0    ${PACKAGE}=0    ${EXTRAS}=*    ${COLOR}=0    ${PRICE}=99.999,99 €
Car 001    0    0    0    0    0    31.900,00 €
Car 002    0    1    1    1    1    32.823,00 €
Car 003    0    2    2    2    2    36.498,99 €
Car 004    0    3    0    3    3    31.246,00 €
Car 005    0    4    1    4    4    35.772,00 €
Car 006    0    0    2    5    5    34.499,99 €
Car 007    0    1    0    6    6    32.100,00 €
Car 008    0    2    1    7    7    32.412,00 €
Car 009    0    3    2    0    8    36.699,99 €
Car 010    0    4    0    1    9    34.209,00 €
# Car 011    1    0    0    0    0    17.900,00 €
# Car 012    1    1    1    1    1    18.823,00 €
# Car 013    1    2    0    2    2    18.489,00 €
# Car 014    1    3    1    3    3    18.659,00 €
# Car 015    1    4    0    4    4    20.359,00 €
# Car 016    1    0    1    5    5    16.883,00 €
# Car 017    1    1    0    6    6    18.100,00 €
# Car 018    1    2    1    7    7    18.412,00 €
# Car 019    1    3    0    0    8    20.100,00 €
# Car 020    1    4    1    1    9    21.622,00 €
# Car 021    2    0    0    0    0    19.900,00 €
# Car 022    2    1    1    1    1    20.823,00 €
# Car 023    2    2    2    2    2    21.538,00 €
# Car 024    2    3    0    3    3    19.246,00 €
# Car 025    2    4    1    4    4    23.772,00 €
# Car 026    2    0    2    5    5    18.049,00 €
# Car 027    2    1    0    6    6    20.100,00 €
# Car 028    2    2    1    7    7    20.412,00 €
# Car 029    2    3    2    0    8    23.149,00 €
# Car 030    2    4    0    1    9    22.209,00 €
# Car 031    3    0    0    0    0    21.400,00 €
# Car 032    3    1    1    1    1    22.323,00 €
# Car 033    3    2    2    2    2    23.038,00 €
# Car 034    3    3    0    3    3    20.746,00 €
# Car 035    3    4    1    4    4    25.272,00 €
# Car 036    3    0    2    5    5    19.549,00 €
# Car 037    3    1    0    6    6    21.600,00 €
# Car 038    3    2    1    7    7    21.912,00 €
# Car 039    3    3    2    0    8    24.649,00 €
# Car 040    3    4    0    1    9    23.709,00 €
# Car 041    4    0    0    0    0    15.200,00 €
# Car 042    4    1    1    1    1    16.123,00 €
# Car 043    4    2    0    2    2    15.789,00 €
# Car 044    4    3    1    3    3    15.959,00 €
# Car 045    4    4    0    4    4    17.659,00 €
# Car 046    4    0    1    5    5    14.183,00 €
# Car 047    4    1    0    6    6    15.400,00 €
# Car 048    4    2    1    7    7    15.712,00 €
# Car 049    4    3    0    0    8    17.400,00 €
# Car 050    4    4    1    1    9    18.922,00 €
# Car 051    5    0    0    0    0    17.900,00 €
# Car 052    5    1    1    1    1    18.823,00 €
# Car 053    5    2    0    2    2    18.489,00 €
# Car 054    5    3    1    3    3    18.659,00 €
# Car 055    5    4    0    4    4    20.359,00 €
# Car 056    5    0    1    5    5    16.883,00 €
# Car 057    5    1    0    6    6    18.100,00 €
# Car 058    5    2    1    7    7    18.412,00 €
# Car 059    5    3    0    0    8    20.100,00 €
# Car 060    5    4    1    1    9    21.622,00 €
# Car 061    6    0    0    0    0    22.900,00 €
# Car 062    6    1    1    1    1    23.823,00 €
# Car 063    6    2    0    2    2    23.489,00 €
# Car 064    6    3    1    3    3    23.659,00 €
# Car 065    6    4    0    4    4    25.359,00 €
# Car 066    6    0    1    5    5    21.883,00 €
# Car 067    6    1    0    6    6    23.100,00 €
# Car 068    6    2    1    7    7    23.412,00 €
# Car 069    6    3    0    0    8    25.100,00 €
# Car 070    6    4    1    1    9    26.622,00 €
# Car 071    7    0    0    0    0    27.900,00 €
# Car 072    7    1    1    1    1    28.823,00 €
# Car 073    7    2    0    2    2    28.489,00 €
# Car 074    7    3    1    3    3    28.659,00 €
# Car 075    7    4    0    4    4    30.359,00 €
# Car 076    7    0    1    5    5    26.883,00 €
# Car 077    7    1    0    6    6    28.100,00 €
# Car 078    7    2    1    7    7    28.412,00 €
# Car 079    7    3    0    0    8    30.100,00 €
# Car 080    7    4    1    1    9    31.622,00 €
# Car 081    8    0    0    0    0    22.899,00 €
# Car 082    8    1    1    1    1    23.822,00 €
# Car 083    8    2    0    2    2    23.488,00 €
# Car 084    8    3    1    3    3    23.658,00 €
# Car 085    8    4    0    4    4    25.358,00 €
# Car 086    8    0    1    5    5    21.882,00 €
# Car 087    8    1    0    6    6    23.099,00 €
# Car 088    8    2    1    7    7    23.411,00 €
# Car 089    8    3    0    0    8    25.099,00 €
# Car 090    8    4    1    1    9    26.621,00 €
# Car 091    9    0    0    0    0    27.899,00 €
# Car 092    9    1    1    1    1    28.822,00 €
# Car 093    9    2    2    2    2    32.497,99 €
# Car 094    9    3    0    3    3    27.245,00 €
# Car 095    9    4    1    4    4    31.771,00 €
# Car 096    9    0    2    5    5    30.498,99 €
# Car 097    9    1    0    6    6    28.099,00 €
# Car 098    9    2    1    7    7    28.411,00 €
# Car 099    9    3    2    0    8    32.698,99 €
# Car 100    9    4    0    1    9    30.208,00 €

*** Keywords ***
Configure Car
    [Arguments]    ${MODEL}=0    ${ENGINE}=0    ${PACKAGE}=0    ${EXTRAS}=*    ${COLOR}=0    ${PRICE}=99.999,99 €
    Create New Car Configuration
    Select Model    ${MODEL}
    Select Engine    ${ENGINE}
    Select Package    ${PACKAGE}
    Select Extras    ${EXTRAS}
    Select Color    ${COLOR}
    #${ACTUALPRICE}    Get Text    id=label_price_sum
    #Append To File    prices.csv    ${TEST NAME}${4SPACES}${MODEL}${4SPACES}${ENGINE}${4SPACES}${PACKAGE}${4SPACES}${EXTRAS}${4SPACES}${COLOR}${4SPACES}${ACTUALPRICE}\n
    Check Price    ${PRICE}

Create New Car Configuration
    New Page    https://vsr.testbench.com/
    Click    id=english
    Click    text=As Customer
    Click    text=New car

Select Model
    [Arguments]    ${MODEL}
    Click   id=select_basemodel
    Click    mat-option >> nth=${MODEL}    # 0 -9
    Set Tag From Element    id=select_basemodel    Model
    Click    id=arrow_next

Select Engine
    [Arguments]    ${ENGINE}
    Click    id=select_engine
    Click    mat-option >> nth=${ENGINE}    # 0-4
    Set Tag From Element    id=select_engine    Engine
    Click    id=arrow_next

Select Package
    [Arguments]    ${PACKAGE}
    Click    mat-radio-button >> nth=${PACKAGE}     # 0-2
    Set Tag From Element    mat-radio-button.mat-radio-checked    Package
    Click    id=arrow_next

Select Extras
    [Arguments]    ${EXTRAS}
    IF  '${EXTRAS}' == '*'
        ${extras_elements}    Get Elements    mat-checkbox
        FOR    ${extra}    IN    @{extras_elements}
            Click    ${extra}
        END
        ELSE
            Click    mat-checkbox >> nth=${EXTRAS}
    END
    Click    id=arrow_next

Select Color
    [Arguments]    ${COLOR}
    Click    mat-radio-button >> nth=${COLOR}    # 0 -9
    Set Tag From Element    mat-radio-button.mat-radio-checked    Color
    Click    id=arrow_next

Check Price
    [Arguments]    ${PRICE}
    Get Text    id=label_price_sum    ==    ${PRICE}
    #Get Text    id=label_price_sum


Set Tag From Element
    [Arguments]    ${locator}    ${prefix}
    ${value}    Get Text    ${locator}
    ${value}    Strip String    ${value}
    Set Tags    ${prefix}=${value}
