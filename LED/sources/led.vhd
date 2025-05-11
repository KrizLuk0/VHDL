library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity led is
  Port ( 
  --INPUTS
    BTN         : IN STD_LOGIC_VECTOR(3 downto 0);
    CLK         : IN STD_LOGIC;
  
  --OUTPUTS
    LED         :OUT STD_LOGIC_VECTOR(7 downto 0);
    CNT_OUT     :OUT INTEGER
  );
end led;

architecture Behavioral of led is
    SIGNAL cnt_blik     : STD_LOGIC := '0';
    SIGNAL cnt_down     : integer := 0;
begin

PROCESS(CLK)
BEGIN
    if rising_edge(CLK) then
        if cnt_down =0 then
            case BTN is
                when "0001" => cnt_down <= 1;
                when "0010" => cnt_down <= 2;
                when "0100" => cnt_down <= 3;
                when "1000" => cnt_down <= 4;       
                when OTHERS => cnt_down <= 0;       
             end case;   
             
         elsif cnt_down > 0 then
            if cnt_blik ='0' then
                cnt_blik <='1';
             else
                cnt_blik <='0';
                cnt_down <= cnt_down -1;
            end if;
            
         else
            cnt_down <= 0;       
        end if;
    end if;

END PROCESS;
LED  <= (others => cnt_blik);
CNT_OUT <= cnt_down;

end Behavioral;
