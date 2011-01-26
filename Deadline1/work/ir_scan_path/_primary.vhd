library verilog;
use verilog.vl_types.all;
entity ir_scan_path is
    generic(
        REG_WIDTH       : integer := 2
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        shift           : in     vl_logic;
        capture         : in     vl_logic;
        update          : in     vl_logic;
        tdi             : in     vl_logic;
        status          : in     vl_logic_vector;
        tdo             : out    vl_logic;
        instruction     : out    vl_logic_vector
    );
end ir_scan_path;
