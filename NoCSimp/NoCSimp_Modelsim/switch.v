// synopsys translate_off
//`timescale 1 ps / 1 ps
// synopsys translate_on
module switch
   #(
      parameter DATA_WIDTH = 37,
      parameter POSITION = 4'b0101, //ctntr X: 01 Y: 01
      parameter LOG2_DEPTH = 5 // i.e. fifo depth=2**LOG2_DEPTH
   )
(
dataInL,
dataInE, 
dataInW,
dataInS,
dataInN,
dataOutL,
dataOutE, 
dataOutW,
dataOutS,
dataOutN,
Inr_L,Inr_N,Inr_E,Inr_S,Inr_W,
Inw_L,Inw_N,Inw_E,Inw_S,Inw_W,
Outr_L,Outr_N,Outr_E,Outr_S,Outr_W,
Outw_L,Outw_N,Outw_E,Outw_S,Outw_W,
clk,
reset
);

input wire [DATA_WIDTH-1 : 0] dataInE, dataInW, dataInS, dataInN, dataInL; // 4 addres, 1 endbit
output wire [DATA_WIDTH-1 : 0] dataOutE, dataOutW, dataOutS, dataOutN, dataOutL;
input wire Inr_L, Inr_N, Inr_E, Inr_S, Inr_W;
output  wire Inw_L, Inw_N, Inw_E, Inw_S, Inw_W;
output wire Outr_L,Outr_N,Outr_E,Outr_S,Outr_W;
input wire Outw_L,Outw_N,Outw_E,Outw_S,Outw_W;
input wire clk;
input wire reset;

wire [DATA_WIDTH-1:0] DataInFiFo, DataOutFiFo;
wire wrreq, rdreq, full, empty;

InPort #(DATA_WIDTH, POSITION) InputPort(.dataInE(dataInE), .dataInW(dataInW), .dataInS(dataInS), .dataInN(dataInN), .dataInL(dataInL),
              .Inr_L(Inr_L),.Inr_N(Inr_N),.Inr_E(Inr_E),.Inr_S(Inr_S),.Inr_W(Inr_W),
              .Inw_L(Inw_L),.Inw_N(Inw_N),.Inw_E(Inw_E),.Inw_S(Inw_S),.Inw_W(Inw_W),
              .DataFiFo(DataInFiFo),.wrreq(wrreq),.clk(clk),.full(full),.reset(reset));
sync_fifo #(DATA_WIDTH, LOG2_DEPTH ) local_fifo (.din(DataInFiFo),.wr_en(wrreq),.rd_en(rdreq),.dout(DataOutFiFo),.full(full),
              .empty(empty),.clk(clk),.reset(reset)/*depth*/);
//fifo #(DATA_WIDTH, LOG2_DEPTH ) local_fifo (.data(DataInFiFo),.wrreq(wrreq),.rdreq(rdreq),.q(DataOutFiFo),.full(full),
//             .empty(empty),.clock(clk),.aclr(reset)/*depth*/);
OutPort #(DATA_WIDTH, POSITION) OutputPort (.dataOutE(dataOutE),.dataOutW(dataOutW),.dataOutS(dataOutS),.dataOutN(dataOutN),.dataOutL(dataOutL),
              .Outr_L(Outr_L),.Outr_N(Outr_N),.Outr_E(Outr_E),.Outr_S(Outr_S),.Outr_W(Outr_W),
              .Outw_L(Outw_L),.Outw_N(Outw_N),.Outw_E(Outw_E),.Outw_S(Outw_S),.Outw_W(Outw_W),
              .DataFiFo(DataOutFiFo),.rdreq(rdreq),.clk(clk),.empty(empty),.reset(reset));



endmodule