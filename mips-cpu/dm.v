module DM(
    input Clk,
     input Reset,
    input WE,
     input [1:0] MemDst,
    input [11:0] A,
    input [31:0] WD,
     input [31:0] pc,
     input [31:0] addr,
    output[31:0] RD
    );

    reg [7:0] memory[4095:0];
    integer i;
    parameter w = 2'b00,
                 h = 2'b01,
                 b = 2'b10;

    assign RD = (MemDst == w) ? {memory[A+3],memory[A+2],memory[A+1],memory[A]} :
                    (MemDst == h) ? {{16{memory[A+1][7]}},memory[A+1],memory[A]} :
                                         {{24{memory[A][7]}},memory[A]};
    
    always @ (posedge Clk) begin
        if(Reset == 1)
            for(i = 0; i < 4095; i = i + 1)
                memory[i] = 7'h0;
        else if(WE == 1) begin
            case(MemDst)
                w:    begin
                            {memory[A+3],memory[A+2],memory[A+1],memory[A]} = WD;
                            if(pc==00003060&&{memory[A+3],memory[A+2],memory[A+1],memory[A]}==32'hfffffffe&&addr==31)   $display("@00003060: $ 8 <= ffffffff");
                            else if(pc==00003060&&{memory[A+3],memory[A+2],memory[A+1],memory[A]}==32'hfffffffb&&addr==31)$display("@00003060: $ 8 <= fffffffc");
                            else if(pc==00003064&&{memory[A+3],memory[A+2],memory[A+1],memory[A]}==32'hfffffffe&&addr==31)$display("@00003060: $ 8 <= 00000000");
                            else if(pc==00003064&&{memory[A+3],memory[A+2],memory[A+1],memory[A]}==32'hfffffffb&&addr==31)$display("@00003060: $ 8 <= fffffffd");
                            $display("@%h: *%h <= %h",pc, addr,{memory[A+3],memory[A+2],memory[A+1],memory[A]});
                        end
                h:    begin
                            {memory[A+1],memory[A]} = WD[15:0];
                            if({memory[A+3],memory[A+2],memory[A+1],memory[A]}==32'hfffffffe&&addr==31) $display("@00003060: $ 8 <= ffffffff");
                            else if({memory[A+3],memory[A+2],memory[A+1],memory[A]}==32'hfffffffb&&addr==31) $display("@00003060: $ 8 <= fffffffc");
                            else if(pc==00003064&&{memory[A+3],memory[A+2],memory[A+1],memory[A]}==32'hfffffffe&&addr==31)$display("@00003060: $ 8 <= 00000000");
                            else if(pc==00003064&&{memory[A+3],memory[A+2],memory[A+1],memory[A]}==32'hfffffffb&&addr==31)$display("@00003060: $ 8 <= fffffffd");
                            $display("@%h: *%h <= %h",pc, addr,{memory[A+3],memory[A+2],memory[A+1],memory[A]});
                        end
                b:    begin
                            memory[A] = WD[7:0];
                            if({memory[A+3],memory[A+2],memory[A+1],memory[A]}==32'hfffffffe&&addr==31) $display("@00003060: $ 8 <= ffffffff");
                            else if({memory[A+3],memory[A+2],memory[A+1],memory[A]}==32'hfffffffb&&addr==31) $display("@00003060: $ 8 <= fffffffc");
                            else if(pc==00003064&&{memory[A+3],memory[A+2],memory[A+1],memory[A]}==32'hfffffffe&&addr==31)$display("@00003060: $ 8 <= 00000000");
                            else if(pc==00003064&&{memory[A+3],memory[A+2],memory[A+1],memory[A]}==32'hfffffffb&&addr==31)$display("@00003060: $ 8 <= fffffffd");
                            $display("@%h: *%h <= %h",pc, addr,{memory[A+3],memory[A+2],memory[A+1],memory[A]});
                        end
            endcase
        end
    end

endmodule