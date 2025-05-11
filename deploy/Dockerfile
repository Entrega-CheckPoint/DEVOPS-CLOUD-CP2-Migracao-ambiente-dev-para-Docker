# Etapa única: somente runtime (imagem pequena)
FROM mcr.microsoft.com/dotnet/aspnet:8.0

# Define o diretório de trabalho dentro do container
WORKDIR /app

# Copia os arquivos publicados da máquina para o container
COPY . .

# Expor a porta 80 para acesso externo
EXPOSE 80

# Comando para iniciar a aplicação
ENTRYPOINT ["dotnet", "mottu.dll"]
