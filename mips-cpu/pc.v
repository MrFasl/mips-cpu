module PC(
    input Clk,
     input Reset,
     input [31:0] nPC,
    output reg[31:0] PC
    );
     
    initial begin
        PC <= 32'h0000_3000;
    end

    always @ (posedge Clk) begin
        if(Reset == 1)    PC <= 32'h0000_3000;
        else                PC <= nPC;
    end

endmodule