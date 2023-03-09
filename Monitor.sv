class Monitor;

virtual out_intf.OP output_intf;
mailbox rcvr2sb;


function new(virtual out_intf.OP  vif,mailbox rcvr2sb);
   this.vif  = vif  ;
   if(rcvr2sb == null)
   begin
     $display(" **ERROR**: rcvr2sb is null");
     $finish;
   end
   else
   this.rcvr2sb = rcvr2sb;
endfunction 

task start;
    logic [7:0] TX_DATA;
    packet byte;

    forever
    begin
        repeat(2) @(posedge output_intf.clock);
        wait(output_intf.cb.TX_READY_LD)
        output_intf.cb.RX_READY_LD <= 1;   
        repeat(2) @(posedge output_intf.clock);
        while (output_intf.cb.TX_READY_LD)
        begin
            byte = output_intf.cb.DATA;
            @(posedge output_intf.clock);
        end
        output_intf.cb.RX_READY_LD <= 0;   
        @(posedge output_intf.clock);
    end
endtask
endclass