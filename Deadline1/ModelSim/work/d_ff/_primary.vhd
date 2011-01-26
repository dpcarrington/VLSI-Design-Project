library verilog;
use verilog.vl_types.all;
entity d_ff is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        enable          : in     vl_logic;
        d               : in     vl_logic;
        q               : out    vl_logic;
        rstvalue        : in     vl_logic
    );
end d_ff;
