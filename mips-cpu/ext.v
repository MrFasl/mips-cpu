module EXT(
    input [15:0] Imm_16,
    input [1:0] ExtOp,
    output [31:0] Imm_32
    );
     
    parameter sign = 2'b00,
                 zero = 2'b01,
                 high = 2'b10,
                 sign_left_2 = 2'b11;
    
    assign Imm_32 = (ExtOp == sign) ? {{16{Imm_16[15]}},Imm_16} :
                         (ExtOp == zero) ? {{16'b0}, Imm_16} :
                         (ExtOp == high) ? {Imm_16,{16'b0}} :
                                                 {{14{Imm_16[15]}},Imm_16,2'b00};

endmodule