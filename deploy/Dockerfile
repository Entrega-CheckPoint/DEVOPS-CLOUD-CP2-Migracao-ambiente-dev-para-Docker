# Etapa 1: Build da aplicação
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copia os arquivos do projeto para dentro do container
COPY . . 

# Restaura as dependências (pacotes NuGet)
RUN dotnet restore

# Compila a aplicação
RUN dotnet publish -c Release -o out

# Etapa 2: Criação da imagem final (runtime apenas)
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

# Copia o que foi compilado na etapa anterior
COPY --from=build /app/out .

# Porta exposta (muda se quiser outra porta)
EXPOSE 80

# Comando para iniciar a aplicação
ENTRYPOINT ["dotnet", "mottu.dll"]
