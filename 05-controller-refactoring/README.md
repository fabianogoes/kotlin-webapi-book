# Controller Refactoring

[Home](../README.md)

Então depois de criamos toda nossa base da aplicação, vamos refatorar nosso controller para ficar na versão final e funcional.

a primeria coisa que precisamos fazer é injetar nossa service no construtor primario no controller assim como fizemos com a repository sendo injetada em nossa service.

```kotlin
@RestController
@RequestMapping("/accounts")
class AccountController(private val service: AccountService) {
    ...
}
```

agora vamos refatorar todos os nossos métodos:

## Create

```kotlin
@PostMapping
@ResponseStatus(HttpStatus.CREATED)
fun create(@RequestBody account: Account): Account = service.create(account)
```

## Read 

```kotlin
@GetMapping
fun getAll(): List<Account> = service.getAll()

@GetMapping("/{id}")
fun getById(@PathVariable id: Long) : ResponseEntity<Account> =
        service.getById(id).map {
            ResponseEntity.ok(it)
        }.orElse(ResponseEntity.notFound().build())
```

## Update

```kotlin
@PutMapping("/{id}")
fun update(@PathVariable id: Long, @RequestBody account: Account) : ResponseEntity<Account> =
        service.update(id, account).map {
            ResponseEntity.ok(it)
        }.orElse(ResponseEntity.notFound().build())
```

## Delete 

```kotlin
    @DeleteMapping("/{id}")
    fun delete(@PathVariable id: Long) : ResponseEntity<Void> {
        service.delete(id)
        return ResponseEntity<Void>(HttpStatus.OK)
    }
```

e assim temos nosssa versão final e funcional de nosso controlles passando por todas as camadas.

---

[Home](../README.md)

[Anterior](./04-service/README.md)

[Proximo](./05-controller-refactoring/README.md)