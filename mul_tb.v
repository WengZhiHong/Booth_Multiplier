`timescale 1ns/1ns
module mul_tb ;

    reg signed  [31:0]a, b;
    wire signed [63:0]product;
    reg correct;

    initial begin
        a = 15; b = 16;
        #5 a = 10; b = 2;
        #5 a = 8; b=16;
        #5 a = 52; b= 32;
        #5 a = 77; b= 30;
        #5 a = 46; b=53;
        #5 a = 21; b=19;
        #5 a = 21; b=57;
        #5 a = 37; b=35;
        #5 a = 34; b=53;
        #5 a = -1; b=10;
        #5 a =-32; b=-5;
        #5 a = -5; b=47;
        #5 a = 0;  b=-7;
        #5 a = 3;  b=-4;
        #5 $finish;
    end

    mul m0 (a, b, product);


    always @(*) begin
        if(product == a*b)
            correct = 1;
        else
            correct = 0;
    end
    initial begin
        $monitor("-----------------\n\ta = \t\t %d\n\tb = \t\t %d\n\tproduct = %d\n\tcorrect = \t\t%d\n"
        ,a, b, product, correct);
    end
    
    initial begin
        $fsdbDumpfile("mul.fsdb");
        $fsdbDumpvars(0,mul);
    end
endmodule