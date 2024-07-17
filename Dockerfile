# Usar a imagem base oficial do Go
FROM golang:1.18

# Definir o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copiar go.mod e go.sum e baixar as dependências
COPY go.mod go.sum ./
RUN go mod download

# Copiar o restante do código-fonte para o diretório de trabalho
COPY . .

# Compilar o binário do servidor gRPC
RUN go build -o /grpcServer ./cmd/grpcServer

# Expor a porta gRPC
EXPOSE 50051

# Comando para rodar o servidor gRPC
CMD ["/grpcServer"]