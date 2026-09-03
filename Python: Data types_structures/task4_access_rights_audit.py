# Список ролей, переданный в запросе на авторизацию (содержит повторы)
requested_roles = ["guest", "developer", "guest", "admin","developer", "guest"]

# Набор обязательных ролей для выполнения административных функций
required_admin_roles = {"admin", "security_officer", "audit_manager"}

unique_requested_roles = set(requested_roles)
print("Unique requested roles:", unique_requested_roles)

#role overlap
overlap_roles = required_admin_roles & unique_requested_roles
print("Common administrative roles:", overlap_roles)

#set difference
difference_roles = required_admin_roles - unique_requested_roles
print("Missing administrative roles:", difference_roles)

# presence of the security_officer role
security_officer = "security_officer" in unique_requested_roles
print("Presence of the security_officer role in the request:", security_officer)
