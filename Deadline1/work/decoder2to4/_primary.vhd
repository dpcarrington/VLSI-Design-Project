library verilog;
use verilog.vl_types.all;
entity decoder2to4 is
    port(
        address         : in     vl_logic_vector(1 downto 0);
        zero            : out    vl_logic;
        one             : out    vl_logic;
        two             : out    vl_logic;
        three           : out    vl_logic
    );
end decoder2to4;
