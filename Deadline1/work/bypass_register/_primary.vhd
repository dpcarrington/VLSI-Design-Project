library verilog;
use verilog.vl_types.all;
entity bypass_register is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        shift           : in     vl_logic;
        capture         : in     vl_logic;
        update          : in     vl_logic;
        tdi             : in     vl_logic;
        tdo             : out    vl_logic
    );
end bypass_register;
