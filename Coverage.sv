class coverage;
  
Packet byte;

covergroup cov;

  data_in : coverpoint byte.TX_DATA;

endgroup

function new();
  cov = new();
endfunction 

task sample(Packet byte);
 this.byte = byte;
 cov.sample();
endtask

endclass





