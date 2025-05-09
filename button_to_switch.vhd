
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity button_to_switch is
    port(clk, dbnc: in std_logic;
        toggle: out std_logic);
end button_to_switch;

architecture Behavioral of button_to_switch is

    signal tgle: std_logic := '0';
    signal prev, curr: std_logic := '0';
    
begin

    toggle <= tgle;
    process(clk)
    begin
        if rising_edge(clk) then
            prev <= curr;
            curr <= dbnc;
           -- if rst = '1' then
             --   tgle <= '0';
            if prev = '0' and curr = '1' then
                tgle <= not(tgle);
            end if;
        end if;
    end process;
end Behavioral;
