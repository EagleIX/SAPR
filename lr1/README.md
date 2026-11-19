# САПР, лабораторная работа №1

Нисходящее проектирование цифровых устройств на основе ПЛИС (Quartus II, плата DE1).

- **Автор:** Орлов Дмитрий Владимирович
- **Группа:** М3О-410Б-23
- **Вариант:** 15

## История ЛР1

Первые 11 коммитов описывают выполнение работы. Затем проект перенесён в папку `lr1` и дополнен отчётом.

| № | Коммит | Изменение |
|---:|---|---|
| 1 | [13de698](https://github.com/EagleIX/SAPR/commit/13de698257985600ffe30a214d6ef5ee645b137d) | Начальный коммит: README и программа seq.py |
| 2 | [d988f4e](https://github.com/EagleIX/SAPR/commit/d988f4e4cb1b6b1a95bd363c9e0ad4f060b85196) | feature: функции возбуждения счётчика в seq.py, описание в README |
| 3 | [b7740e1](https://github.com/EagleIX/SAPR/commit/b7740e1eade27a423955060e544128c306ab83bc) | README: добавлен раздел о требованиях |
| 4 | [10a6e25](https://github.com/EagleIX/SAPR/commit/10a6e259ff0bcb9b50ce02b8f7a10522f940ae9d) | Слияние main в feature/excitation: разрешён конфликт в README.md |
| 5 | [080472f](https://github.com/EagleIX/SAPR/commit/080472fe721cbec309abe62f5315e30aaece7a75) | Слияние feature/excitation в main |
| 6 | [f1c840d](https://github.com/EagleIX/SAPR/commit/f1c840db367d2d7163cb7781f7b2d8e25efaa059) | ЛР1: исходные коды (Verilog, схема bdf, тестбенч, проект Quartus) |
| 7 | [97c8edd](https://github.com/EagleIX/SAPR/commit/97c8edde54fcea72dcdca8cc5b8b43bb73575af2) | ЛР1: файл временных ограничений lab1.sdc |
| 8 | [c6f5379](https://github.com/EagleIX/SAPR/commit/c6f53798f530ede91c73cd3f107ea78d36dfe768) | ЛР1: неиспользуемые выводы ПЛИС -- входы с третьим состоянием (защита платы DE1) |
| 9 | [9fd076f](https://github.com/EagleIX/SAPR/commit/9fd076fd62039bf5fd645025136c46c181f39534) | ЛР1: сохранить итоговую схему и настройки моделирования |
| 10 | [d68584a](https://github.com/EagleIX/SAPR/commit/d68584a2ecea4ebdde5f8e9119ffd8384f6d675b) | Отчёты Quartus: площадь (fit) и временные характеристики (sta) |
| 11 | [f77891d](https://github.com/EagleIX/SAPR/commit/f77891df7e7d9c8b33cd93d7a7147d40b71cf8bd) | Файл прошивки lab1.sof для EP2C20F484C7 (DE1) |
| 12 | [489e08d](https://github.com/EagleIX/SAPR/commit/489e08d4996df4f025625502fc3b0dbab567d845) | Перенести первую лабораторную в lr1 |
| 13 | [db7688a](https://github.com/EagleIX/SAPR/commit/db7688a4e4d9c4cf0671a733ee49d4bc50fd6c68) | ЛР1: оформить материалы для сдачи и добавить отчёт с фотографиями |

[Граф истории до переноса в общий репозиторий](https://github.com/EagleIX/SAPR/commits/f77891df7e7d9c8b33cd93d7a7147d40b71cf8bd/).

## Программа seq.py

`seq.py` — модель распределителя сигналов варианта 15 на Python.
Счётчик обратного хода перебирает состояния Q = 7, 6, 5, …, 0,
распределитель выдаёт последовательность Y = 3, 2, 1, 1, 2, 3, 4, 4.

Проверка: `python3 seq.py` — программа печатает таблицу Q → Y и
сообщение `OK`, если последовательность совпадает с заданием.

## Требования

Python 3.6 и новее, сторонние библиотеки не нужны.

## Изменения в ветке feature/excitation

Добавлена функция `excitation()` — вычисление функций возбуждения
D-триггеров счётчика обратного хода (D0 = ¬Q0, D1 = ¬(Q1⊕Q0),
D2 = Q2⊕(¬Q1·¬Q0)) и самопроверка `check_excitation()`.

## Лабораторная работа №1 (папка lab1)

Вариант 15: распределитель сигналов на базе счётчика обратного хода,
последовательность Y = 3,2,1,1,2,3,4,4,…; вход C — кнопка KEY[1]
(PIN_R21), выходы Y[3..0] — зелёные светодиоды LEDG[7..4]; ПЛИС
EP2C20F484C7 (Cyclone II), плата DE1 (вместо DE2-115 по согласованию
с преподавателем), Quartus II 13.0 SP1.

| Файл | Назначение |
|---|---|
| `schetchik.v` | счётчик обратного хода (7, 6, …, 0) |
| `rspsignals.v` | распределитель сигналов Q → Y (one-hot) |
| `lab1.bdf` | схема верхнего уровня (два блока + пины) |
| `lab1_top.v` | Verilog-эквивалент схемы для моделирования |
| `tb_lab1.v` | тестбенч (Icarus Verilog) |
| `lab1.vwf` | входные воздействия для моделирования в Quartus |
| `lab1.qpf`, `lab1.qsf` | проект Quartus и привязка пинов |
| `lab1.sdc` | временные ограничения |
| `reports/` | отчёты о площади (fit) и временных характеристиках (sta) |
| `firmware/lab1.sof` | файл прошивки |

Моделирование без Quartus:
`iverilog -o sim tb_lab1.v lab1_top.v schetchik.v rspsignals.v && vvp sim`

## Материалы для сдачи

[Отчёт по ЛР1 с фотографиями платы](%D0%9E%D1%80%D0%BB%D0%BE%D0%B2_%D0%94%D0%92_%D0%9C3%D0%9E_410_2023_%D0%A1%D0%90%D0%9F%D0%A0_%D0%9B%D0%A0_1.docx)

[Временные ограничения](lab1/lab1.sdc) · [Отчёт о ресурсах](lab1/reports/lab1_area.fit.rpt) · [Временной анализ](lab1/reports/lab1_timing.sta.rpt) · [Прошивка DE1](lab1/firmware/lab1.sof)

Историю ЛР1 до переноса в общую папку можно посмотреть командой `git log --graph --oneline f77891d`. Она показывает обе ветки, разрешение конфликта и коммиты с результатами Quartus.
