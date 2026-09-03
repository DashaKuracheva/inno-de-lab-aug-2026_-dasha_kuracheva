"""
Класс Trainee:
    - хранит информацию о стажере (имя, фамилия)
    - фиксирует посещение лекций и выполнение домашних заданий
    - автоматически пересчитывает рейтинг (score)
    - проверяет, набрал ли стажер проходной балл (passing_grade)
    - защищает балл от некорректных значений (отрицательное число,
      неверный тип данных)
"""

class Trainee:
    def __init__(
            self,
            name: str,
            surname: str,
            score: int = 0,
            passing_grade: int = 10,
    ) -> None:
        """
        Args:
            name: имя стажера
            surname: фамилия стажера
            score: начальный балл стажера(по умолчанию 0)
            passing_grade: Проходной балл, необходимый для завершения
                            курса(по умолчанию 10)
        """

        # публичные атрибуты
        self.name: str = name
        self.surname: str = surname
        self.passing_grade: int = passing_grade

        # приватный атрибут
        # значение задается через setter
        self.__score: int = 0
        self.score = score

    @property
    def score(self) -> int:
        """
        геттер score

        Возвращает текущее значение приватного атрибута __score.
        """
        return self.__score

    @score.setter
    def score(self, value: int) -> None:
        """
        сеттер  score

        Вызывается при любом присваивании trainee.score = <значение>,

        Args:
            value: Новое значение балла, которое нужно проверить
               и сохранить, если оно корректно

        Raises:
            ValueError: если value не является int, либо если
                value меньше 0.
        """

        # проверка типа
        if type(value) is not int:
            raise ValueError(f"Expected value of type int, got {type(value)}")
        # проверка диапазона
        if value < 0:
            raise ValueError("The score shouldn't be less than 0!")
        # если обе проверки пройдены, то обновляем приватный атрибут
        self.__score = value


    # методы изменения успеваемости
    def do_homework(self) -> None:
        """Increases score by 1"""
        # +1 к текущему баллу за выполненное домашнее задание
        self.score += 1

    def miss_homework(self) -> None:
        """Decreases score by 1"""
        # -1 к текущему баллу за пропущенное домашнее задание
        self.score -= 1

    def visit_lecture(self) -> None:
        """Increases score by 1"""
        # +1 к текущему баллу за посещение лекции
        self.score += 1

    def miss_lecture(self) -> None:
        """Decreases score by 1"""
        # -1 к текущему баллу за пропуск лекции
        self.score -= 1

    # проверка статуса прохождения курса
    def is_passing(self) -> bool:
        return self.score >= self.passing_grade


class HardworkingTrainee(Trainee):
    def do_homework(self) -> None:
        """Increases score by 2"""
        # трудоголик получает +2 балла
        self.score += 2


class AuditTrainee(Trainee):
    def is_passing(self) -> bool:
        return True


class Cohort:
    def __init__(self, title: str) -> None:
        """
        Args:
            title: название учебной группы
        """
        self.title: str = title
        self.trainees: list[Trainee] = []

    def add_trainee(self, trainee: Trainee) -> None:
        """Добавляет учащегося в группу"""
        self.trainees.append(trainee)

    def conduct_lecture(self) -> None:
        """Проведение лекции для группы"""
        for trainee in self.trainees:
            trainee.visit_lecture()

    def get_passing_students(self) -> list[Trainee]:
        """Список учащхся, успешно проходящих курс"""
        return [trainee for trainee in self.trainees if trainee.is_passing()]

#задание 1
print("ПРОВЕРКА УСПЕВАЕМОСТИ СТАЖЕРА")

# 1. Создание стажера с начальным баллом 9 и проходным баллом 10
trainee = Trainee(name="Иван", surname="Иванов", score=9, passing_grade=10)

# 2. Выполнение домашнего задания и проверка статуса
trainee.do_homework()
print(f"Баллы: {trainee.score}, Прошел курс: {trainee.is_passing()}")

# 3. Пропуск лекции и проверка статуса
trainee.miss_lecture()
print(f"Баллы: {trainee.score}, Прошел курс: {trainee.is_passing()}")

# 4. Проверка валидации (попытка задать неверный тип или отрицательное значение)
try:
    trainee.score = -5
except ValueError as e:
    print(f"Ошибка: {e}")

print()
#задание 2

# 1. Создаем учащихся разных типов
std_trainee = Trainee("Алексей", "Смирнов", score=8, passing_grade=10)
hard_trainee = HardworkingTrainee("Елена", "Петрова", score=8,passing_grade=10)
audit_trainee = AuditTrainee("Дмитрий", "Сидоров", score=0,passing_grade=10)

# 2. Создаем группу и добавляем студентов
cohort = Cohort("Python Advanced")
cohort.add_trainee(std_trainee)
cohort.add_trainee(hard_trainee)
cohort.add_trainee(audit_trainee)

# 3. Проводим лекцию для всей группы (+1 балл всем)
cohort.conduct_lecture()

# 4. Проверяем работу переопределенного ДЗ для трудоголика (+2 балла)
hard_trainee.do_homework()

# 5. Выводим список тех, кто проходит курс
passing_students = cohort.get_passing_students()
print(f"=== УСПЕВАЕМОСТЬ ГРУППЫ '{cohort.title}' ===")
for student in cohort.trainees:
    print(
        f"{student.name} {student.surname} | "
        f"Баллы: {student.score} | "
        f"Проходит: {student.is_passing()}"
    )
print("\nУспешно зачислены на следующий модуль:")
for student in passing_students:
    print(f"- {student.name} {student.surname}")







