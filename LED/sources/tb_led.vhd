
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity tb_led is
--  Port ( );
end tb_led;

architecture Behavioral of tb_led is

COMPONENT led
Port ( 
  --INPUTS
    BTN         : IN STD_LOGIC_VECTOR(3 downto 0);
    CLK         : IN STD_LOGIC;
  
  --OUTPUTS
    LED         :OUT STD_LOGIC_VECTOR(7 downto 0);
    CNT_OUT     :OUT INTEGER
);
END COMPONENT;

SIGNAL btn_sig                  : STD_LOGIC_VECTOR(3 downto 0) := X"0";
SIGNAL led_sig                  : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
SIGNAL CLK                      : STD_LOGIC;
CONSTANT clk_period             : TIME := 20 ns;
SIGNAL simulation_finished      : BOOLEAN := FALSE;
SIGNAL cnt_down                 : integer := 0;


begin
led_i: led
PORT MAP(
    BTN     => btn_sig,
    CLK     => CLK,
    LED     => led_sig,
    CNT_OUT => cnt_down
);
proc_clk_gen: PROCESS BEGIN
    CLK <= '0'; WAIT FOR clk_period/2;
    CLK <= '1'; WAIT FOR clk_period/2;
    IF simulation_finished THEN
    WAIT;
    END IF;
  END PROCESS proc_clk_gen;
  
stim_proc: process
    begin
        btn_sig <= "0001";
        wait for 100ns;
        btn_sig <= "0010";
        wait for 100ns;
        btn_sig <= "0100";
        wait for 100ns;
        btn_sig <= "1000";
        wait for 100ns;    
    assert false report "Konec simulace" severity failure;                    
end process stim_proc;  
    
 output_checker: PROCESS
    VARIABLE ref_cnt_down: integer := 0;
 BEGIN
 wait for 0 ns;
 if btn_sig <= "0001" then
    ref_cnt_down := 1;
 elsif btn_sig <= "0010" then
    ref_cnt_down := 2;
 elsif btn_sig <= "0100" then
    ref_cnt_down := 3;
 elsif btn_sig <= "1000" then
    ref_cnt_down := 4;
 else 
    ref_cnt_down := 0;
 end if;
 wait on cnt_down;
 ASSERT (ref_cnt_down = cnt_down) REPORT
    "Error!!! acutal =" & INTEGER'image(cnt_down) &

    " expected y=" & INTEGER'image(ref_cnt_down)
 SEVERITY WARNING;
 END PROCESS output_checker;

end Behavioral;
