# Поток данных телеметрии от серверов кластера
system_telemetry = [
    ("srv_01", 12.5, 64, "online"),
    ("srv_02", 85.0, 92, "online"),
    ("srv_03", 0.0, 0, "offline"),
    ("srv_04", 45.2, 78, "online"),
    ("srv_05", 95.1, 99, "online")
]

# Unpacking tuples + filtering offline servers
active_servers = [
    (node_name, cpu_load, ram_usage)
    for node_name, cpu_load, ram_usage, status in system_telemetry
    if status == "online"
]

# Active services
active_node_names = [node_name for node_name, cpu_load, ram_usage in active_servers]
print("Active nodes in the network:", active_node_names)

# Create separate lists of indicators for aggregation functions
cpu_loads = [cpu_load for node_name, cpu_load, ram_usage in active_servers]
ram_usages = [ram_usage for node_name, cpu_load, ram_usage in active_servers]

# Summary indicators
active_nodes_count = len(active_node_names)
average_cpu = round(sum(cpu_loads) / active_nodes_count, 2)
max_ram = max(ram_usages)

# Resulting nested dictionary
telemetry_report = {
    "active_nodes_count": active_nodes_count,
    "metrics": {
        "average_cpu": average_cpu,
        "max_ram": max_ram
    }
}
print("Final telemetry report:")
print(telemetry_report)