FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build

WORKDIR /src

COPY . .

RUN dotnet restore "BlazingPizza.csproj"

RUN dotnet build "BlazingPizza.csproj" -c Release -o /app/build

RUN dotnet publish "BlazingPizza.csproj" -c Release -o /app/public

FROM mcr.microsoft.com/dotnet/aspnet:6.0

WORKDIR /app

COPY --from=build /app/public .

EXPOSE 5000

ENTRYPOINT ["dotnet", "BlazingPizza.dll", "--urls", "http://0.0.0.0:5000"]