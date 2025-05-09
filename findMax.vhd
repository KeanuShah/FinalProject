
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity findMax is
    port(clk: in std_logic;
         AX,AY,AZ:   in std_logic_vector(15 downto 0);
         datardy:          in std_logic;
         ang_max: out std_logic_vector(15 downto 0));
end findMax;

architecture Behavioral of findMax is

begin

    process(clk)
    begin
        
        if rising_edge(clk) then 
                if datardy = '1' then
                    if ((abs(signed(AX))) >= (abs(signed(AY)))) and ((abs(signed(AX))) >=(abs(signed(AZ)))) then
                        ang_max <= std_logic_vector(abs(signed(AX)));
                    elsif ((abs(signed(AY))) >= (abs(signed(AX)))) and ((abs(signed(AY))) >=(abs(signed(AZ)))) then
                        ang_max <= std_logic_vector(abs(signed(AY)));
                    else
                        ang_max <= std_logic_vector(abs(signed(AZ)));
                    end if;
                end if;
            end if;
    end process;
                
   
end Behavioral;
