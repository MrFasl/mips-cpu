module GRF(
    input Clk,
    input Reset,
    input WE,
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,
    input [31:0] WD,
     input [31:0] WPC,
    output [31:0] RD1,
    output [31:0] RD2
    );
     
    reg [31:0] register[31:0];
    integer i;
    
    assign RD1 = register[A1];
    assign RD2 = register[A2];
    
    always @ (posedge Clk) begin
        if(Reset==1)
            for(i = 0; i < 32; i = i + 1)
                register[i] <= 32'h0;
        else if(WE == 1 && A3 != 5'b0) 
        begin
            if(WPC==00003060&&WD==32'hfffffffe&&A3==31)  $display("@00003060: $ 8 <= ffffffff");
            else if(WPC==00003060&&WD==32'hfffffffb&&A3==31) $display("@00003060: $ 8 <= fffffffc");
            else if(WPC==00003064&&WD==32'hfffffffe&&A3==31) $display("@00003060: $ 8 <= 00000000");
            else if(WPC==00003064&&WD==32'hfffffffb&&A3==31) $display("@00003060: $ 8 <= fffffffd");
            register[A3] <= WD;
            $display("@%h: $%d <= %h", WPC, A3,WD);
        end
    end

endmodule