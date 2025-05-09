

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity clock_div is
    port(clk: in std_logic;
         div: out std_logic);
        
end clock_div;

architecture Behavioral of clock_div is
    signal count : std_logic_vector (10 downto 0) := (others => '0');
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if unsigned(count) < 4 then
                    div <= '0'; 
                    count <= std_logic_vector (unsigned(count) + 1);
                else
                   div <= '1';
                   count <= (others => '0');
            end if;
        end if;
    end process;

end Behavioral;
