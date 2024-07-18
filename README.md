# Projeto gRPC em Go

Este é um projeto de exemplo de uma API gRPC em Go utilizando o Evans como cliente para testar a API. 

## Requisitos

- Docker
- Docker Compose

## Como iniciar o projeto

1. Clone o repositório:

```sh
git clone https://github.com/Lucassamuel97/gRPC.git
cd gRPC
```
2. Inicie o projeto:
```sh
docker-compose up --build
```
3. Executar o Evans no modo interativo
```sh
docker-compose exec evans evans repl --host grpc-server --port 50051 --proto /proto/course_category.proto --package pb --service CategoryService
```

4. Interagir com o Evans no REPL
Lista os serviços
```sh
    show service
```
Selecionar o serviço:
```sh
    service CategoryService
```
chamar um método (no exemplo: CreateCategory):
```sh
    call CreateCategory
```