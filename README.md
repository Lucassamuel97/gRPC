# Projeto gRPC em Go

Este é um projeto de exemplo de uma API gRPC em Go utilizando o Evans como cliente para testar a API.

No gRPC, streams permitem que clientes e servidores enviem várias mensagens como parte de um único ciclo de requisição-resposta.

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
3. Executar o Evans no modo interativo (Contornando o erro pois o `docker attach evans` não seleciona o serviço gerando um erro).
```sh
docker-compose exec evans evans repl --host grpc-server --port 50051 --proto /proto/course_category.proto --package pb --service CategoryService
```

4. Interagir com o Evans no REPL
- Lista os serviços
```sh
    show service
```
- Selecionar o serviço:
```sh
    service CategoryService
```
- chamar um método (no exemplo: CreateCategory):
```sh
    call CreateCategory
```

5. tipos de streaming no gRPC:
- 5.1 Server Streaming (Streaming do Servidor):
    - O cliente envia uma única requisição para o servidor e recebe um fluxo de várias mensagens em resposta.
    - Exemplo: O cliente pede uma lista de Categorias e o servidor envia as categorias um por um.
    - Representação no proto:
    ```protobuf
        rpc GetCategories(CategoryListRequest) returns (stream Category);
    ```
- 5.2 Client Streaming (Streaming do Cliente):
    - O cliente envia um fluxo de várias mensagens para o servidor e recebe uma única resposta.
    - Exemplo: O cliente envia uma série de categorias para cadastrar e recebe a lista de categorias cadastradas no final. (No evans pressione Ctrl+D para encerrar a lista de envio).
    - Representação no proto:
    ```protobuf
        rpc CreateCategoryStream(stream CreateCategoryRequest) returns (CategoryList) {}
    ```
- 5.3 Bidirectional Streaming (Streaming Bidirecional):
    - Tanto o cliente quanto o servidor enviam um fluxo de mensagens entre si.
    - Exemplo: O cliente envia a categoria para cadastrar e o servidor já retorna a categoria cadastrada no mesmo fluxo.
    - Representação no proto:
    ```protobuf
        rpc CreateCategoryStreamBidirectional(stream CreateCategoryRequest) returns (stream Category) {}
    ```