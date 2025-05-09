
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity debounce is
    port(clk: in std_logic;
         btn: in std_logic;
         dbnc: out std_logic);
end debounce;

architecture Behavioral of debounce is

  signal counter: std_logic_vector(21 downto 0) := (others => '0');
  signal Q: std_logic_vector(1 downto 0) := (others => '0');

begin
    process(clk)
    begin
        if rising_edge(clk) then
            if unsigned(counter) = 2500000 then 
                dbnc <= '1';
                Q(1) <= Q(0);
                Q(0) <= btn;
                if (Q(0) = '0') then
                    counter <= (others => '0');
                end if;
            else 
                dbnc <= '0';
                Q(1) <= Q(0);
                Q(0) <= btn;
                if (Q(1) = '1') then
                    counter <= std_logic_vector (unsigned(counter) + 1);
                    if (Q(0) = '0') then
                        counter <= (others => '0');
                    end if;
                end if;
            end if;
         end if;
    end process;

end Behavioral;
