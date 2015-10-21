library verilog;
use verilog.vl_types.all;
entity byte_extend is
    generic(
        width           : integer := 16
    );
    port(
        address         : in     vl_logic_vector(15 downto 0);
        \in\            : in     vl_logic_vector(15 downto 0);
        byte_check      : in     vl_logic;
        byte_enable     : out    vl_logic_vector(1 downto 0);
        \out\           : out    vl_logic_vector(15 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of width : constant is 1;
end byte_extend;
