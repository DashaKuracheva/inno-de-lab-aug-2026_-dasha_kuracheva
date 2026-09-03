# Список транзакций, полученных от платежного шлюза
raw_transactions = ["SUCCESS:100", "FAILED:50", "SUCCESS:-10",
"SUCCESS:0", "SUCCESS:250", "ERROR:200"]

# Реализация фильтрации в одну строку с помощью List Comprehension
clean_transactions = [int(t.split(":")[1]) for t in raw_transactions
                      if t.split(":")[0] == "SUCCESS" and int(t.split(":")[1]) > 0 ]

print(f"Cleared transactions: {clean_transactions}")