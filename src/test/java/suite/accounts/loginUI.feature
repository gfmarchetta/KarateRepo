Feature: obtener accesToken
  Background:
    * configure driver = { type: 'chrome'}

  #@login
  Scenario:realizar login
    Given driver loginUrlDesa
    And waitFor('input[name=dni]').click()
    And retry().click('input[name=dni]')
    And retry().input('input[name=dni]', dni)
    And retry().click('input[name=usuario]')
    And retry().input('input[name=usuario]', usuario)
    And retry().click('input[name=password]')
    And retry().input('input[name=password]',password)
    When retry().click("//input[@value='Aceptar']")
    And retry().click("//input[@value='Permitir']")
    And def access_token = value('#access_token')
    Then print access_token
    And driver.quit()





