
class Packet;

    rand logic [7:0] TX_DATA;
    int compare;

    virtual function void display();
        $display("Data_TX = %h",TX_DATA );
    endfunction


    virtual function bit compare(packet byte);
    compare = 1;
    if(pkt == null)
    begin
        $display(" ** ERROR ** : pkt : received a null object ");
        compare = 0;
    end
    else
      begin
         if(byte.TX_DATA !== this.TX_DATA)
         begin
            $display(" ** ERROR ** Data field did not match");
            compare = 0;
         end
      end
    endfunction


endclass