library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity gray is
  Port ( 
  --INPUTS
  CLK           : IN STD_LOGIC;
  
  --OUTPUTS
  GRAYOUT       : OUT STD_LOGIC_VECTOR(3 downto 0)
  );
end gray;

architecture Behavioral of gray is
SIGNAL gray_sig : STD_LOGIC_VECTOR(3 downto 0):= X"0";
SIGNAL bin_sig : STD_LOGIC_VECTOR(3 downto 0) := X"0";

begin
PROCESS(CLK)
BEGIN
    if rising_edge(CLK) then
        bin_sig  <= std_logic_vector(unsigned(bin_sig) + 1);
        gray_sig <= bin_sig(3) & (bin_sig(3) XOR bin_sig(2))& (bin_sig(2) XOR bin_sig(1))& (bin_sig(1) XOR bin_sig(0));
    end if;
END PROCESS;
GRAYOUT <= gray_sig;


end Behavioral;
