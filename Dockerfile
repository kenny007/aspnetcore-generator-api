# Build stage
FROM microsoft/dotnet:2.2-sdk AS build-env

WORKDIR generator

# restore
COPY api/api.csproj ./api/
RUN dotnet restore api/api.csproj

COPY tests/tests.csproj ./tests/
RUN dotnet restore tests/tests.csproj

# copy src, copy source code * in the build context into the current working directory
COPY . .

# test
ENV TEAMCITY_PROJECT_NAME=fake
RUN dotnet test tests/tests.csproj
# publish, this publishes api and outputs to publish
RUN dotnet publish api/api.csproj -o /publish

# Runtime stage
FROM microsoft/dotnet:2.2-runtime
COPY --from=build-env /publish /publish
WORKDIR /publish
ENTRYPOINT ["dotnet", "api.dll"]












