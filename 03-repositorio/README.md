# Repositorio

[Home](../README.md)

A Repository é a parte mais simples porque aqui quem faz a magica é o Spring Data JPA.
Precisamos apenas de uma interface que extenda de `JpaRepository`.
Então, dentro do package `repository` crie uma interface Kotlin chamada `AccountRepository`

```kotlin
package com.eprogramar.bank.repository

import com.eprogramar.bank.model.Account
import org.springframework.data.jpa.repository.JpaRepository

interface AccountRepository : JpaRepository<Account, Long> {
}
```

Perceba que a interface deve extender de `JpaRepository` e usar a nossa classe de Modelo/Entidade `Account` seguido de `Long` que é o tipo do nosso atributo que leva a anottation `@Id`.

Feito isso, o Spring Data faz toda a magia e cria todos os métodos necessários para um `CRUD`

* **C**reate
* **R**ead
* **U**pdate
* **D**elete

Porém a interface não implementar nenhum método para consulta através de um atributo de nossa classe além do `id`.

Mas calma, ele não faz mas permite uma maneira muito simples para que façamos nós mesmo.
Imagine que queremos uma consulta pelo atributi `document` da nossa claase de modelo.

basta seguir uma convenção de `finBy` + o nome do atrabuto,
como aseguir: 

```kotlin
fun findByDocument(document: String): Optional<Account>
```

Então passamos como parametro o valor para a consulta.
E retornamos um `Optional` do java.util de nossa classse de modelo `Account`.
Se a consulta retornar uma `Account` bastar fazer um `.get` no optional e para verificar se ter vamos no retorno da consulta usamdo `.isPresent`.

Sem muitas delongas, daria para falarmos muita coisa sobre **Spring Data JPA** mas por hora, para nosso exemplo já é suficiente.

Nossa interface final fica assim:

```kotlin
package com.eprogramar.bank.repository

import com.eprogramar.bank.model.Account
import org.springframework.data.jpa.repository.JpaRepository
import java.util.*

interface AccountRepository : JpaRepository<Account, Long> {

    fun findByDocument(document: String): Optional<Account>

}
```

---
[Home](../README.md)

[Anterior](../02-controller/README.md)

[Proximo](../04-service/README.md)
