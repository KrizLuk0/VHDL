library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity tb is
--  Port ( );
end tb;

architecture Behavioral of tb is


CONSTANT clk_period             : TIME := 20 ns;
SIGNAL simulation_finished      : BOOLEAN := FALSE;
SIGNAL sig_reg                 : STD_LOGIC_VECTOR(3 downto 0)  :=X"0";
SIGNAL CLK                     : STD_LOGIC;

 
COMPONENT blik
PORT(
  -- INPUTS
    CLK     :      IN STD_LOGIC;
  --OUTPUTS  
    REG     :      OUT STD_LOGIC_VECTOR(3 downto 0)
); 
END COMPONENT blik;
begin
blik_i : blik
PORT MAP(
CLK => CLK,
REG => sig_reg
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
    VARIABLE y_ref: STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
 BEGIN
 y_ref := not(sig_reg(1) xor sig_reg(0)) & sig_reg(3 downto 1);
 wait on sig_reg;
 ASSERT (sig_reg = y_ref) REPORT
    "Error!!! acutal =" & INTEGER'image(TO_INTEGER(UNSIGNED(sig_reg))) &

    " expected y=" & INTEGER'image(TO_INTEGER(UNSIGNED(y_ref)))
 SEVERITY WARNING;
 
 END PROCESS output_checker;
end Behavioral;