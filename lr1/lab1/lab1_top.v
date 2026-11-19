// lab1_top.v -- текстовый (Verilog) эквивалент схемы lab1.bdf
// Используется для моделирования в Icarus Verilog и как запасной верхний уровень.
module lab1_top
(
	C, Y
);

input C;
output [3:0] Y;

wire [2:0] Q;

schetchik  inst  (.C(C), .Q(Q));
rspsignals inst1 (.Q(Q), .Y(Y));

endmodule
