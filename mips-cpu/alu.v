module ALU(
    input [31:0] A,
    input [31:0] B,
    input [3:0] ALUOp,
    output Zero,
    output [31:0] Result
    );

    parameter addu = 4'b0000,
                 subu = 4'b0001,
                 orr  = 4'b0010;
    
    assign Result = (ALUOp == addu) ? (A + B) :
                         (ALUOp == subu) ? (A - B) :
                                                 (A | B);
    
    assign Zero = (A - B == 0) ? 1 : 0;


endmodule