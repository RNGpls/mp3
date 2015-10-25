library verilog;
use verilog.vl_types.all;
library work;
entity datapath is
    port(
        clk             : in     vl_logic;
        imem_resp       : in     vl_logic;
        imem_rdata      : in     vl_logic_vector(15 downto 0);
        dmem_resp       : in     vl_logic;
        dmem_rdata      : in     vl_logic_vector(15 downto 0);
        control         : in     work.lc3b_types.lc3b_control_word;
        imem_address    : out    vl_logic_vector(15 downto 0);
        dmem_address    : out    vl_logic_vector(15 downto 0);
        dmem_wdata      : out    vl_logic_vector(15 downto 0);
        instruction     : out    vl_logic_vector(15 downto 0);
        dmem_read       : out    vl_logic;
        dmem_write      : out    vl_logic
    );
end datapath;
