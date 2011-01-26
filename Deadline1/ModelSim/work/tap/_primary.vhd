library verilog;
use verilog.vl_types.all;
entity tap is
    generic(
        Run_Test_Idle   : integer := 0;
        Select_Dr       : integer := 1;
        \Capture_Dr\    : integer := 2;
        \Shift_Dr\      : integer := 3;
        Exit1_Dr        : integer := 4;
        Pause_Dr        : integer := 5;
        Exit2_Dr        : integer := 6;
        \Update_Dr\     : integer := 7;
        \Reset\         : integer := 8;
        Select_Ir       : integer := 9;
        \Capture_Ir\    : integer := 10;
        \Shift_Ir\      : integer := 11;
        Exit1_Ir        : integer := 12;
        Pause_Ir        : integer := 13;
        Exit2_Ir        : integer := 14;
        \Update_Ir\     : integer := 15
    );
    port(
        tck             : in     vl_logic;
        tms             : in     vl_logic;
        reset           : out    vl_logic;
        \select\        : out    vl_logic;
        enable          : out    vl_logic;
        clock_ir        : out    vl_logic;
        capture_ir      : out    vl_logic;
        shift_ir        : out    vl_logic;
        update_ir       : out    vl_logic;
        clock_dr        : out    vl_logic;
        capture_dr      : out    vl_logic;
        shift_dr        : out    vl_logic;
        update_dr       : out    vl_logic
    );
end tap;
