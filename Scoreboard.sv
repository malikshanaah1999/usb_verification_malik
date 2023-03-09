class Scoreboard;
    mailbox drvr2sb;
    mailbox rcvr2sb;
    coverage cov = new();

    function new(mailbox drvr2sb,mailbox rcvr2sb);
        this.drvr2sb = drvr2sb;
        this.rcvr2sb = rcvr2sb;
    endfunction:new

    task start();
    forever
    begin
    rcvr2sb.get(byte_rcv);
    drvr2sb.get(byte_exp);
    if(byte_rcv.compare(byte_exp)) 
    begin
        $display(" %0d : Scoreboardd :Packet Matched ",$time);
        cov.sample(byte_exp);
    end
    end
    endtask
endclass