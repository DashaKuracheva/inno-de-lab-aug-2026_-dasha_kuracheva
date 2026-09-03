import time
from functools import wraps
from typing import Any, Callable

TIME_DECIMALS = 8
PERFORMANCE_LOG_PREFIX = "[PERF_LOG]"

def performance_logger(func: Callable[..., Any]) -> Callable[..., Any]:

    """Декоратор для замера и логирования времени выполнения функции.

    Оборачивает целевую функцию, фиксирует момент начала работы
    через time.perf_counter(), после чего выводит сообщение
    с именем функции и затраченным временем в формате
    "[PERF_LOG] Функция '<имя>' выполнена за <время> сек.".

    Args:
        func (Callable[..., Any]): оборачиваемая функция,
            которая может принимать произвольные позиционные и
            именованные аргументы.

    Returns:
        Callable[..., Any]: функция-обёртка, которая при вызове
        выполняет func с переданными аргументами, логирует время
        выполнения и возвращает результат работы func.
    """

    @wraps(func)
    def wrapper(*args: Any, **kwargs: Any) -> Any:
        start_time = time.perf_counter()
        result = func(*args, **kwargs)
        full_time = round(time.perf_counter() - start_time, TIME_DECIMALS)
        print(f"{PERFORMANCE_LOG_PREFIX} Функция '{func.__name__}' выполнена за {full_time} сек.")
        return result

    return wrapper


@performance_logger
def get_sorted_report(genre_sales: list[dict[str, str | float]]) -> list[dict[str, str | float]]:

    """Сортирует отчет по выручке жанров в порядке убывания.

    Args:
        genre_sales (list[dict[str, str | float]]): список словарей,
            где каждый словарь содержит ключи "category" (str) и
            "total_sales" (float) — выручку по конкретному жанру.

    Returns:
        list[dict[str, str | float]]: список словарей, отсортированный
        по ключу "total_sales" по убыванию.
    """
    return sorted(genre_sales, key=lambda item: item["total_sales"], reverse=True)


def print_report(report: list[dict[str, str | float]]) -> None:

    """Печатает отсортированный отчет в консоль.

    Args:
        report (list[dict[str, str | float]]): отсортированный список
            словарей с данными по выручке жанров.

    Returns:
        None
    """
    print("Топ категорий по выручке:")
    for index, item in enumerate(report, start=1):
        print(f"{index}. {item['category']}: {item['total_sales']}")



dataset_1 = [
    {"category": "Action", "total_sales": 4311.85},
    {"category": "Animation", "total_sales": 4656.30},
    {"category": "Children", "total_sales": 3655.55},
]

dataset_2 = [
    {"category": "Classics", "total_sales": 1200.10},
    {"category": "Comedy", "total_sales": 4000.00},
    {"category": "Documentary", "total_sales": 4000.00},
]

dataset_3 = [
    {"category": "Drama", "total_sales": 500.00},
]

print("ТЕСТИРОВАНИЕ ПРОИЗВОДИТЕЛЬНОСТИ")

print("\n--- ТЕСТ 1 ---")
print_report(get_sorted_report(dataset_1))

print("\n--- ТЕСТ 2 ---")
print_report(get_sorted_report(dataset_2))

print("\n--- ТЕСТ 3 ---")
print_report(get_sorted_report(dataset_3))