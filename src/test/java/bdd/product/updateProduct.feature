@automation-api
Feature: Funcionalidad Actualizar Producto
  Background:
    * def responseLogin = call read('classpath:bdd/auth/loginAuth.feature@login')
    * def token = responseLogin.token
    * header Authorization = 'Bearer ' + token
    And url urlBase

#Campo codigo no se actualiza en el postman
  Scenario: Actualizar Producto
    * def id = 3
    And path '/api/v1/producto/' + id
    And request read('classpath:resources/json/product/updateProduct.json')
    When method put
    * print response
    Then status 200
    #Siguiente linea no hace match
    And match response.codigo == read('classpath:resources/json/product/updateProduct.json').codigo
    And match response.nombre == read('classpath:resources/json/product/updateProduct.json').nombre
    And match response.precio == read('classpath:resources/json/product/updateProduct.json').precio
    And match response.stock  == read('classpath:resources/json/product/updateProduct.json').stock

  Scenario: Actualizar producto inexistente
    * def id = 99999
    And path '/api/v1/producto/' + id
    And request read('classpath:resources/json/product/updateProduct.json')
    When method put
    * print response
    Then status 500
    And match response.error == "Call to a member function update() on null"