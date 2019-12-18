`timescale 1ns / 1ps

module Processor(
    input clk,
    input rstn,
    input [31:0]operation,
    input [7:0]PC,
    output [7:0] PCout,
    output reg [31:0] RD, //This is the Read data registed, not destination register
    output reg [31:0] A, //This is the output register
    output [383:0]One_D_Array_IM,
    //output wire[2047:0]One_D_Array_DM,
   // output [2047:0]One_D_Array_Storage,
    output [63:0]readData1,
    output [63:0]readData2,
    output [4:0]readReg1,
    output [4:0]readReg2,
    output zFlag,
    output [63:0] Result,
    output [3:0] ALUc,
    output [63:0] ALUB
    //output [2047:0]One_D_Array_DM_Output
    );
    
    reg [10:0]opcode; //DEBUG check bit length... 10?
    reg [4:0] Rn;
    //wire [4:0] PC;
    reg [4:0] Rd;
    reg [4:0] Rm;
    
    //wire [4:0] readReg1;
    //wire [4:0] readReg2;
    wire [4:0] writeReg;
    
    
    //wire [31:0]readData1;
    //wire [31:0]readData2;
    
    reg [5:0] Shamt;
    reg [8:0] DT_Address;
    reg [1:0] op;
    reg [25:0] BR_Address;
    reg [18:0] COND_BR_Address;
    
    wire Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp1, ALUOp0, BranchMux, UncondBranch;
    //wire [3:0] ALUc;
    //wire [63:0] Result;
    reg [63:0] Extended;
    wire [63:0] ReadDataStorage;
    wire [63:0] WriteDataReg;
    //wire [2047:0] One_D_Array_DM_Output;

    //reg [31:0] IM[0:31];
    
//    initial begin
//       $readmemb("H:/363/project_5/IM.dat", IM);
//    end
//    genvar i;
//    for (i = 0; i < 32; i = i + 1) begin
//        assign One_D_Array[32*i+31:i*32] = IM [i];
//    end

    always @(*) begin //operation
        opcode = operation[31:21];
        
        COND_BR_Address = 0;
        //BR_Address = 0;       //dont need to have branch
        Rm = 0;
        Rn = 0;
        Rd = 0;
        op = 0;
        Shamt = 0;
        
        //Extended <= $signed(operation);
                
        case(opcode[10:3])
            //CBZ
            8'b10110100: begin
                
                COND_BR_Address = operation[23:5];
                Rd = operation[4:0];
                Extended <= $signed(COND_BR_Address);
            end
        endcase
//        case(opcode[10:5])
//            //B
//            6'b000101: begin
//                BR_Address = operation[25:0];
//                Extended <= $signed(BR_Address);
//            end
//        endcase
        case (opcode)
            //LDUR
            11'b11111000010: begin
                DT_Address = operation[20:12];
                op = operation[11:10];
                Rn = operation[9:5];
                Rd = operation[4:0];
                Extended <= $signed(DT_Address);
            end
            
            //STUR
            11'b11111000000: begin
                DT_Address = operation[20:12];
                op = operation[11:10];
                Rd = operation[9:5];
                Rn = operation[4:0];
                Extended <= $signed(DT_Address);
            end
            
            //ADD
            11'b10001011000: begin
                Rm = operation[20:16];
                Shamt = operation[15:10];
                Rn = operation[9:5];
                Rd = operation[4:0];
            end
            
            //AND
            11'b10001010000: begin
                Rm = operation[20:16];
                Shamt = operation[15:10];
                Rn = operation[9:5];
                Rd = operation[4:0];
            end
            
            //SUB
            11'b11001011000: begin
                Rm = operation[20:16];
                Shamt = operation[15:10];
                Rn = operation[9:5];
                Rd = operation[4:0];
            end
            
            //ORR
            11'b10101010000: begin
                Rm = operation[20:16];
                Shamt = operation[15:10];
                Rn = operation[9:5];
                Rd = operation[4:0];
            end
        endcase     
    end
    Controller Controller(clk, opcode, Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp1, ALUOp0,UncondBranch, ALUc, rstn);
    Datapath Datapath(clk, rstn, Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUc, readReg1, readReg2, writeReg, readData1, readData2, Rn,Rd,Rm, PC, PCout, Result, zFlag, Extended, ReadDataStorage, WriteDataReg, ALUB);
    Register Register(clk,readReg1, readReg2, readData1,readData2,RegWrite,writeReg,WriteDataReg); //One_D_Array_DM_Output
    Storage Storage(clk, Result, MemWrite, MemRead, readData2, ReadDataStorage);
    
    
endmodule
