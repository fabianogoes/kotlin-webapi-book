# Controller

[Home](../README.md)

Com a estrutura já criada agora vamos começar criar nosso Controller,
dentro do package `controller` crie uma classe Kotlin chamada `AccountController`

e Logo em cima da classe vamos anotar para que ela se comporte como um `Controller` e que exponha nossos endpoints através do recurso: `accounts`

```kotlin
@RestController
@RequestMapping("/accounts")
class AccountController() {

}
```

Vamos aproveitar e já criar nossa classe de modelo a qual usaremos como parametro nossos metodos e já será a nossa Entidade de persistencia.   
Dentro do package `model` crie uma classe Kotlin chamada `Account`

```kotlin
@Entity(name = "accounts")
data class Account(
        @Id @GeneratedValue
        var id: Long? = null,
        val name: String,
        val document: String,
        val phone: String
)
```

`@Entity` Diz que nossa classe será uma entidade JPA que fará o a parte Objeto relacional entre nossa classe e nossa tabela no Banco de dados.   
`@Id` Essa diz que o atributo será a chave primára da nossa classe.   
`@GeneratedValue` Aqui falamos para o banco de dados gerar automáticamente nossos `ids` o famoso `AutoIncremento`.

## Create

Com nossao modelo criado e a classe de Controleler criada e já configurada, podemos começar a criar nossos endpoints/rotas:

```kotlin
@PostMapping
@ResponseStatus(HttpStatus.CREATED)
fun create(@RequestBody account: Account): Account = account
```

Então, temos uma função que recebe por paramentro nossa classe de modelo e apenas develvemos o proprio parametro `account` isso até criarmos nossas outras camadas `repository` e `service`.

`@PostMapping` essa annottation diz que essa função so respondera através das requisições chegadas pelo método `HTTP POST`.

`@ResponseStatus(HttpStatus.CREATED)` essa estamos marcando que essa função sempre retornara `HTTP STATUS` 201(Created) ao menos que aconteça algum erro.

`@RequestBody` Essa annottation é necessária para poder receber nossa claase de modelo como `JSON` e deixar o Spring fazer o Parse para nossa própria classe, assim não precisamos ficar manipulando o `JSON` e trabalhamos diretamente com nossa classe tipada o que evita muitos problemas.


## Read

Agora vamos preparar nossa rota de GET que irá listar todas as contas:

```kotlin
@GetMapping
fun getAll(): List<Account> = emptyList<Account>()
```

Por enquanto estamos retornando uma lista vazia porque não temos ainda nossa camada de negócio e repositorio.
Essa rota é bem simples, apenas recebe a Annotation `@GetMapping` para esta função responder apenas as requisições de `GET` sobre nosso recurso principal `accounts`

podemos também criam uma outra rota de `GET` que porem será passada com um Parametro na Path assim esta rota apesar de também ser um `GET` ela se diferencia da outra por ter um parametro:

```kotlin
@GetMapping("/{id}")
fun getById(@PathVariable id: Long) : ResponseEntity<Account> =
    ResponseEntity.ok().body(null)
```

Bom, estamos por enquanto fazendo tudo bem simples, neste caso retornando um `body` null apenas para ter a rota depois vamos evoluir criando uma consulta pelo parametro que será passado.

## Update

Vamos seguindo agora com a nossa rota de `Update`

```kotlin
@PutMapping("/{id}")
fun update(@PathVariable id: Long, @RequestBody account: Account) : ResponseEntity<Account> = 
    ResponseEntity.ok().body(null)
```
Aqui criamos uma função que responderá pelo `HTTP PUT` com um parametro na Path e um body assim como fizemos no método `create` e também estamos retornando nullo porque não temos nossa camada de persistencia para ser atualizada. Já já vamos enriquecer nossas rotas com dados reais.

## Delete

Finalizando nossas rotas com uma função que responderá sobre o método `HTTP DELETE` sobre nossa rota principal `accounts/id` então assim nas outras rotas receberemos apenas um parametro na Path que usaremos para buscar no banco de dados e deletar.

```kotlin
@DeleteMapping("/{id}")
fun delete(@PathVariable id: Long) : ResponseEntity<Void> {
    service.delete(id)
    return ResponseEntity<Void>(HttpStatus.OK)
}
```

---
[Home](../README.md)

[Anterior](../01-projeto/README.md)

[Proximo](../03-repositorio/README.md)