`include "cpu_types_pkg.vh"
`include "alu_if.vh"

import cpu_types_pkg::*;

module alu (alu_if aif);


 /*
   logic [31:0] port_A,port_B;
   logic [3:0] aluop;
   logic [31:0] output_port;
   logic negative,overflow,zero;
*/

	logic [32:0] output_port_temp;

	always_comb begin
		aif.negative = 0;
		aif.overflow = 0;
		aif.zero = 0;
	
	
		//alu operation
		case (aif.aluop)
			ALU_SLL:	begin
					aif.output_port = (aif.port_A << aif.port_B);
					output_port_temp = (aif.port_A << aif.port_B);
					aif.overflow = 0;
					end
			
				
    			ALU_SRL:	begin
    					aif.output_port = (aif.port_A >> aif.port_B);
    					output_port_temp = (aif.port_A >> aif.port_B);
    					aif.overflow = 0;
    					end
    			
    			
    			ALU_ADD:	begin
    					aif.output_port = aif.port_A + aif.port_B;
    					output_port_temp = aif.port_A + aif.port_B;
    					aif.overflow = (output_port_temp > aif.output_port);
    					end
    			
    			
    			ALU_SUB:	begin
    					aif.output_port = aif.port_A - aif.port_B;
    					output_port_temp = aif.port_A - aif.port_B;
    					aif.overflow = 0;
    					end
    			
    			
    			ALU_AND:	begin
    					aif.output_port = aif.port_A & aif.port_B;
    					output_port_temp = aif.port_A & aif.port_B;
    					aif.overflow = 0;
    					end
    			
    			
    			ALU_OR:		begin
    					aif.output_port = aif.port_A | aif.port_B;
    					output_port_temp = aif.port_A | aif.port_B;
    					aif.overflow = 0;
    					end
    			
    			
    			ALU_XOR:	begin
    					aif.output_port = aif.port_A ^ aif.port_B;
    					output_port_temp = aif.port_A ^ aif.port_B;
    			    		aif.overflow = 0;
    			    		end
    			
    			
    			ALU_NOR:	begin
    					aif.output_port = ~(aif.port_A | aif.port_B);
    					output_port_temp = ~(aif.port_A | aif.port_B);
    			    		aif.overflow = 0;
    			    		end
    			
    			
    			ALU_SLT:	begin
    					aif.output_port = ($signed(aif.port_A) < $signed(aif.port_B));
    					output_port_temp = ($signed(aif.port_A) < $signed(aif.port_B));
    					aif.overflow = 0;
    					end
    			
    			
    			ALU_SLTU:	begin
    					aif.output_port = (aif.port_A < aif.port_B);
    					output_port_temp = (aif.port_A < aif.port_B);
    					aif.overflow = 0;
    					end
    			
    			
    			default:	begin
    					aif.output_port = 0;
    					output_port_temp = 0;
    					aif.overflow = 0;
    					end
    			
    		endcase
		
		//set flag
		aif.negative = (aif.output_port < 0);
		
		aif.zero = (aif.output_port == 0);
		
	end


endmodule
