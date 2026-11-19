`timescale 1ns/1ps
// tb_lab1.v -- тестбенч: 10 нажатий на кнопку C (KEY[1]), проверка последовательности Y
module tb_lab1;

reg C = 1'b0;
wire [3:0] Y;
wire [2:0] Q = dut.Q;

lab1_top dut (.C(C), .Y(Y));

always #20 C = ~C;   // период 40 нс

function integer onehot2int(input [3:0] v);
	case (v)
		4'b0001: onehot2int = 1;
		4'b0010: onehot2int = 2;
		4'b0100: onehot2int = 3;
		4'b1000: onehot2int = 4;
		default: onehot2int = -1;
	endcase
endfunction

integer expected [0:7];
integer i, errors;

initial begin
	expected[0]=3; expected[1]=2; expected[2]=1; expected[3]=1;
	expected[4]=2; expected[5]=3; expected[6]=4; expected[7]=4;
	errors = 0;
	$dumpfile("lab1.vcd");
	$dumpvars(0, tb_lab1);
	#5;
	for (i = 0; i < 17; i = i + 1) begin
		$display("t=%0d ns  Q=%b (%0d)  Y[3..0]=%b  Y=%0d", $time, Q, Q, Y, onehot2int(Y));
		if (onehot2int(Y) !== expected[i % 8]) begin
			$display("  ОШИБКА: ожидалось Y=%0d", expected[i % 8]);
			errors = errors + 1;
		end
		#40;
	end
	if (errors == 0) $display("TEST PASSED: последовательность 3,2,1,1,2,3,4,4 верна");
	else $display("TEST FAILED: %0d ошибок", errors);
	$finish;
end

endmodule
