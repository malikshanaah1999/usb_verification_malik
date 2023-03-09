class Driver;

    virtual in_intf.IP  input_intf;
    mailbox drvr2sb;
    Packet byte;
    
    // Constructor
    function new(virtual in_intf.IP  vif,mailbox drvr2sb);
        this.vif = vif  ;
        if(drvr2sb == null)
        begin
            $display(" **ERROR**: drvr2sb is null");
            $finish;
        end
        else
        this.drvr2sb = drvr2sb;
        byte = new();
    endfunction 

    task start();
        logic [7:0] TX_DATA;
        repeat(number_of_bytes)
        begin
        if ( byte.randomize())
            begin
                $display (" %0d : Driver : Randomization Successesfull.",$time);
                byte.display();
            end
            //assert the TX_LOAD, cs1_l, CRC_16, RX_LOAD signals and send the byte
            @(posedge input_intf.clock);
            input_intf.cb.TX_LOAD <= 1;
            input_intf.cb.SYN_GEN_LD <= 1;
            input_intf.cb.cs1_l <= 1;
            input_intf.cb.CRC_16 <= 1;
            input_intf.cb.RX_LOAD <= 1;
            input_intf.cb.TX_DATA <= TX_DATA;

            //Deassert the TX_LOAD, cs1_l, CRC_16, RX_LOAD signals.
            @(posedge input_intf.clock);
            input_intf.cb.TX_LOAD <= 0;
            input_intf.cb.SYN_GEN_LD <= 0;
            input_intf.cb.cs1_l <= 0;
            input_intf.cb.CRC_16 <= 0;
            input_intf.cb.RX_LOAD <= 0;
            input_intf.cb.TX_DATA <= 0;

            // Sending the byte
            drvr2sb.put(byte);
        end
    endtask
endclass