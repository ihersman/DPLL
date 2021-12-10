`timescale 1ns/1ps

module DPLL
(
	input         resetn,

	input         ref_clk,
	input [15:0]  ref_counter,

	input [ 8:0]  init,
	input [15:0]  counter,

	input         clk_in,
	output        clk_out,

	output [2:0]  status
);

	wire [511:0] en;
	wire         clk;

	oscillator osc
	(
		.resetn(resetn),
		.en(en),
		.out(clk)
	);

	clock_ctl ctl
	(
		.resetn(resetn),
		.ref_clk(ref_clk),
		.ref_counter(ref_counter),
		.init(init),
		.counter(counter),
		.clk(clk),
		.status(status),
		.en(en)
	);

	wire  tmp_out;

	delay_module delay_line
    (
        .in(clk_in),
        .en(en),
        .out(tmp_out)
    );

	CLKAND2X8 p_adjust(.A(1'b1), .B(tmp_out), .Y(clk_out));

endmodule
