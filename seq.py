#!/usr/bin/env python3
"""Модель распределителя сигналов (САПР, ЛР1, вариант 15).

Счётчик обратного хода: 7, 6, 5, ..., 0, 7, ...
Распределитель: Q -> Y, заданная последовательность Y = 3,2,1,1,2,3,4,4.
"""

EXPECTED = [3, 2, 1, 1, 2, 3, 4, 4]

# Таблица распределителя: состояние счётчика -> значение Y
RSP = {7: 3, 6: 2, 5: 1, 4: 1, 3: 2, 2: 3, 1: 4, 0: 4}


def counter_down(start=7, bits=3):
    """Бесконечная последовательность состояний счётчика обратного хода."""
    q = start
    while True:
        yield q
        q = (q - 1) % (1 << bits)


def excitation(q, bits=3):
    """Функции возбуждения D-триггеров счётчика обратного хода: D = Q(t+1)."""
    q2, q1, q0 = (q >> 2) & 1, (q >> 1) & 1, q & 1
    d0 = 1 - q0                       # D0 = ~Q0
    d1 = 1 - (q1 ^ q0)                # D1 = ~(Q1 ^ Q0)
    d2 = q2 ^ ((1 - q1) & (1 - q0))   # D2 = Q2 ^ (~Q1 & ~Q0)
    return (d2 << 2) | (d1 << 1) | d0


def check_excitation(bits=3):
    """Проверка: D совпадает с Q(t+1) = Q(t) - 1 для всех состояний."""
    return all(excitation(q) == (q - 1) % (1 << bits) for q in range(1 << bits))


def main():
    seq = []
    print(" Q2Q1Q0 | Y | Y3Y2Y1Y0 (one-hot)")
    for q, _ in zip(counter_down(), range(8)):
        y = RSP[q]
        seq.append(y)
        print(f"  {q:03b}   | {y} |   {1 << (y - 1):04b}")
    print("Последовательность Y:", ",".join(map(str, seq)))
    print("OK" if seq == EXPECTED else "ОШИБКА")
    print("Функции возбуждения:", "OK" if check_excitation() else "ОШИБКА")


if __name__ == "__main__":
    main()
