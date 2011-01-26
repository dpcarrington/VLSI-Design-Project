library verilog;
use verilog.vl_types.all;
entity \register\ is
    generic(
        WIDTH           : integer := 8;
        RESET_TO        : integer := 1
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        shift           : in     vl_logic;
        update          : in     vl_logic;
        parallel_data   : in     vl_logic_vector;
        tdi             : in     vl_logic;
        q               : out    vl_logic_vector;
        tdo             : out    vl_logic
    );
end \register\;
