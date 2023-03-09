

program testcase(input_interface.IP input_intf,output_interface.OP output_intf);

Environment env;
Packet byte;

initial
begin
$display(" ******************* Start of testcase ****************");
byte = new();
env = new(input_intf,output_intf);
env.build();
env.reset();
env.start();
env.wait_for_end();
#1000;
end

final
$display(" ******************** End of testcase *****************");


endprogram 

