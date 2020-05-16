Feature: obtener accesToken
  Background:
    * configure driver = { type: 'chrome'}

  @login
  Scenario:realizar login
    Given driver loginUrlTest
    #And waitFor("//div[@id='app']/div[2]/div/div/div/form/div[2]/div/div/div/label").click()
    And retry().click("//div[@id='app']/div[2]/div/div/div/form/div[2]/div/div/div/label")
    And retry().input('input[id=text-30]',dni,200)
    And retry().click("//div[@id='app']/div[2]/div/div/div/form/div[3]/div/label")
    And retry().input("input[id=text-32]", usuario, 200)
    And retry().click("//div[@id='app']/div[2]/div/div/div/form/div[3]/div[2]/label")
    And retry().input("input[id=password-33]",password, 200)
    When retry().click("input[id=conocerOferta]")
    And retry().click("input[id=option-48]")
    And retry().click("id=conocerOferta")
    And def access_token = value('#access_token')
    Then print access_token
    And driver.quit()




#    When retry().click("//input[@value='Aceptar']")
#   And retry().click("//input[@value='Permitir']")
#    And def access_token = value('#access_token')
    Then print access_token
    And driver.quit()





