library verilog;
use verilog.vl_types.all;
library work;
entity control is
    port(
        clk             : in     vl_logic;
        opcode          : in     work.lc3b_types.lc3b_opcode;
        imm5_enable     : in     vl_logic;
        jsr_enable      : in     vl_logic;
        branch_enable   : in     vl_logic;
        byte_enable     : in     vl_logic_vector(1 downto 0);
        dshf            : in     vl_logic;
        ashf            : in     vl_logic;
        pcmux_sel       : out    vl_logic_vector(1 downto 0);
        storemux_sel    : out    vl_logic;
        alumux_sel      : out    vl_logic_vector(2 downto 0);
        regfilemux_sel  : out    vl_logic_vector(1 downto 0);
        marmux_sel      : out    vl_logic_vector(1 downto 0);
        mdrmux_sel      : out    vl_logic_vector(1 downto 0);
        adjmux_sel      : out    vl_logic;
        destmux_sel     : out    vl_logic;
        load_pc         : out    vl_logic;
        load_ir         : out    vl_logic;
        load_mdr        : out    vl_logic;
        load_mar        : out    vl_logic;
        load_cc         : out    vl_logic;
        load_regfile    : out    vl_logic;
        aluop           : out    work.lc3b_types.lc3b_aluop;
        byte_check      : out    vl_logic;
        mem_resp        : in     vl_logic;
        mem_read        : out    vl_logic;
        mem_write       : out    vl_logic;
        mem_byte_enable : out    vl_logic_vector(1 downto 0)
    );
end control;
