@automation-api
Feature: Funcionalidad Añadir Producto
    Background:
        * def responseLogin = call read('classpath:bdd/auth/loginAuth.feature@login')
        * def token = responseLogin.token
        * header Authorization = 'Bearer ' + token
        And url urlBase

    Scenario Outline: Añadir Producto
        And path 'api/v1/producto/'
        And request {codigo: <codigo>, nombre: <nombre>, medida: <medida>,marca: <marca>, categoria: <categoria>, precio: <precio>,stock: <stock>, estado: <estado>, descripcion: <descripcion>}
        When method post
        * print response
        Then status 200
        And match response.codigo == "<codigo>"
        And match response.nombre == "<nombre>"
        And match response.medida == "<medida>"
        And match response.precio == <precio>
        And match response.stock  == <stock>
        And match response.estado == <estado>
        And match response.descripcion == "<descripcion>"
        Examples:
            | read('classpath:resources/csv/product/addProduct.csv') |

    #No se puede hacer match por error de SQL
    Scenario: Añadir Producto Existente
        And path 'api/v1/producto/'
        And request read('classpath:resources/json/product/addProduct.json')
        When method post
        * print response
        Then status 500
        And match response.error == "#string"


    #No se puede hacer match por error de SQL
    Scenario: Añadir Producto con un código de mas de 6 digitos
        And path 'api/v1/producto/'
        And request read('classpath:resources/json/product/addProductTooLong.json')
        When method post
        * print response
        Then status 500
        And match response.error == "#string"

    Scenario: Añadir Producto con campos vacios
        And path 'api/v1/producto/'
        And request read('classpath:resources/csv/product/addProductEmpty.csv')
        When method post
        * print response
        Then status 500
        And match response.codigo == ["The codigo field is required."]
        And match response.nombre == ["The nombre field is required."]
        And match response.medida == ["The medida field is required."]
        And match response.marca  == ["The marca field is required."]
        And match response.categoria == ["The categoria field is required."]
        And match response.precio == ["The precio field is required."]
        And match response.stock  == ["The stock field is required."]
        And match response.estado == ["The estado field is required."]
        And match response.descripcion == ["The descripcion field is required."]