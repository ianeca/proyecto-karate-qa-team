@automation-api
Feature: Funcionalidad login
  Scenario:  Login Exitoso
    Given url urlBase
    And path 'api/login'
    And request {email: "janeth@gmail.com", password: "12345678"}
    When method post
    Then status 200
    And match response.access_token =='#string'
    And match response.user.email == 'janeth@gmail.com'

  Scenario Outline: Login con contraseña incorrecta
    Given url urlBase
    And path 'api/login'
    And request {email: <email>, password: <password>}
    When method post
    Then status 401
    And match response.message == "Datos incorrectos"

    Examples:
      |email            |password    |
      |janeth@gmail.com |123456789    |


  @login
  Scenario:  Login Exitoso 2
    Given url urlBase
    And path 'api/login'
    And request {email: "janeth@gmail.com", password: "12345678"}
    When method post
    Then status 200
    * def token = response.access_token
