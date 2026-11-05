#!/bin/sh
# Запускать из папки lab1 после полной компиляции проекта в Quartus II.
# Делает коммит 3 (отчёты area/timing) и коммит 4 (прошивка .sof).
set -e
cd "$(dirname "$0")"
OUT=output_files
mkdir -p reports firmware
# Отчёт о занятой площади (Fitter) и о временных характеристиках (TimeQuest)
cp "$OUT/lab1.fit.summary" reports/lab1_area.fit.summary
cp "$OUT/lab1.fit.rpt"     reports/lab1_area.fit.rpt
cp "$OUT/lab1.sta.summary" reports/lab1_timing.sta.summary
cp "$OUT/lab1.sta.rpt"     reports/lab1_timing.sta.rpt
git add reports
git commit -m "Отчёты Quartus: площадь (fit) и временные характеристики (sta)"
cp "$OUT/lab1.sof" firmware/lab1.sof
git add -f firmware/lab1.sof
git commit -m "Файл прошивки lab1.sof для EP2C20F484C7 (DE1)"
git log --oneline --graph --all
