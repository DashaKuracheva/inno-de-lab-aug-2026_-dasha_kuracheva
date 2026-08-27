# Normalization and assembly of user records
# Исходная необработанная строка из источника данных
raw_user_record = " 10827 ; aLeXanDer_vLaDimiRov ; mInSk ; ACTIVE "

# Splitting a string into individual elements
split_raw_user_record = raw_user_record.split(';')

# Clearing up gaps
user_record = [part.strip() for part in split_raw_user_record]

# Unpack the cleared elements into separate variables
user_id, user_name, user_city, user_status = user_record

user_id = f"UID - {user_id}"
user_name = user_name.replace("_", " ").title()
user_city = user_city.upper()
user_status = user_status.lower()

# Final string separated by the "|"
new_raw_user_record =" | ".join([user_id, user_name, user_city, user_status])
print(f"Нормализованная запись: {new_raw_user_record}")


