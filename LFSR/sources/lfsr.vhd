library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity blik is
  Port ( 
  -- INPUTS
    CLK     :      IN STD_LOGIC;
  --OUTPUTS  
    REG     :      OUT STD_LOGIC_VECTOR(3 downto 0)
  );
end blik;

architecture Behavioral of blik is
SIGNAL   sig_reg         : STD_LOGIC_VECTOR(3 downto 0)  :=X"0";

begin
  PROCESS(CLK)
  BEGIN
    if rising_edge(CLK) then
      sig_reg <= not(sig_reg(1) xor sig_reg(0))  & sig_reg(3 downto 1);
    end if;
  END PROCESS;
  REG <= sig_reg;

end Behavioral;