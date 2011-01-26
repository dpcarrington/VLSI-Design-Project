library verilog;
use verilog.vl_types.all;
entity project is
    generic(
        REGISTER_WIDTH  : integer := 8
    );
    port(
        tdi             : in     vl_logic;
        tms             : in     vl_logic;
        tck             : in     vl_logic;
        tdo             : out    vl_logic
    );
end project;
