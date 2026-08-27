# Конфигурационный словарь, полученный от сервиса инициализации
db_config = {
    "connection": {
        "host": "production-db.internal",
        "port": 5432,
        "user": "postgres"
    }
}

# Extracting the connection dictionary
# If there is no connection key, an empty dictionary is returned
connection = db_config.get("connection", {})

host = connection.get("host")
port = connection.get("port")

# Check for the presence of ssl_settings and the nested ssl_mode
ssl = db_config.get("ssl_settings", {})
ssl_mode = ssl.get("ssl_mode", "verify-full")
print("SSL Mode:", ssl_mode)

connection["user"]= "admin"
connection["max_connections"] = 100

print ("Connection parameters:")
for key, value in connection.items():
    print(f"{key}: {value}")




