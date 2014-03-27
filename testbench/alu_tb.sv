`timescale 1 ns / 1 ns

module alu_tb;
	
	parameter DELAY = 10;

	logic [31:0] portA, portB, outPort;
	logic [3:0] aluop;
	logic negF, zerF, oveF;

	alu DUT(
		.portA(portA),
		.portB(portB),
		.aluop(aluop),
		.outPort(outPort),
		.negF(negF),
		.zerF(zerF),
		.oveF(oveF)
	);

initial begin
	// AND
	aluop = 0;
	portA = -4;
	portB = 45;
	#(DELAY)

	// OR
	aluop = 1;
	portA = -4;
	portB = 45;
	#(DELAY)

	// XOR
	aluop = 2;
	portA = -4;
	portB = 45;
	#(DELAY)

	// NOR
	aluop = 3;
	portA = -4;
	portB = 45;
	#(DELAY)

	// LSL
	aluop = 4;
	portA = 75;
	#(DELAY)

	// LSR
	aluop = 5;
	portA = 75;
	#(DELAY)

	// Add
	aluop = 6;
	portA = 67;
	portB = 89;
	#(DELAY)

	// Add negative
	aluop = 6;
	portA = -8;
	portB = 30;
	#(DELAY)

	// Overflow Flag Check
	aluop = 6;
	portA = 2100000000;
	portB = 2100000000;
	#(DELAY)

	// Subtract
	aluop = 7;
	portA = 67;
	portB = 89;
	#(DELAY)

	// Zero Flag Check
	aluop = 7;
	portA = 50;
	portB = 50;
	#(DELAY)

	// Unsigned Set Less Than
	aluop = 8;
	portA = -10;
	portB = 67;
	#(DELAY)

	// Signed Set Less Than
	aluop = 9;
	portA = -10;
	portB = 67;
	#(DELAY)

	$finish;
end

endmodule
