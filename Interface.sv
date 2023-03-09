interface in_intf(input bit clk);
    
        logic reset_l;
        logic cs1_l; //Enabling bit stuffing.
        logic SYN_GEN_LD;
        logic CRC_16;
        logic TX_LOAD;
        logic [7:0]  TX_DATA;
        logic TX_LAST_BYTE;
        logic RX_LOAD;

        clocking  cb(posedge clk);
            default input #2 output #2;
            output cs1_l; 
            output SYN_GEN_LD;
            output CRC_16;
            output TX_LOAD;
            output TX_LAST_BYTE;
            output RX_LOAD;
        endclocking

        modport IP (clocking cb, input clk, output reset_l);

endinterface

////////////////////////////////////////////

interface out_intf(input bit clk);
    logic TX_READY_LD;
    logic T_lastbit;
    logic [8:0]  qualify_out;
    logic error_crc_rx;
    logic [7:0]  DATA;
    logic RX_READY_LD;
    logic RX_LAST_BYTE;

    clocking  cb(posedge clk);
            default input #2 output #2;
            input TX_READY_LD;
            input T_lastbit;
            input qualify_out;
            input error_crc_rx;
            input DATA;
            input RX_READY_LD;
            input RX_LAST_BYTE;
    endclocking

    modport OUT(clocking  cb, input clk);
endinterface
