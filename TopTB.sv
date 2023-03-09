module top_tb();

  bit clock;

  initial
  forever #10 clock = ~clock;

  in_intf i_intf(clock);
  out_intf o_intf(clock); 

  
  usb_top dut(
    .gclk(gclk),
    .reset_l(i_intf.reset_l),
    .cs1_l(i_intf.cs1_l),
    .SYN_GEN_LD(i_intf.SYN_GEN_LD),
    .TX_LOAD(i_intf.TX_LOAD),
    .TX_DATA(i_intf.TX_DATA),
    .TX_LAST_BYTE(i_intf.TX_LAST_BYTE),
    .RX_LOAD(i_intf.RX_LOAD),

    .TX_READY_LD(o_intf.TX_READY_LD),//Notice how you can change from one place ONLY.
    .DATA(o_intf.DATA),
    .RX_READY_LD(o_intf.RX_READY_LD)

  );
  
endmodule