`timescale 1ns / 1ps

module Storage(
        input clk,
        //input [2047:0]One_D_Array_Storage,
        input [63:0]Result,
        input MemWrite,MemRead,
        input [63:0] WriteDataStorage,
        output reg [63:0] ReadDataStorage
    );
    
    
     reg [63:0] DM[0:31];
       
     initial begin
         $readmemh("H:/363/project_5/DM.dat", DM);
     end
    
//    wire [63:0] Storage[0:31];
    
//    genvar i;
//     for (i = 0; i < 32; i = i + 1) begin
//           assign Storage[i] = One_D_Array_Storage[64*i+63:i*64];
//     end
     
     always @(*) begin
         if (MemRead == 1) begin
            ReadDataStorage = DM[Result];
         end
        
        if (MemWrite == 1) begin
            DM[Result] = WriteDataStorage;
        end
     end
     
    
endmodule
