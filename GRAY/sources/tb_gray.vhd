library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_gray is
--  Port ( );
end tb_gray;

architecture Behavioral of tb_gray is

SIGNAL gray_sig : STD_LOGIC_VECTOR(3 downto 0):= X"0";
SIGNAL bin_sig : STD_LOGIC_VECTOR(3 downto 0) := X"0";
SIGNAL CLK                     : STD_LOGIC;
CONSTANT clk_period             : TIME := 20 ns;
SIGNAL simulation_finished      : BOOLEAN := FALSE;

COMPONENT gray
PORT(
--INPUTS
  CLK           : IN STD_LOGIC;
  
--OUTPUTS
  GRAYOUT       : OUT STD_LOGIC_VECTOR(3 downto 0)

);
END COMPONENT;

begin
 gray_i: gray
 PORT MAP(
 CLK        => CLK,
 GRAYOUT    => gray_sig
 );

proc_clk_gen: PROCESS BEGIN
    CLK <= '0'; WAIT FOR clk_period/2;
    CLK <= '1'; WAIT FOR clk_period/2;
    IF simulation_finished THEN
    WAIT;
    END IF;
  END PROCESS proc_clk_gen;
  
tim_proc: process
    begin
        wait for 400ns;
        assert false report "Konec simulace" severity failure;
    end process tim_proc;  
    
 output_checker: PROCESS
    VARIABLE gray_ref: STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
 BEGIN
 bin_sig  <= std_logic_vector(unsigned(bin_sig) + 1);
 gray_ref := bin_sig(3) & (bin_sig(3) XOR bin_sig(2))& (bin_sig(2) XOR bin_sig(1))& (bin_sig(1) XOR bin_sig(0));
 wait on gray_sig;
 ASSERT (gray_sig = gray_ref) REPORT
    "Error!!! acutal =" & INTEGER'image(TO_INTEGER(UNSIGNED(gray_sig))) &

    " expected y=" & INTEGER'image(TO_INTEGER(UNSIGNED(gray_ref)))
 SEVERITY WARNING;
 END PROCESS output_checker;

end Behavioral;
