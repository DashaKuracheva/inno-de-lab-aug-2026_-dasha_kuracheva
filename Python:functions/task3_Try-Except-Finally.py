from typing import Any

DEFAULT_RETURN_INDEX_BASE = 10.0

def calculate_overdue_fine(
    movie_name: str,
    days_overdue: Any,
    fine_rate: float
) -> tuple[float, float] | None:

    """Рассчитывает штраф за просрочку возврата фильма и индекс оборачиваемости

    Обрабатывает следующие ошибки входных данных:
        TypeError: данные невозможно преобразовать в число (например, передан список)
        ValueError: строковое значение не является числом (например, "пять")
        ZeroDivisionError: нулевое количество дней (деление на ноль)

    Args:
        movie_name (str): Название фильмадля возврата билета
        days_overdue (Any): Количество дней просрочки(ожидается число или строка)
        fine_rate (float): Ставка штрафа за один день просрочки в долларах

    Returns:
        tuple[float, float] | None: Кортеж (total_fine, return_index) при
        успешном расчете, либо None, если во входных данных произошла
        одна из обрабатываемых ошибок.
    """

    result: tuple[float, float] | None = None

    try:
        numeric_days = float(days_overdue)
        total_fine = numeric_days * fine_rate
        return_index = DEFAULT_RETURN_INDEX_BASE / numeric_days
        result = (total_fine, return_index)

        print(f"Фильм: '{movie_name}' | Итоговый штраф: {total_fine}$ | Индекс: {return_index}")
    except TypeError as error:
        print(f"[ОШИБКА ТИПА] Некорректный тип данных для '{movie_name}': {error}")
    except ValueError as error:
        print(f"[ОШИБКА ЗНАЧЕНИЯ] Невозможно преобразовать дни в число для '{movie_name}': {error}")
    except ZeroDivisionError as error:
        print(f"[ОШИБКА ДЕЛЕНИЯ НА НОЛЬ] Возврат без просрочки для '{movie_name}': {error}")
    finally:
        print("\n--- Проверка транзакции возврата завершена ---\n")

    return result

print("___ПРОВЕРКА ВОЗВРАТОВ___")
calculate_overdue_fine("Matrix", 5, 1.5)
calculate_overdue_fine("Inception", "пять", 2.0)
calculate_overdue_fine("Avatar", 0, 2.5)
calculate_overdue_fine("Interstellar", [3, ], 3.0)