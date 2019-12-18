`timescale 1ns / 1ps

module Datapath(
    input clk, rstn, Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch,
    input [3:0] ALUc,
    output reg [4:0] readReg1, readReg2, writeReg,
    input [63:0] readData1, readData2,
    input [4:0] Rn,Rd,Rm,
    input [7:0] PC,
    output reg[7:0] PCout,
    output [63:0] result,
    output zFlag,
    input [63:0]Extended,
    input [63:0]ReadDataStorage,
    output reg[63:0] WriteDataReg,
    output reg [63:0] ALUB
    );
    
    reg BranchMux;
    
    
    //reg [63:0] ALUB;
    
    ALU ALU(clk, readData1, ALUB, ALUc, result, zFlag);
    
    always @(*) begin //posedgeclk
    
        
        
        readReg1 = Rn;
        
        writeReg = Rd;
        
        
        
       case(Reg2Loc)
            0: begin
                readReg2 = Rm;
            end
            1: begin
                readReg2 = Rd;
            end
            //default: begin
            
            //end
        endcase
        case(ALUSrc)
            0: begin
                ALUB = readData2;
            end
            1: begin
                ALUB = Extended;
            end
        endcase
        case(MemtoReg)
            0: begin
                WriteDataReg = result;
            end
            1: begin
                WriteDataReg = ReadDataStorage;
            end
        endcase
        
        if (BranchMux == 1) begin //BranchMux == 1
           //PCout = 0;
           PCout = (Extended) + PC; //DEBUG: go back to where the branch was called and Extended * 4
        end
//        else begin
//            PCout = PC;
//        end
        //if (RegWrite == 1) begin
            //reg[writereg] = WriteDataReg
       // end
        if (MemWrite == 1) begin //STUR
            //mem[result] = readData2
        end
        if (MemRead == 1) begin //LDUR
            //ReadDataStorage = Storage[result]
        end
        
        if ((Branch == 1) && (zFlag == 1)) begin
            BranchMux = 1;
        end
        else begin
            BranchMux = 0;
        end
        
        
    end
    
    //always @(result) begin
        //if memwrite ==1, address = result (stur)
        //if memtoreg == 0, write to aluresult to reg (ldur)
        //if memtoreg == 1, writedatatoreg = read data (ldur) 
        
        
   // end
    
    

endmodule
