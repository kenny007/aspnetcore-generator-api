FROM microsoft/dotnet:2-runtime

WORKDIR /app
COPY bin/Debug/netcoreapp2.0/publish .

ENTRYPOINT ["dotnet", "api.dll"]