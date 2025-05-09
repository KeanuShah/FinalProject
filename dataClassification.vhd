
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity dataClassification is
    port(clk, rst: in std_logic;
         ang_max: in std_logic_vector(15 downto 0);
         class:          out std_logic_vector(1 downto 0));
end dataClassification;

architecture Behavioral of dataClassification is

    constant angular_normal: integer := 8192;
    constant angular_mild  : integer := 16384;

begin

    process(clk)
    begin
        
        if rising_edge(clk) then
           if rst = '1' then
               class <= "00";
           elsif unsigned(ang_max) < angular_normal then
                  class <= "00";
               elsif unsigned(ang_max) < angular_mild then
                   class <= "01";
               else
                   class <= "10";
           end if;
       end if; 
   end process;    
end Behavioral;
