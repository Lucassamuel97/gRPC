# Usar a imagem base oficial do Go
FROM golang:1.21

# Instalar protoc e o plugin protoc-gen-go e protoc-gen-go-grpc
RUN apt-get update && apt-get install -y protobuf-compiler
RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
RUN go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest

# Definir o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copiar go.mod e go.sum e baixar as dependências
COPY go.mod go.sum ./
RUN go mod download

# Copiar o restante do código-fonte para o diretório de trabalho
COPY . .

# Gerar os arquivos Go a partir dos arquivos proto
RUN protoc --go_out=. --go-grpc_out=. proto/course_category.proto

# Compilar o binário do servidor gRPC
RUN go build -o /grpcServer ./cmd/grpcServer

# Expor a porta gRPC
EXPOSE 50051

# Comando para rodar o servidor gRPC
CMD ["/grpcServer"]