library verilog;
use verilog.vl_types.all;
entity scan_block is
    generic(
        REG_WIDTH       : integer := 8
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        shift           : in     vl_logic;
        capture         : in     vl_logic;
        update          : in     vl_logic;
        tdi             : in     vl_logic;
        tdo             : out    vl_logic
    );
end scan_block;
