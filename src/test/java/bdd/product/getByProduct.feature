@automation-api
Feature: Funcionalidad Listar Producto por id
  Background:
    * def responseLogin = call read('classpath:bdd/auth/loginAuth.feature@login')
    * def token = responseLogin.token
    * header Authorization = 'Bearer ' + token
    And url urlBase

  @setup
  Scenario: data
    * def data = read('classpath:resources/json/product/data.json')

  Scenario Outline: Listar Producto Existente
    Given path '/api/v1/producto/' + <id>
    When method GET
    Then status 200
    And match $.categoria == "Repuestos"
    And match $.marca == "Generico"
    Examples:
      | karate.setup().data|

  Scenario: Listar Producto Inexistente
    * def id = 9999
    And path '/api/v1/producto/' + id
    When method get
    * print response
    Then status 404
    And match response.error == "Producto no encontrado"