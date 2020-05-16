Feature: validar el flujo e2e de accounts

  Scenario: consultar todas las cuentas del usuario
    Given url url_Account_Channel
    And path '/accounts'
    And headers client_id = <client_id>
    And header codiser = <codiser>
    And param dni = <dni> #opcional
    When method GET
    Then status 200
    * def resChannel = response
    * def temp = karate.prevRequest
    * def reqClient = tem.client_id
    * def reqCodiser = tem.codiser

      #validar schema respuesta
    #validar ningun campo null
    #validar respuesta
    #validar si cbu existe en base sino
    #* def var = db.readRows("select*from ... ")


    Given url url_Account_Aplicativa
    And path '/accounts'
    And headers client_id = <client_id>
    And header codiser = <codiser>
    And param dni = <dni> #opcional
    And param cod_oper_tracking_alta = <resChannel.cod_oper_tracking_alta> #se envia en la respuesta?
    When method GET
    Then status 200
    * def resAplicativa = response




  Scenario: consultar una cuenta especifica del usuario
    Given url urlCbuHashChannel
    And path '/accounts'
    And headers client_id = <client_id>
    And header codiser = <codiser>
    When method GET
    Then status 200


