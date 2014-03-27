//sign extender

module sign_extender(input [15:0] in,
			input logic ExtOp,
			output logic [31:0] out);
	
    assign out = (ExtOp) ? {{16{in[15]}}, in} : {{16{0}}, in};


endmodule
