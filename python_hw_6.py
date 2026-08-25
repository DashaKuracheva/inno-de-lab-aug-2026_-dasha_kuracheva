##All tasks are completed using match-case: select the task number in the menu,
## and the corresponding function is launched.

import random

## Task 1: greetings
def greetings_func():
    name = input("What is your name?\n")

    print(f"Hello {name}! Nice to meet you!")


# function for entering both int and float
def get_number(prompt):
    value = input(prompt).replace(",", ".")

    if value.lower() == "q":
        return None

    try:
        return int(value)
    except ValueError:
        try:
            return float(value)
        except ValueError:
            return "error"


## Task 2: area of a rectangle
def area_func():
    length = get_number("Input the length of the rectangle: ")
    width = get_number("Input the width of the rectangle: ")

    print(f"The area of the rectangle: {length * width}")


## Task 3: temperature converter
def temp_converter_func():
    temp = get_number("Input the temperature in Celsius: ")
    farenheit = (temp * 9 / 5) + 32

    print(f"{temp}°C is {farenheit}°F ")


## Task 4: checking if a number is even
def even_check_func():
    number = int(input("Input the number: "))

    if number % 2 == 0:
        print(f"Number {number} is even")
    else:
        print(f"Number {number} is odd")


## Task 5: game "Guess the number"
def game_func():
    random_num = random.randint(1, 20)
    attempts = 5

    print(f"I thought of a number between 1 and 20. You have {attempts} attempts!")

    while attempts > 0:
        guess_num = int(input(f"Attempt {6 - attempts}. Enter the number:"))

        if guess_num == random_num:
            print("You guessed it! Great job.")
            break
        elif guess_num > random_num:
            attempts -= 1
            print(f"Too many! Remaining attempts: {attempts}")
        else:
            attempts -= 1
            print(f"Too few! Remaining attempts: {attempts}")

        if attempts == 0:
            print(f"Attempts ended. The number was: {random_num}")


## Task 6: calculator
def calculator_func():
    print("\n___Calculator___\n")

    while True:
        print("Enter 'q' to exit")

        num1 = get_number("Enter the first number: ")

        if num1 is None:
            print("Exit calculator.")
            break

        if num1 == "error":
            print("Error: please enter a valid number!")
            continue

        num2 = get_number("Enter the second number: ")

        if num2 is None:
            print("Exit calculator.")
            break

        if num2 == "error":
            print("Error: please enter a valid number!")
            continue

        operator = input(
            "Select operator (+, -, *, /, //, %, **): "
        )

        if operator.lower() == "q":
            print("Exit calculator.")
            break

        match operator:
            case "+":
                result = num1 + num2

            case "-":
                result = num1 - num2

            case "*":
                result = num1 * num2

            case "/":
                if num2 == 0:
                    print("Error: division by zero!")
                    continue

                result = num1 / num2

            case "//":
                if num2 == 0:
                    print("Error: division by zero!")
                    continue

                result = num1 // num2

            case "%":
                if num2 == 0:
                    print("Error: division by zero!")
                    continue

                result = num1 % num2

            case "**":
                result = num1 ** num2

            case _:
                print("Unknown operator!")
                continue

        print(f"Result: {num1} {operator} {num2} = {result}\n")


while True:
    print("\n Homework Menu")
    print("1 - Greeting")
    print("2 - Area of a rectangle")
    print("3 - Temperature converter")
    print("4 - Checking if a number is even")
    print("5 - Guess the number game")
    print("6 - Calculator (optional)")
    print("0 - Exit")

    choice = input("Select job number: ")

    match choice:
        case "1":
            greetings_func()

        case "2":
            area_func()

        case "3":
            temp_converter_func()

        case "4":
            even_check_func()

        case "5":
            game_func()

        case "6":
            calculator_func()

        case "0":
            print("Bye!")
            break

        case _:
            print("There is no such item, try again")









