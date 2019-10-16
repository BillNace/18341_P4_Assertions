// $YOUR_NAME
// $YOUR_ANDREW_ID
// top.sv
`default_nettype none

`ifndef STRUCTS
`define STRUCTS

  typedef enum logic [3:0] {START    = 4'h1,
                            ENTER    = 4'h2,
                            ARITH_OP = 4'h4, 
                            DONE     = 4'h8} oper_t; 
                            
  typedef struct packed { // what appears at the data input 
    oper_t       op;
    logic [15:0] payload; 
    } keyIn_t; 
    
`endif


//////////////////////
////             ////
////    top     ////
////           ////
//////////////////

module top();

    //inputs to calculator
    logic    clock, reset_N;
    keyIn_t  data;

    //outputs from calculator
    logic [15:0]  result;
    logic         stackOverflow, unexpectedDone, protocolError, dataOverflow, 
                correct, finished;

    logic [7:0][15:0] stackOut;
  
    //calculator instantiation
    TA_calc  brokenCalc(.*);

    //the system clock
    initial begin
        clock = 0;
        forever #5 clock = ~clock;
    end

    //this task should contain your testbench
    task runTestbench(input int phase);
      begin
        /* * * * * * * * * * * * 
         * YOUR TESTBENCH HERE *
         * * * * * * * * * * * */
        //test for functional "correct", "finished", and ADD
        @(posedge clock);
        data.op <= START;
        data.payload <= 16'h0005; // stack: 5
        @(posedge clock);
        data.op <= ENTER;
        data.payload <= 16'h0003; // stack: 3 5
        @(posedge clock);
        data.op <= ARITH_OP;
        data.payload <= 16'h1; // add
        @(posedge clock);
        data.op <= DONE;
        data.payload <= 16'h1; // done
        @(posedge clock);
        assert(correct);
        assert(finished);
        assert(result == 8)
          else $display("result is %d", result);
      end
    endtask
      
    /* * * * * * * * * * * * * 
     * YOUR ASSERTIONS HERE  *
     * * * * * * * * * * * * */

endmodule: top