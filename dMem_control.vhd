
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity dMem is
      PORT (
        clk, en, rst : IN STD_LOGIC;
        din: in std_logic_vector(15 downto 0);
        window: in std_logic_vector(2 downto 0);
        datardy: out std_logic;
        dout: out std_logic_vector(15 downto 0);
        addr: in std_logic_vector(9 downto 0)
      );
end dMem;

architecture Behavioral of dMem is

    type mem_type is array (0 to 999) of std_logic_vector(15 downto 0);
    signal mem: mem_type := (others => (others => '0'));
    signal address: std_logic_vector(9 downto 0);
    signal current_window_size : integer := 0;

begin
    
    process(window)
    begin
        case window is
            when "001" => current_window_size <= 100;
            when "010" => current_window_size <= 200;
            when "011" => current_window_size <= 500;
            when "100" => current_window_size <= 1000;
            when others => current_window_size <= 0;
        end case;
    end process;
    
    dout <= mem(to_integer(unsigned(addr)));
    
    process(clk)
    begin
        if rising_edge(clk) then
           if rst = '1' then
               mem <= (others => (others => '0'));
               address <= (others => '0');
               datardy <= '0';
           elsif en = '1' then
               mem(to_integer(unsigned(address))) <= din;
               if unsigned(address) < current_window_size - 1 then
                   address <= std_logic_vector(unsigned(address) + 1);
                   datardy <= '0';
               else
                   datardy <= '1';
                   address <= (others => '0');
               end if;
           end if;
       end if;
   end process;
end Behavioral;
