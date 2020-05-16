Feature: Validar servicio Account/cbuHash
  Background:
    * url baseUrl
    * header Authorization = 'bearer F9MHzuYZrfpRqNFBCa1uz8nYlO0FXV58FXf2NjKiJ6g.mCko309YYsj8aJ3jEO7po-zi8kpWiT6L7WT2_oVv1MI'
    #* def responseAccount = read('responseAccount_00925721.json')
    #* def responseAccount = read('rta00671612.json')
    #* def message_error = read('error_message_account.json')
    #* def cbu_hash = read('cbuHash.json')

  @account @cbuHash
  Scenario Outline: Validar deshasheo (OK)
    * def responseAccount = read('rta00671612.json')
    * def message_error = read('error_message_account.json')
    * def hash = <cbuHash>
    Given path '/accounts/<hash>'
    When method GET
    Then status 200
    And match response contains any { "cbu":<cbu> }

    Examples:
      | cbuHash                    | cbu                   |
      | responseAccount[0].cbu_hash | 'responseAccount[0].cbu' |
     # | responseAccount[0].cbu_hash | responseAccount[0].cbu|

  @account @cbuHash
  Scenario:  validar STATUS CODE 400
    #ver escenarios que generen status 400
    Given path '/accounts/<cbu_hash>'
    When method GET
    Then status 400
    And match response == message_error[0]
    #cambiar mensaje de error en el json


  @account @cbuHash
  Scenario Outline:  validar consulta con credenciales invalidas STATUS CODE 401
    * def token_invalido = read('tokenInvalido.json')
    Given path '/accounts/<cbu_hash>'
    And header Authorization = <token>
    When method GET
    Then status 401
    And match response == <message>

    Examples:
      |     token      |           message             |
      | token_invalido |"error": "invalid_credentials" |
      | token_expírado |"error": "token_expired"       |


  @account @cbuHash
  Scenario: validar consulta para usuarios sin cuentas STATUS CODE 404
    #client invalido has invalido
    #validar con usuarios validos que no tengan cuentas
    Given path '/accounts/<cbu_hash>'
    When method GET
    Then status 404
    And match response == message_error[2]


  @account @cbuHash
  Scenario:  validar bad request
    # ver como hacer para que el servicio responda 500
    Given path '/accounts/<cbu_hash>'
    When method GET
    Then status 500
    And match response == message_error[3]

