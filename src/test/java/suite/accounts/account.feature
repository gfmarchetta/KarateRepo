# new feature
# Tags: optional

Feature: validar servicio Accounts
  Background:
    * url baseUrl + '/accounts'
    #* def result = call read('loginUI.feature')
    #* def token = login.access_token
    #* header Authorization = 'bearer ' + token

  @account
  Scenario Outline: validar servicio Accounts.Cliente:<dni>
    #* def result = call read('loginUI.feature') {dni:<dni>), usuario:<usuario>, password:<password>}
    * def result = call read('loginUITest.feature') {dni:<dni>), usuario:<usuario>, password:<password>}
    * def token = result.access_token
    * header Authorization = 'bearer' + ' ' + token
    * def token = result.access_token
    When method GET
    Then status 200
    And print response
    Examples:
    |   dni    | usuario | password |
    | 00671612 | user    | pass     |
    | 00672309 | user    | pass     |
    | 00670996 | user    | pass     |


  #00671612 productos 40 y 20; #00672309 producto 40; #00670996 producto 20; #00897625 productos 40, 20 y otros (no existe)

  @account
  Scenario Outline: validar respuesta de la consulta de todas las cuentas de un cliente (OK)
    * def result = call read('loginUI.feature') {dni:<dni>), usuario:<usuario>, password:<password>}
    * def token = result.access_token
    * header Authorization = 'bearer' + ' ' + token
    * def responseAccount = read('rta00671612.json')
    When method GET
    Then status 200
    And match response == '#[2]'
    And match response[0].account_number == responseAccount[0].account_number
    And match response[0].account_type == responseAccount[0].account_type
    And match response[0].cbu == responseAccount[0].cbu
    And match response[0].cbu_hash == responseAccount[0].cbu_hash
    And match response[1].account_number == responseAccount[1].account_number
    And match response[1].account_type == responseAccount[1].account_type
    And match response[1].cbu == responseAccount[1].cbu
    And match response[1].cbu_hash == responseAccount[1].cbu_hash
    Examples:
      |   dni    | usuario | password |
      | 00671612 | user    | pass     |

  @account
  Scenario Outline: validar consulta Ok al consultar por un cbu
    * def result = call read('loginUI.feature') {dni:<dni>), usuario:<usuario>, password:<password>}
    * def token = result.access_token
    * header Authorization = 'bearer ' + token
    * def cbu = read('cbuHash.json')
    * param cbuHash = <cbu_hash>
    When method GET
    Then status 200
    And match response == '#[1]'
    And print response
    Examples:
      |   dni    | usuario | password |    cbu_hash     |
      | 00671612 | user    | pass     | cbu[0].cbu_hash |
      | 00671612 | user    | pass     | cbu[1].cbu_hash |


  @account
  Scenario Outline: validar que la respuesta de la consulta corresponda al cbu indicado
    * def result = call read('loginUI.feature') {dni:<dni>), usuario:<usuario>, password:<password>}
    * def token = result.access_token
    * header Authorization = 'bearer' + ' ' + token
    * def cbu = read('cbuHash.json')
    * def responseAccount = read('rta00671612.json')
    * param cbuHash = <cbu_hash>
    When method GET
    Then status 200
    And match response == '#[1]'
    And match response[0].account_number == responseAccount[0].account_number
    And match response[0].account_type == responseAccount[0].account_type
    And match response[0].cbu == responseAccount[0].cbu
    And match response[0].cbu_hash == responseAccount[0].cbu_hash

    Examples:
      |   dni    | usuario | password |    cbu_hash     |
      | 00671612 | user    | pass     | cbu[0].cbu_hash |


  @account
  Scenario:  Validar error en el request (Error 400)
    #ver escenarios que generen status 400
    When method GET
    * print request
    Then status 400
    And match response == message_error[0]
    #cambiar mensaje de error en el json

  @account
  Scenario Outline: Validar error en la autenticacion (Error 401)
    * def error = read('error_message_account.json')
    * def token = read('tokenInvalido.json')
    * header Authorization = <token>
    When method GET
    Then status 401
    And match response.error.message contains <message>
    Examples:
    | token          | message                |
    | token[0].token | error[1].error.message |
    | token[1].token | error[1].error.message |
    | token[2].token | error[2].error.message |


  @account
  Scenario: validar consulta para usuarios sin productos (Error 404)
    #client invalido has invalido
    #validar con usuarios validos que no tengan cuentas
    When method GET
    Then status 404
    And match response == message_error[2]

  @account
  Scenario: validar error interno del servidor (Rrror 500)
    # ver como hacer para que el servicio responda 500
    When method GET
    Then status 500
    And match response == message_error[3]

  



