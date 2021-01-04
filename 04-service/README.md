# Service

[Home](../README.md)

Agora vamos criar a nossa classe `Service` que é onde deveria ficar toda regra de negócio da nossa aplicação.
No nosso caso temos uma aplicação bem simples mas essa é uma estrutura já pronta para a evolução da aplicação.

Vamos começão criando no package `service` uma classe Kotlin chamada `AccountService` e no construtor primário vamos injetar nossa `repository` como um atributo readonly privado, veja como deve ficar a estrutura inicial:

```kotlin
@Service
class AccountService(private val repository: AccountRepository) {

}
```

Perceba que usamos a Annotation `@Service` sobre nossa classe.

Então vamos começar criando nossos métodos `CRUD`.

## Regra Cread

```kotlin
override fun create(account: Account): Account {
    return repository.save(account)
}
```  

## Regra Read

```kotlin
override fun getAll(): List<Account> {
    return repository.findAll()
}

override fun getById(id: Long): Optional<Account> {
    return repository.findById(id)
}
```

## Regra Update

```kotlin
override fun update(id: Long, account: Account): Optional<Account> {
    val optional = getById(id)
    if (optional.isEmpty) {
        return optional
    }

    return optional.map {
        val accountToUpdate = it.copy(
            name = account.name,
            document = account.document,
            phone = account.phone
        )
        repository.save(accountToUpdate)
    }
}
```

## Regra Delete

```kotlin
override fun delete(id: Long) {
    repository.findById(id).map {
        repository.delete(it)
    }.orElseThrow { throw RuntimeException("Id not found $id") }

}
```

