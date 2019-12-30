# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version - Rails 6.0.2

 Para executar o projeto utilize o comando
```
rails server
```

 Para executar os testes utilize o comanndo
 ```
 rspec
 ```

 Este projeto utiliza as gems abaixo para executar os testes
 gem 'rspec-rails', '~> 3.9'
 gem 'capybara', '~> 3.29'

Este projeto utiliza a gem 'devise' para autenticar o usuário

Headhunter pode criar comentario para todos os candidatos, inscritos ou não em uma vaga.
Headhunter destaca perfil com uma estrela preenchida, e tira o destaque colocado uma estrela vazia.
Ao encerrar uma vaga é enviado automaticamente um feedback padrao para os os candidatos que ainda não tiveram uma devolutiva (proposta ou rejeição).

Uma vaga só fica disponível para busca se não for encerrada, ou se a data final para inscrição for maior que hoje.

