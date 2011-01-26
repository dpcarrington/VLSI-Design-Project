library verilog;
use verilog.vl_types.all;
entity basicmux is
    port(
        \select\        : in     vl_logic;
        d0              : in     vl_logic;
        d1              : in     vl_logic;
        q               : out    vl_logic
    );
end basicmux;
