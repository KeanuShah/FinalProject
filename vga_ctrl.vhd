
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity vga_ctrl is
    port(clk,en: in std_logic;
         hcount, vcount: out std_logic_vector(9 downto 0);
         vid, hs, vs: out std_logic;
         address: out std_logic_vector(19 downto 0));
end vga_ctrl;

architecture Behavioral of vga_ctrl is

    signal hCounter, vCounter: std_logic_vector (9 downto 0) := (others => '0');
    --signal addr: std_logic_vector(19 downto 0):= (others =>
begin

    hcount <= hCounter;
    vcount <= vCounter;
    address <= std_logic_vector(((unsigned(vCounter)*640) + (unsigned(hCounter)))) when unsigned(hCounter) < 640 and unsigned(vCounter) < 480 else (others => '0');
    process(clk)
    begin   
        
        if rising_edge(clk) then
            if en = '1' then
                if (unsigned(hCounter) < 799) then
                    hCounter  <= std_logic_vector(unsigned(hCounter) + 1);
                else
                    hCounter <= (others => '0');
                    if unsigned(vCounter) < 524 then
                        vCounter <= std_logic_vector(unsigned(vCounter) + 1);
                    else
                        vCounter <= (others => '0');
                    end if;
                end if;
                
                if (unsigned(hCounter) < 639) or (unsigned(hCounter) = 799)then
                    if (unsigned(vCounter) < 479) then
                        vid <= '1';
                    end if;
                else
                        vid <= '0';
                end if;

                if (unsigned(vCounter) = 524) and (unsigned(hCounter) = 799) then
                    vid <= '1';
                end if;
                
                if (unsigned(hCounter) > 654) and (unsigned(hCounter) < 751) then
                    hs <= '0';
                else
                    hs <= '1';
                end if;
                
                if (unsigned(vCounter) = 489 and unsigned(hCounter) = 799) or (unsigned(vCounter) > 489 and unsigned(vCounter) < 492) then
                    if (unsigned(vCounter) = 491) and (unsigned(hCounter) = 799) then
                        vs <= '1';
                    else
                        vs <= '0';
                    end if;
                else
                    vs <= '1';
                end if;
            end if;
        end if;
    end process;
end Behavioral;
