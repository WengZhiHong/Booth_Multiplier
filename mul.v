`timescale 1ns/1ns
module mul (
    input [31:0] multiplicand_i,
    input [31:0] multiplier_i,
    output reg [63:0] product_o
);
    //Booth Encode
    reg [47:0] encoded_multiplier;
    wire [32:0] extened_multiplier = {multiplier_i, 1'b0};    
    genvar i;
    generate
        for(i=0; i<=15; i=i+1)begin
            always @(*) begin
                case(extened_multiplier[2*i+:3])
                    0: encoded_multiplier[3*i+:3] = 3'b000;
                    7: encoded_multiplier[3*i+:3] = 3'b000;
                    1: encoded_multiplier[3*i+:3] = 3'b001;
                    2: encoded_multiplier[3*i+:3] = 3'b001;
                    3: encoded_multiplier[3*i+:3] = 3'b010;
                    4: encoded_multiplier[3*i+:3] = 3'b110;
                    5: encoded_multiplier[3*i+:3] = 3'b101;
                    6: encoded_multiplier[3*i+:3] = 3'b101;
                    default: encoded_multiplier[3*i+:3] = 0;
                endcase
            end
        end
    endgenerate

    reg [63:0] partial_prod [15:0];
    genvar j;
    generate
        for (j = 0; j<=15; j=j+1 ) begin
            always @(*) begin
                case (encoded_multiplier[3*j+:3])
                    0: partial_prod[j] = 0;
                    1: partial_prod[j] = ($signed(multiplicand_i))<<(2*j);
                    2: partial_prod[j] = ($signed(multiplicand_i))<<(2*j+1);
                    3: partial_prod[j] = 0;
                    4: partial_prod[j] = 0;
                    5: partial_prod[j] = ($signed(~multiplicand_i+1))<<(2*j);
                    6: partial_prod[j] = ($signed(~multiplicand_i+1))<<(2*j+1);
                    7: partial_prod[j] = 0;
                    default:partial_prod[j] = 0;  
                endcase
            end
        end     
    endgenerate

    always @(*) begin
        product_o = partial_prod[0]+partial_prod[1]+partial_prod[2]
        +partial_prod[3]+partial_prod[4]+partial_prod[5]+partial_prod[6]
        +partial_prod[7]+partial_prod[8]+partial_prod[9]+partial_prod[10]
        +partial_prod[11]+partial_prod[12]+partial_prod[13]+partial_prod[14]
        +partial_prod[15];
    end
endmodule
