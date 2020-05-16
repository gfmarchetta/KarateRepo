Feature: validar servicio transfer
  Background:
    * url baseUrl + '/transfers'
    * def req = read('request.json')
    * def message_error = read('error_message_transfer.json')
   # * header Authorization = 'bearer wXNOFYzvkm9183NZmNf6hI1pPbWpfCNSqQf2m86Hc7Q.Hl4rYJ8rD2mc50jbM5rLb8dVJoFcFLGvzL8-W1wIwY0'


  @transfers
  Scenario: validar status 201 OK servicio transfer
    Given request req
    When method POST
    Then status 201

  @transfers
  Scenario: validar respuesta de servicio transfer
    * def responseTransfer = read('response_transfer.json')
    Given request req
    When method POST
    Then match response == responseTransfer

  @transfers
  Scenario Outline:  validar tope de transferencia permitido
    * set req.amount = <AMOUNT>
    Given request req
    When method POST
    Then status <STATUS>
    * def rta = response
    * def rta_status = status
    And assert status == 200 || status == 400
    And eval if (status == 400) match response == rta
    #revisar status, response, etc. HACER QUE FUNCIONE
    
    Examples:
    |AMOUNT|STATUS|
    |49999.99|201 |
    |50000.00|201 |
    |50000.01|400 |

  @transfers
  Scenario:  validar error en parametros STATUS CODE 400
    # ver como hacer para que el servicio responda 400
    Given request req
    When method GET
    Then status 400
    And match response == message_error[0]

  @transfers
  Scenario Outline:  validar consulta con credenciales invalidas STATUS CODE 401
    #validar con token invalido
    #validar con token vencido
    #validar con token vacio
    * def token_invalido = read('tokenInvalido.json')
    * header Authorization = <token>
    When method GET
    Then status 401
    And match response == <message>

    Examples:
      |       token    | message |
      | token_invalido | "error": "invalid_credentials"|
      | token_exírado  |   "error": "token_expired"    |

  @transfers
  Scenario: validar error cuando alguno de los cbu no existe STATUS CODE 404
    #enviar en request cbu no correspondiente a la cuenta
    #enviar en request cbu filtrado
    Given request req
    When method GET
    Then status 404
    And match response == message_error[2]


  @transfers
  Scenario Outline:  validar error cuando no se cumple alguna regla previa STATUS CODE 412
    # por ejemplo, la Cuenta de la cuenta no tiene saldo suficiente o está bloqueada, cancelada
    Given request req
    When method GET
    Then status 412
    And match response == message_error[3]

    Examples:
    |token|message|
    |tk_insuficiente|
    |tk_bloqueado   |
    |tk_cancelado   |
    |regla_rota     |


  @transfers
  Scenario:  validar error en el request STATUS CODE 500
    # ver como hacer para que el servicio responda 500
    Given request req
    When method GET
    Then status 500
    And match response == message_error[4]
