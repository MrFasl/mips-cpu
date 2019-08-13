module IM(
    input [11:2] PC,
    output [31:0] Instr
    );
    
    reg [31:0] memory [1023:0];
    integer i;
    
    initial begin
        for(i = 0; i < 1024; i = i + 1)
            memory[i] = 32'h0;
        $readmemh("code.txt",memory);
    end
    
    assign    Instr = memory[PC];

endmodule