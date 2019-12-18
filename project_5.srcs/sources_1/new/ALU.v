`timescale 1ns / 1ps

module ALU(CLK, inputA, inputB, ALUc, result, zFlag
    //inputs: inputA, inputB, ALUc, cin
    //output: result, zFlag, cout
    );
    
    input CLK;
    input [63:0] inputA, inputB;
    input [3:0] ALUc;
    output reg [63:0] result;
    output reg zFlag;
    
    reg [64:0] extra;    //used to calculate carry out
   
    always@(*) begin    //aluc
        //switch statement
        case(ALUc)
            //case 0000: inputA AND(&) inputB
            4'b0000: begin
                assign result = inputA & inputB;
            end  
              
            //case 0001: inputA OR(|) inputB
            4'b0001: begin
                assign result = inputA | inputB;
            end 
            
            //case 0010: inputA add(+) inputB
            4'b0010: begin
                assign result = inputA + inputB;
            end 
            
            //case 0110: inputA subtract(-) inputB
            4'b0110: begin
                assign result = inputA - inputB;
            end 
            
            //case 0111: Pass inputB, result = inputB
            4'b0111: begin
                assign result = inputB;
            end 
            
            //case 1100: inputA NOR(~|) inputB
//            4'b1100: begin
//                assign result = ~(inputA | inputB);
//            end 
        endcase
    end
    
    always@(*) begin //posedge CKLK
        if(result == 0)
            assign zFlag = 1;
        else
            assign zFlag = 0;
    end
endmodule
