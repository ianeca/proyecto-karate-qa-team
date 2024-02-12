@automation-api
Feature: Funcionalidad registro
  Scenario:  Usuario Existente
    Given url urlBase
    And path 'api/register'
    And request {email: "qateam@gmail.com", password: "12345678", nombre:"Carlos", tipo_usuario_id: "1"}
    When method post
    Then status 500
    And match response.email[0] == "The email has already been taken."


  Scenario:  Usuario con contraseña menor a 8 caracteres
    Given url urlBase
    And path 'api/register'
    And request {email: "qateam2222@gmail.com", password: "1234567", nombre:"Carlos", tipo_usuario_id: "1"}
    When method post
    Then status 500
    And match response.password[0] == "The password must be at least 8 characters."


  Scenario:  Usuario Nuevo
    Given url urlBase
    And path 'api/register'
    And request {email: "holaaaaa@gmail.com", password: "12345678", nombre: "Janeth", tipo_usuario_id: "1", estado: "1" }
    When method post
    Then status 200
