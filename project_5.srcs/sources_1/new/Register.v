`timescale 1ns / 1ps
//In this file we will do the reading writing to registers

module Register(
   // input [1023:0]One_D_Array_IM,
   // input [2047:0]One_D_Array_DM, //2048 = 4 * 16 * 32
    input clk,
//    input [8:0] DTAddr,
//    input [4:0]Rm,
//    input [4:0]Rn,
//    input [4:0]Rt,
//    input [1:0]op,    
//    input [5:0] Shamt,
//    input [25:0] BR_Address,
//    input [18:0] COND_BR_Address,
    
    input [4:0] readReg1,
    input [4:0] readReg2,

    
    output reg[63:0] readData1,
    output reg[63:0] readData2,
    //output reg [2047:0]One_D_Array_DM_Output,
        
    input RegWrite,
    input [4:0] WriteReg,
    input [63:0] WriteDataReg
    );
    
    reg [63:0] RM[0:31];
    
    initial begin
        $readmemh("H:/363/project_5/RM.dat", RM);
    end
    //reg [63:0] Register [31:0];

//    output reg[63:0] readData1;
//    output reg[63:0] readData2;
   // wire [31:0] IM[0:31];
    //wire [63:0] DM[0:31];
    reg [63:0] DMreg[0:31];

    //wire [63:0] Storage[0:31];
  //  wire [4:0]Rm;
   // wire [4:0]Rn;
    genvar i;
   // for (i = 0; i < 32; i = i + 1) begin
       // assign IM[i] = One_D_Array_IM[32*i+31:i*32];
       // assign DM[i] = One_D_Array_DM[64*i+63:i*64];
 //   end
        
        
    always @(*) begin
        readData1 = RM[readReg1];
        readData2 = RM[readReg2];
        //DMreg = DM;
        //One_D_Array_DM_Output[2047:0] = One_D_Array_DM[2047:0];
        if (RegWrite == 1) begin
            RM[WriteReg] = WriteDataReg;
            //One_D_Array_DM[WriteReg*64+:64] = WriteDataReg;
        end

    end
    
endmodule
