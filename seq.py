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


def main():
    seq = []
    print(" Q2Q1Q0 | Y | Y3Y2Y1Y0 (one-hot)")
    for q, _ in zip(counter_down(), range(8)):
        y = RSP[q]
        seq.append(y)
        print(f"  {q:03b}   | {y} |   {1 << (y - 1):04b}")
    print("Последовательность Y:", ",".join(map(str, seq)))
    print("OK" if seq == EXPECTED else "ОШИБКА")


if __name__ == "__main__":
    main()
