import random
from itertools import permutations, product

def generate_weight():
    income = random.randint(1, 20)  # Доход от 1 до 20
    education_coeff = random.randint(60, 100)  # Коэффициент обученности от 60 до 100
    social_demographic = random.randint(50, 90)  # Социально-демографическая характеристика от 50 до 90
    return (income, education_coeff, social_demographic)

def generate_paths(instructors, groups, methods):
    paths_with_weights = []
    for instructor in instructors:
        for method in methods:
            for group in groups:
                path = (instructor, method, group)
                weight = generate_weight()  # Генерация веса для пути
                paths_with_weights.append((path, weight))  # Сохраняем путь с весом
    return paths_with_weights

def generate_all_combinations(instructors, groups, methods):
    all_combinations = []
    for perm in permutations(instructors, len(groups)):
        for method_combination in product(methods, repeat=len(groups)):
            solution = {}
            for i in range(len(groups)):
                solution[groups[i]] = (perm[i], method_combination[i])
            all_combinations.append(solution)
    return all_combinations

def generate_solutions(instructors, groups, methods):
    paths_with_weights = generate_paths(instructors, groups, methods)
    all_combinations = generate_all_combinations(instructors, groups, methods)
    solutions = []

    # Вывод всех путей и их весов
    print("\nВсе пути (инструктор, метод, группа) и их веса:")
    for path, weight in paths_with_weights:
        print(f"Путь: {path}, вес: {weight}")

    for index, solution in enumerate(all_combinations):
        weight_sum = [0, 0, 0]  # Для хранения весов по критериям
        for group, (instructor, method) in solution.items():
            for path, weight in paths_with_weights:
                if path[0] == instructor and path[1] == method and path[2] == group:
                    weight_sum[0] += weight[0]
                    weight_sum[1] += weight[1]
                    weight_sum[2] += weight[2]

        solution_name = f"x{index}" if index > 0 else "x"
        solutions.append((solution_name, tuple(weight_sum)))  # Сохраняем имя и веса
    return solutions

# Новый метод сравнения
def compare_solutions(solution1, solution2):
    """
    Функция сравнивает два решения. Если первое решение полностью доминируется вторым (т.е. все параметры первого
    решения меньше или равны параметрам второго), то возвращает True, иначе False.
    """
    return all(s2 > s1 for s1, s2 in zip(solution1, solution2))

# Обновленный метод поиска оптимальных решений
def find_optimal_solutions(solutions):
    """
    Функция находит оптимальные решения по принципу доминирования. Если решение доминируется другим, оно удаляется.
    """
    remaining_solutions = solutions[:]  # Копируем список решений
    i = 0

    # Проходим по решениям и сравниваем каждое с каждым
    while i < len(remaining_solutions):
        current_solution = remaining_solutions[i][1]  # Вес текущего решения
        to_remove = None

        # Сравниваем текущее решение с каждым последующим
        for j in range(i + 1, len(remaining_solutions)):
            next_solution = remaining_solutions[j][1]  # Вес следующего решения

            if compare_solutions(current_solution, next_solution):
                # Если текущее решение хуже по всем параметрам, удаляем текущее решение
                to_remove = i
                break
            elif compare_solutions(next_solution, current_solution):
                # Если следующее решение хуже по всем параметрам, удаляем следующее решение
                to_remove = j

        # Удаляем доминируемое решение, если нашли
        if to_remove is not None:
            remaining_solutions.pop(to_remove)
        else:
            # Если текущее решение не доминируется, переходим к следующему
            i += 1

    return remaining_solutions

def main():
    while True:
        num_instructors = int(input("Введите количество инструкторов: "))
        num_groups = int(input("Введите количество групп: "))
        num_methods = int(input("Введите количество методов обучения: "))

        if num_instructors < num_groups:
            print("Ошибка: Программа требует, чтобы количество инструкторов было больше или равно количеству групп.")
        else:
            break

    instructors = [f"i{i + 1}" for i in range(num_instructors)]
    groups = [f"g{i + 1}" for i in range(num_groups)]
    methods = [f"m{i + 1}" for i in range(num_methods)]

    # Генерация решений
    multiple_solutions = generate_solutions(instructors, groups, methods)

    # Вывод всех решений с весами
    print("\nВсе решения (имя, вес):")
    for name, weight in multiple_solutions:
        print(f"{name}: вес: {weight}")

    # Поиск оптимальных решений
    optimal_solutions = find_optimal_solutions(multiple_solutions)

    # Вывод оптимальных решений
    print("\nОптимальные решения:")
    for name, weight in optimal_solutions:
        print(f"{name}: вес: {weight}")

if __name__ == "__main__":
    main()

