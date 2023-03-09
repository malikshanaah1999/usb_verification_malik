
class Environment ;

  virtual in_intf.IP    input_interface;
  virtual out_intf.OP  output_interface;
 
  Driver drvr;
  Monitor rcvr;
  Scoreboard scb;
  mailbox drvr2sb ;
  mailbox rcvr2sb ;

function new(virtual in_intf.IP    input_interface, 
  virtual out_intf.OP  output_interface);

  this.input_interface      = input_interface    ;
  this.output_interface    = output_interface  ;
endfunction 

function void build();
   $display("Environemnt : start of build() method");
   drvr2sb = new();
   rcvr2sb = new();
   scb = new(drvr2sb,rcvr2sb);
   drvr= new(input_interface,drvr2sb);
   rcvr= new(output_interface,rcvr2sb);
   $display("Environemnt : end of build() method");
endfunction 

task reset();
  $display("Environemnt : start of reset() method");

  input_interface.cb.TX_DATA  <= 0;
  input_interface.cb.CRC_16  <= 0;
  input_interface.cb.TX_LOAD  <= 0;
  input_interface.cb.RX_LOAD  <= 0;
  output_interface.cb.DATA    <= 0;
  output_interface.cb.RX_READY_LD    <= 0;
  output_interface.cb.TX_READY_LD    <= 0;

  // Reset the DUT
  input_interface.reset_l <= 1;
  repeat (4) @ (input_interface.clock);
  input_interface.reset_l <= 0;
  
  $display("Environemnt : end of reset() method");
endtask 
  

task start();
  $display("Environemnt : start of start() method");
  fork
    drvr.start();
    rcvr.start();
    scb.start();
  join_any
  $display("Environemnt : end of start() method");
endtask


task wait_for_end();
   repeat(10000) @(input_interface.clock);
endtask 

  
task run();//Calling all the above methods...
   build();
   reset();
   start();
   wait_for_end();
endtask 


endclass


