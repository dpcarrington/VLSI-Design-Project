library verilog;
use verilog.vl_types.all;
entity shadow_register is
    generic(
        WIDTH           : integer := 8;
        RESET_TO        : integer := 1
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        enable          : in     vl_logic;
        data            : in     vl_logic_vector;
        q               : out    vl_logic_vector
    );
end shadow_register;
