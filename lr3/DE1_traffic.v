// файл верхнего уровня проекта (плата DE1, Cyclone II EP2C20F484C7)
// соединяет процессорную систему nios_system (собрана в Qsys)
// с элементами платы. Подключены только выводы, которые нужны светофору
module DE1_traffic
(
  input         CLOCK_50,   // тактовый генератор 50 МГц
  input         KEY0,       // кнопка KEY0 - сброс (0 - нажата)
  input  [2:0]  SW,         // переключатели (программой варианта 3 не используются)
  output [7:0]  LEDR,       // красные светодиоды: красный и желтый сигналы
  output [3:0]  LEDG,       // зеленые светодиоды: зеленый сигнал
  output [6:0]  HEX0,       // индикатор: единицы секунд
  output [6:0]  HEX1        // индикатор: десятки секунд
);

wire [7:0] hex_bcd;         // две цифры для индикаторов от процессора
wire [9:0] ledr_all;        // порт ledr в системе 10 бит, на плату идут 8
wire [7:0] ledg_all;        // порт ledg в системе 8 бит, на плату идут 4

// процессорная система
nios_system u0
(
  .clk_clk         (CLOCK_50),
  .reset_reset_n   (KEY0),
  .switches_export ({5'b00000, SW}),   // неиспользуемые биты переключателей = 0
  .ledr_export     (ledr_all),
  .ledg_export     (ledg_all),
  .hex_bcd_export  (hex_bcd)
);

assign LEDR = ledr_all[7:0];
assign LEDG = ledg_all[3:0];

// собственные модули - дешифраторы для индикаторов
hex7seg h0 (.bcd(hex_bcd[3:0]), .seg(HEX0));
hex7seg h1 (.bcd(hex_bcd[7:4]), .seg(HEX1));

endmodule
