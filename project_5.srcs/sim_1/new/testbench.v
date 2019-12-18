`timescale 1ns / 1ps

module testbench(

    );
    
    reg clk;
    reg rstn;
    reg [31:0] op;
    reg [31:0] IM[0:11];
    //reg [63:0] DM[0:31];
    //reg [63:0] Storage[0:31]; //The storage
    //reg [31:0] RD; //RD is the input
    //wire [31:0] A; //A is the output
    reg [7:0] PC;
    wire [7:0] PCout;
    
    
    wire [383:0]One_D_Array_IM;
    //wire [2047:0]One_D_Array_DM;
    //wire [2047:0]One_D_Array_Storage;
    //wire [2047:0]One_D_Array_DM_Output;
    
    wire [63:0]readData1;
    wire [63:0]readData2;
    
    wire [4:0]readReg1;
    wire [4:0]readReg2;
    
    wire [3:0] ALUc;
    wire zFlag;
    wire [63:0] Result;
    wire [63:0] ALUB;
    

    initial begin
        clk = 0;
        op = 0;
        PC = 0;
        rstn = 0;
        //A = 0;
        $readmemh("H:/363/project_5/IM.dat", IM);
       // $readmemh("H:/363/project_5/DM.dat", DM);//DM refers to the register data memory
        //$readmemh("H:/363/project_5/Storage.dat", Storage);
        #1
        rstn = 1; //Doing a high active reset
        
    end
    
    genvar i;
    for (i = 0; i < 12; i = i + 1) begin
        assign One_D_Array_IM[32*i+31:i*32] = IM[i];
        //assign One_D_Array_DM[64*i+63:i*64] = DM[i];
        //assign One_D_Array_Storage[64*i+63:i*64] = Storage[i];
    end
    
   // wire [31:0] One_D_Array_DM;
    
   // for (i = 0; i < 32; i = i + 1) begin
   //     assign test[i] = DM[i];
   // end
    
    
    always @(clk) begin
        #1
        clk <= ~clk;
    end    
    
    always @(PC & (rstn==1)) begin
        assign op = IM[PC];
    end
    
    always @(posedge clk & rstn == 1) begin //at the end of processing, increment... or @aluoutput
        //PC = PC + 1;
        if (op[31:24] != 8'b10110100) begin
            PC = PC + 1;
        end
        else begin
            PC = PCout;
        end
    end
    
//    always @(posedge clk && !op) begin
//        if (op[31:24] == 8'b10110100) begin
//            PC = PCout;
//        end
//    end
    
    always @(posedge clk) begin
        if (rstn == 0) begin
            PC = 0;
        end
                 
    end
    
    Processor uut (
        .clk(clk), 
        .operation(op),
        .rstn(rstn),
        //.RD(RD), 
        //.A(A),
        .One_D_Array_IM(One_D_Array_IM), 
        //.One_D_Array_DM(One_D_Array_DM),
        //.One_D_Array_Storage(One_D_Array_Storage),
        .readData1(readData1),
        .readData2(readData2),
        .readReg1(readReg1),
        .readReg2(readReg2),
        .zFlag(zFlag),
        .Result(Result),
        .ALUc(ALUc),
        .ALUB(ALUB),
        .PC(PC),
        .PCout(PCout)
       
        //.One_D_Array_DM_Output(One_D_Array_DM_Output)

        );
endmodule
