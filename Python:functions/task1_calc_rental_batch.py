MAX_RENTAL_BATCH_LIMIT = 150.0

def calculate_rental_batch(
    quantity: int,
    rental_rate: float,
    discount: float = 0.0
) -> tuple[float, bool]:
    """Рассчитывает итоговую стоимость партии аренды дисков и проверяет
    превышение лимита автоматического одобрения

    Args:
        quantity (int): количество дисков в партии.
        rental_rate (float): стоимость аренды одного диска.
        discount (float, optional): акидка на партию в виде доли(по умолчанию 0.0)

    Returns:
        tuple[float, bool]: кортеж; первый элемент — итоговая сумма(округленная до 2х знаков),
         второй — флаг превышения MAX_RENTAL_BATCH_LIMIT.
    """
    final_sum = round(quantity * rental_rate * (1 - discount), 2)
    is_limit_exceeded = final_sum > MAX_RENTAL_BATCH_LIMIT
    return final_sum, is_limit_exceeded


print("=== ОТЧЕТ ПО ПАРТИЯМ АРЕНДЫ ===")

# Вызов с позиционными аргументами
sum1, exceeded1 = calculate_rental_batch(30, 2.99)
print(f"Партия 1 (Academy Dinosaur): Сумма {sum1}$. Превышение лимита: {exceeded1}")

sum2, exceeded2 = calculate_rental_batch(40, 4.99, 0.10)
print(f"Партия 2 (Affair Prejudice): Сумма {sum2}$. Превышение лимита: {exceeded2}")

# Вызов с именованными аргументами
sum3, exceeded3 = calculate_rental_batch( quantity=10, rental_rate=1.99)
print(f"Партия 3 (Agent Truman): Сумма {sum3}$. Превышение лимита: {exceeded3}")

sum4, exceeded4 = calculate_rental_batch(quantity=50, rental_rate=3.50, discount=0.20)
print(f"Партия 4 (African Egg): Сумма {sum4}$. Превышение лимита: {exceeded4}")