`include "cpu_types_pkg.vh"
`include "control_unit_if.vh"

module control_unit (control_unit_if.cu cuif);
	
	import cpu_types_pkg::*;
	
	
always_comb
	begin
	cuif.ALUOp = aluop_t'('b0);
	cuif.ALUSrc = 0;
	cuif.Jump = 1;
	cuif.Branch = 0;
	cuif.MemWrite = 0;
	cuif.MemRead = 0; 
	cuif.MemtoReg = 0; 
	cuif.RegWrite = 0;
	cuif.RegDst = 0;
	cuif.halt = 0;
	cuif.ExtOp = 0;
	
	
	
// R-Type
	if (cuif.opcode == RTYPE)
		begin
			cuif.RegDst = 1;
			cuif.RegWrite = 1;
			cuif.ALUSrc = 0;
			cuif.MemtoReg = 0;
			
			case (cuif.funct)
			 ADDU: cuif.ALUOp = ALU_ADD;
             		 AND: cuif.ALUOp = ALU_AND;
             		 JR: 	begin 
					cuif.Jump = 0;	//jr
					cuif.RegWrite = 0;
			 	end
             		 NOR: cuif.ALUOp = ALU_NOR;
             		 OR: cuif.ALUOp = ALU_OR;
             		 SLT: cuif.ALUOp = ALU_SLT;
             		 SLTU: cuif.ALUOp = ALU_SLTU;
             		 SLL: cuif.ALUOp = ALU_SLL;
             		 SRL: cuif.ALUOp = ALU_SRL;
            		 SUBU: cuif.ALUOp = ALU_SUB;
             		 XOR: cuif.ALUOp = ALU_XOR;
			
			endcase
		end
		
// I type
	else begin
		
		cuif.MemtoReg = 0;
		cuif.RegDst = 0;
		cuif.RegWrite = 1;
		cuif.ALUSrc = 1;
		cuif.ExtOp = 0;
		
		case (cuif.opcode)
		  
		   ADDIU: begin
		           cuif.ALUOp = ALU_ADD;////////////////////////////////
		           cuif.ExtOp = 1;
		          end
      
           	   ANDI: cuif.ALUOp = ALU_AND;
 
           	   BEQ: if (cuif.Equal)
			begin
			cuif.ALUSrc = 0;
			cuif.Branch = 1;	//beq
			cuif.RegWrite = 0;
			end

	       	   BNE: if (!cuif.Equal)
			begin
			cuif.ALUSrc = 0;
			cuif.Branch = 1;	//bne
			cuif.RegWrite = 0;
			end

	           LUI:begin
			cuif.ALUOp = ALU_ADD; 
			cuif.RegWrite = 1;	//lui
			cuif.MemtoReg = 0;
		       end
	  
	           LW:begin
			cuif.ALUOp = ALU_ADD;
			cuif.MemtoReg = 1;
			cuif.MemRead = 1;	//lw
			cuif.ExtOp = 1;
		      end

           	   ORI:cuif.ALUOp = ALU_OR;

           	   SLTI: begin
                    	cuif.ALUOp = ALU_SLT;
                    	cuif.ExtOp = 1;
                         end
                    
           	   SLTIU:begin
                    	cuif.ALUOp = ALU_SLT;
                    	cuif.ExtOp = 1;
                         end

	           SW:begin
			cuif.ALUOp = ALU_ADD;
			cuif.MemWrite = 1;
			cuif.MemtoReg = 1;	//sw
			cuif.ExtOp = 1;
		      end

	       	  LL:begin
			cuif.ALUOp = ALU_ADD;
			cuif.RegWrite = 1;
			cuif.MemtoReg = 1;	//ll
			cuif.ExtOp = 1;
		     end

	       	  SC:begin
			cuif.ALUOp = ALU_ADD;
			cuif.RegWrite = 1;
			cuif.MemtoReg = 1;	//sc
			cuif.ExtOp = 1;
		     end

	       	  XORI:cuif.ALUOp = ALU_XOR;



//j type
		  J:	begin 
			cuif.Jump = 0;	//j
			end
			
		  JAL:	begin
			cuif.Jump = 0;	//jal
			end
		  
		  
		  
		  HALT: begin
		  	cuif.halt = 1;
			end
			
		endcase
	end
		
	

end
	
endmodule  
