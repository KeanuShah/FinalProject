library IEEE;
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.NUMERIC_STD.ALL; 

entity pixel_pusher is 
    port(clk, en, vs, vid: in std_logic; 
         toggle0, toggle1, toggle2: in std_logic;
         switch: in std_logic_vector(3 downto 0);
         pixel: in std_logic_vector(7 downto 0); 
         hcount, vcount: in std_logic_vector (9 downto 0); 
         R,B: out std_logic_vector (4 downto 0); 
         G: out std_logic_vector (5 downto 0); 
         addr: out std_logic_vector (17 downto 0);
         class : in std_logic_vector(1 downto 0);
         curr_class: in std_logic_vector(1 downto 0);
         
         --Dmem
         window_sel: out std_logic_vector(2 downto 0);
         addrDMem: out std_logic_vector(9 downto 0);
         doutDmem: in std_logic_vector(15 downto 0);
         -- Btn Live:
         pixel_bl: in std_logic_vector(7 downto 0);
         addr_bl: out std_logic_vector(11 downto 0);
         
         --Btn View:
         pixel_v: in std_logic_vector(7 downto 0);
         addr_v: out std_logic_vector(10 downto 0);
         
         --Btn 1Sec:
         pixel_1: in std_logic_vector(7 downto 0);
         addr_1: out std_logic_vector(9 downto 0);
         
         --Btn 2Sec:
         pixel_2: in std_logic_vector(7 downto 0);
         addr_2: out std_logic_vector(9 downto 0);
         
         --Btn 5Sec:
         pixel_5: in std_logic_vector(7 downto 0);
         addr_5: out std_logic_vector(9 downto 0);
         
         --Btn 10Sec:
         pixel_10: in std_logic_vector(7 downto 0);
         addr_10: out std_logic_vector(9 downto 0);
         
         --XAxis Title:
         pixel_X: in std_logic_vector(7 downto 0);
         addr_X: out std_logic_vector(9 downto 0);
         
         --FreqAxis Title:
         pixel_Freq: in std_logic_vector(7 downto 0);
         addr_Freq: out std_logic_vector(10 downto 0);
         
         --SeverityAxis Title:
         pixel_Severity: in std_logic_vector(7 downto 0);
         addr_Severity: out std_logic_vector(10 downto 0);
         
         --Red_Class
         pixel_RC: in std_logic_vector(7 downto 0);
         addr_RC: out std_logic_vector(11 downto 0);
         
          --Yellow_Class
         pixel_YC: in std_logic_vector(7 downto 0);
         addr_YC: out std_logic_vector(11 downto 0);
         
          --Green_Class
         pixel_GC: in std_logic_vector(7 downto 0);
         addr_GC: out std_logic_vector(11 downto 0));
         
         
         
    end pixel_pusher;

architecture Behavioral of pixel_pusher is

    type state is (idle, viewTop, viewBottom, oneSec, twoSec, fiveSec, tenSec, liveData);
    signal curr, prev, prev1: state := idle;
    signal address: std_logic_vector(17 downto 0) := (others => '0');
    signal address_bl, address_RC, address_YC, address_GC : std_logic_vector(11 downto 0) := (others => '0');
    signal address_1, address_2, address_5, address_10, address_X: std_logic_vector(9 downto 0) := (others => '0');
    signal address_v, address_Freq, address_Severity : std_logic_vector(10 downto 0) := (others => '0');
    signal red, blue: std_logic_vector(4 downto 0);
    signal green: std_logic_vector(5 downto 0);
    signal toggle: std_logic_vector(2 downto 0);
    signal address_Dmem: std_logic_vector(9 downto 0) := (others => '0');
    signal clk_div: std_logic_vector(22 downto 0) := (others => '0');
    signal div: std_logic := '0';
    
begin
    addr <= address;
    addr_bl <= address_bl;
    addr_v <= address_v;
    addr_1 <= address_1;
    addr_2 <= address_2;
    addr_5 <= address_5;
    addr_10 <= address_10;
    addr_X <= address_X;
    addr_Freq <= address_Freq;
    addr_Severity <= address_Severity;
    addr_RC <= address_RC;
    addr_YC <= address_YC;
    addr_GC <= address_GC;
    R <= red;
    G <= green;
    B <= blue;
    toggle(0) <= toggle0;
    toggle(1) <= toggle1;
    toggle(2) <= toggle2;
    addrDmem <= address_Dmem;
    --addr_mem2 <= address_mem2;
    process(clk) 
    begin
    
        if rising_edge(clk) then
            if en = '1' then
                if unsigned(clk_div) < 131302 then
                    div <= '0';
                    clk_div <= std_logic_vector(unsigned(clk_div) + 1);
                else
                    div <= '1';
                    clk_div <= (others => '0');
                end if;
                
                if vid = '1' then
                    if unsigned(hcount) >= 80 and unsigned(hcount) <= 559 then
                        address <= std_logic_vector(unsigned(address) + 1);
                        red <= pixel(7 downto 5) & "00";
                        green <= pixel(4 downto 2) & "000";
                        blue <= pixel(1 downto 0) & "000";
                    else
                        red <= (others => '0');
                        green <= (others => '0');
                        blue <= (others => '0');
                    end if;
                 end if;
                 
                 if curr /= idle then
                     if (unsigned(vcount) <= 427 and unsigned(vcount) >= 255 and unsigned(hcount) = 132) or (unsigned(vcount) = 427 and unsigned(hcount) >= 132 and unsigned(hcount) <= 507) then
                         red <= (others => '1');
                         green <= (others => '1');
                         blue <= (others => '1');
                     end if;
                     
                     if unsigned(vcount) >= 439 and unsigned(vcount) <= 450 and unsigned(hcount) >= 287 and unsigned(hcount) <=351 then
                        red <= pixel_X(7 downto 5) & "00";
                        green <= pixel_X(4 downto 2) & "000";
                        blue <= pixel_X(1 downto 0) & "000";
                        address_X <= std_logic_vector(unsigned(address_X) + 1);
                    end if;
                     
                 end if;
                 
                 if prev = viewTop and (curr = viewTop or curr = oneSec or curr = twoSec or curr = fiveSec or curr = tenSec or curr = liveData) then
                    if unsigned(vcount) >= 41 and unsigned(vcount) <= 74 and unsigned(hcount) >= 488 and unsigned(hcount) <= 538 then
                        red <= pixel_v(7 downto 5) & "00";
                        green <= pixel_v(4 downto 2) & "000";
                        blue <= pixel_v(1 downto 0) & "000";
                        address_v <= std_logic_vector(unsigned(address_v) + 1);
                    end if;
                    
                    if unsigned(vcount) >= 299 and unsigned(vcount) <=387 and unsigned(hcount) >=113 and unsigned(hcount) <= 124 then
                        red <= pixel_Freq(7 downto 5) & "00";
                        green <= pixel_Freq(4 downto 2) & "000";
                        blue <= pixel_Freq(1 downto 0) & "000";
                        address_Freq <= std_logic_vector(unsigned(address_Freq) + 1);
                    end if;
                    
                 elsif prev = viewBottom and (curr = viewBottom or curr = oneSec or curr = twoSec or curr = fiveSec or curr = tenSec or curr = liveData) then
                     if unsigned(vcount) >= 106 and unsigned(vcount) <= 139 and unsigned(hcount) >= 488 and unsigned(hcount) <= 538 then
                         red <= pixel_v(7 downto 5) & "00";
                         green <= pixel_v(4 downto 2) & "000";
                         blue <= pixel_v(1 downto 0) & "000";
                         address_v <= std_logic_vector(unsigned(address_v) + 1);
                     end if;
                     
                     if unsigned(vcount) >= 298 and unsigned(vcount) <=387 and unsigned(hcount) >=112 and unsigned(hcount) <= 124 then
                        red <= pixel_Severity(7 downto 5) & "00";
                        green <= pixel_Severity(4 downto 2) & "000";
                        blue <= pixel_Severity(1 downto 0) & "000";
                        address_Severity <= std_logic_vector(unsigned(address_Severity) + 1);
                    end if;
                     
                 end if;
                 
                 if prev1 = oneSec and (curr = oneSec or curr = liveData) then
                     if unsigned(vcount) >= 194 and unsigned(vcount) <= 221 and unsigned(hcount) >= 416 and unsigned(hcount) <= 442 then
                         red <= pixel_1(7 downto 5) & "00";
                         green <= pixel_1(4 downto 2) & "000";
                         blue <= pixel_1(1 downto 0) & "000";
                         address_1 <= std_logic_vector(unsigned(address_1) + 1);
                     end if;
                 elsif prev1 = twoSec and (curr = twoSec or curr = liveData) then
                     if unsigned(vcount) >= 194 and unsigned(vcount) <= 221 and unsigned(hcount) >= 445 and unsigned(hcount) <= 471 then
                         red <= pixel_2(7 downto 5) & "00";
                         green <= pixel_2(4 downto 2) & "000";
                         blue <= pixel_2(1 downto 0) & "000";
                         address_2 <= std_logic_vector(unsigned(address_2) + 1);
                    end if;
                 elsif prev1 = fiveSec and (curr = fiveSec or curr = liveData) then
                     if unsigned(vcount) >= 194 and unsigned(vcount) <= 221 and unsigned(hcount) >= 474 and unsigned(hcount) <= 500 then
                         red <= pixel_5(7 downto 5) & "00";
                         green <= pixel_5(4 downto 2) & "000";
                         blue <= pixel_5(1 downto 0) & "000";
                         address_5 <= std_logic_vector(unsigned(address_5) + 1);
                     end if;
                 elsif prev1 = tenSec and (curr = tenSec or curr = liveData) then
                     if unsigned(vcount) >= 194 and unsigned(vcount) <= 221 and unsigned(hcount) >= 503 and unsigned(hcount) <= 536 then
                         red <= pixel_10(7 downto 5) & "00";
                         green <= pixel_10(4 downto 2) & "000";
                         blue <= pixel_10(1 downto 0) & "000";
                         address_10 <= std_logic_vector(unsigned(address_10) + 1);
                     end if;
                end if;
                
                if curr = liveData then
                    if unsigned(vcount) >= 160 and unsigned(vcount) <= 184 and unsigned(hcount) >= 265 and unsigned(hcount) <= 374 then
                        red <= pixel_bl(7 downto 5) & "00";
                        green <= pixel_bl(4 downto 2) & "000";
                        blue <= pixel_bl(1 downto 0) & "000";
                        address_bl <= std_logic_vector(unsigned(address_bl) + 1);
                    end if;
                end if;
                 
                case(curr) is
                
                    when idle =>
                        
                        if toggle(2) = '1' then
                            curr <= viewTop;
                        elsif toggle(1) = '1' then
                            curr <= viewBottom;
                        else
                            curr <= idle;
                        end if;
                    
                    when viewTop =>
                        prev <= viewTop;
                        
                        if toggle(2) = '0' then
                            curr <= idle;
                        elsif toggle(2) = '1' then
                            if switch(3) = '1' then
                                curr <= oneSec;
                            elsif switch(2) = '1' then
                                curr <= twoSec;
                            elsif switch(1) = '1' then
                                curr <= fiveSec;
                            elsif switch(0) = '1' then
                                curr <= tenSec;
                            else
                                curr <= viewTop;
                            end if;
                        end if;
                    
                    when viewBottom =>
                        prev <= viewBottom;
                        
                        if toggle(1) = '0' then
                            curr <= idle;
                        elsif toggle(1) = '1' then
                            if switch(3) = '1' then
                                curr <= oneSec;
                            elsif switch(2) = '1' then
                                curr <= twoSec;
                            elsif switch(1) = '1' then
                                curr <= fiveSec;
                            elsif switch(0) = '1' then
                                curr <= tenSec;
                            else
                                curr <= viewBottom;
                            end if;
                        end if;
                        
                        when oneSec =>
                            prev1 <= oneSec;
                            window_sel <= "001";
                            if prev = viewTop then
                                if toggle(2) = '0' then
                                    curr <= idle;
                                elsif switch(3) = '0' then
                                    curr <= viewTop;
                                elsif toggle(2) = '0' and toggle(1) = '1' then
                                    curr <= viewBottom;
                                elsif toggle(0) = '1' then
                                    curr <= liveData;
                                else
                                    curr <= oneSec;
                                end if;
                            elsif prev = viewBottom then
                                if toggle(1) = '0' then
                                    curr <= idle;
                                elsif switch(3) = '0' then
                                    curr <= viewBottom;
                                elsif toggle(1) = '0' and toggle(2) = '1' then
                                    curr <= viewTop;
                                elsif toggle(0) = '1' then
                                    curr <= liveData;
                                else
                                    curr <= oneSec;
                                end if;
                            end if;
                        
                        when twoSec =>
                            prev1 <= twoSec;
                            window_sel <= "010";
                            if prev = viewTop then
                                if toggle(2) = '0' then
                                    curr <= idle;
                                elsif switch(2) = '0' then
                                    curr <= viewTop;
                                elsif toggle(2) = '0' and toggle(1) = '1' then
                                    curr <= viewBottom;
                                elsif toggle(0) = '1' then
                                    curr <= liveData;
                                else
                                    curr <= twoSec;
                                end if;
                            elsif prev = viewBottom then
                                if toggle(1) = '0' then
                                    curr <= idle;
                                elsif switch(2) = '0' then
                                    curr <= viewBottom;
                                elsif toggle(1) = '0' and toggle(2) = '1' then
                                    curr <= viewTop;
                                elsif toggle(0) = '1' then
                                    curr <= liveData;
                                else
                                    curr <= twoSec;
                                end if;
                            end if;
                        
                        when fiveSec =>
                            prev1 <= fiveSec;
                            window_sel <= "011";
                            if prev = viewTop then
                                if toggle(2) = '0' then
                                    curr <= idle;
                                elsif switch(1) = '0' then
                                    curr <= viewTop;
                                elsif toggle(2) = '0' and toggle(1) = '1' then
                                    curr <= viewBottom;
                                elsif toggle(0) = '1' then
                                    curr <= liveData;
                                else
                                    curr <= fiveSec;
                                end if;
                            elsif prev = viewBottom then
                                if toggle(1) = '0' then
                                    curr <= idle;
                                elsif switch(1) = '0' then
                                    curr <= viewBottom;
                                elsif toggle(1) = '0' and toggle(2) = '1' then
                                    curr <= viewTop;
                                elsif toggle(0) = '1' then
                                    curr <= liveData;
                                else
                                    curr <= fiveSec;
                                end if;
                            end if;
                        
                        when tenSec =>
                            prev1 <= tenSec;
                            window_sel <= "100";
                            if prev = viewTop then
                                if toggle(2) = '0' then
                                    curr <= idle;
                                elsif switch(0) = '0' then
                                    curr <= viewTop;
                                elsif toggle(2) = '0' and toggle(1) = '1' then
                                    curr <= viewBottom;
                                elsif toggle(0) = '1' then
                                    curr <= liveData;
                                else
                                    curr <= tenSec;
                                end if;
                            elsif prev = viewBottom then
                                if toggle(1) = '0' then
                                    curr <= idle;
                                elsif switch(0) = '0' then
                                    curr <= viewBottom;
                                elsif toggle(1) = '0' and toggle(2) = '1' then
                                    curr <= viewTop;
                                elsif toggle(0) = '1' then
                                    curr <= liveData;
                                else
                                    curr <= tenSec;
                                end if;
                            end if;
                        
                        when liveData =>
                               if prev1 = oneSec then
                                    for i in 0 to 99 loop
                                        address_Dmem <= std_logic_vector(to_unsigned(i, address_Dmem'length));
                                        if unsigned(hcount) = (132 + resize((to_unsigned(i*10, 10) * 376) / 1000, 9)) and unsigned(vcount) = (427 - resize((unsigned(doutDmem) * 173) / 32768 , 9)) then
                                            if prev = viewTop then
                                                red   <= "11111";
                                                green <= "111111";
                                                blue  <= "11111";
                                            elsif prev = viewBottom then
                                                if curr_class = "00" then
                                                    red <= (others => '0');
                                                    green <= (others => '1');
                                                    blue <= (others => '0');
                                                elsif curr_class = "01" then
                                                    red <= (others => '1');
                                                    green <= (others => '1');
                                                    blue <= (others => '0');
                                                else
                                                    red <= (others => '1');
                                                    green <= (others => '0');
                                                    blue <= (others => '0');
                                                end if;
                                            end if;
                                        end if;
                                    end loop;
                                elsif prev1 = twoSec then
                                   for i in 0 to 199 loop
                                        address_Dmem <= std_logic_vector(to_unsigned(i, address_Dmem'length));
                                        if unsigned(hcount) = (132 + resize((to_unsigned(i*5, 10) * 376) / 1000, 9)) and unsigned(vcount) = (427 - resize((unsigned(doutDmem) * 173) / 32768 , 9)) then
                                            if prev = viewTop then
                                                red   <= "11111";
                                                green <= "111111";
                                                blue  <= "11111";
                                            elsif prev = viewBottom then
                                                if curr_class = "00" then
                                                    red <= (others => '0');
                                                    green <= (others => '1');
                                                    blue <= (others => '0');
                                                elsif curr_class = "01" then
                                                    red <= (others => '1');
                                                    green <= (others => '1');
                                                    blue <= (others => '0');
                                                else
                                                    red <= (others => '1');
                                                    green <= (others => '0');
                                                    blue <= (others => '0');
                                                end if;
                                            end if;
                                        end if;
                                    end loop;
                                elsif prev1 = fiveSec then
                                    for i in 0 to 499 loop
                                        address_Dmem <= std_logic_vector(to_unsigned(i, address_Dmem'length));
                                        if unsigned(hcount) = (132 + resize((to_unsigned(i*2, 10) * 376) / 1000, 9)) and unsigned(vcount) = (427 - resize((unsigned(doutDmem) * 173) / 32768 , 9)) then
                                            if prev = viewTop then
                                                red   <= "11111";
                                                green <= "111111";
                                                blue  <= "11111";
                                            elsif prev = viewBottom then
                                                if curr_class = "00" then
                                                    red <= (others => '0');
                                                    green <= (others => '1');
                                                    blue <= (others => '0');
                                                elsif curr_class = "01" then
                                                    red <= (others => '1');
                                                    green <= (others => '1');
                                                    blue <= (others => '0');
                                                else
                                                    red <= (others => '1');
                                                    green <= (others => '0');
                                                    blue <= (others => '0');
                                                end if;
                                            end if;
                                        end if;
                                    end loop;
                                elsif prev1 = tenSec then
                                    for i in 0 to 999 loop
                                        address_Dmem <= std_logic_vector(to_unsigned(i, address_Dmem'length));
                                        if unsigned(hcount) = (132 + resize((to_unsigned(i, 10) * 376) / 1000, 9)) and unsigned(vcount) = (427 - resize((unsigned(doutDmem) * 173) / 32768 , 9)) then
                                            if prev = viewTop then
                                                red   <= "11111";
                                                green <= "111111";
                                                blue  <= "11111";
                                            elsif prev = viewBottom then
                                                if curr_class = "00" then
                                                    red <= (others => '0');
                                                    green <= (others => '1');
                                                    blue <= (others => '0');
                                                elsif curr_class = "01" then
                                                    red <= (others => '1');
                                                    green <= (others => '1');
                                                    blue <= (others => '0');
                                                else
                                                    red <= (others => '1');
                                                    green <= (others => '0');
                                                    blue <= (others => '0');
                                                end if;
                                            end if;
                                        end if;
                                    end loop;
                                end if;
                            
                            if ((unsigned(vcount) >= 107 and unsigned(vcount) <= 138) or (unsigned(vcount) >= 41 and unsigned(vcount) <= 72)) and unsigned(hcount) >= 400 and unsigned(hcount) <= 481 then
                                if unsigned(class) = "00" then
                                     red <= pixel_GC(7 downto 5) & "00";
                                     green <= pixel_GC(4 downto 2) & "000";
                                     blue <= pixel_GC(1 downto 0) & "000";
                                     address_GC <= std_logic_vector(unsigned(address_GC) + 1);
                                elsif unsigned(class) = "01" then
                                     red <= pixel_YC(7 downto 5) & "00";
                                     green <= pixel_YC(4 downto 2) & "000";
                                     blue <= pixel_YC(1 downto 0) & "000";
                                     address_YC <= std_logic_vector(unsigned(address_YC) + 1);
                                else
                                     red <= pixel_RC(7 downto 5) & "00";
                                     green <= pixel_RC(4 downto 2) & "000";
                                     blue <= pixel_RC(1 downto 0) & "000";
                                     address_RC <= std_logic_vector(unsigned(address_RC) + 1);
                                end if;
                           end if;
                           
                           if unsigned(vcount) = 73 and unsigned(hcount) = 482 then
                                    address_RC <= (others => '0');
                                    address_YC <= (others => '0');
                                    address_GC <= (others => '0');
                                end if;
                            
                            if prev = viewTop then
                                if toggle(2) = '0' then
                                    curr <= idle;
                                elsif (prev1 = oneSec and switch(3) = '0') or (prev1 = twoSec and switch(2) = '0')or (prev1 = fiveSec and switch(1) = '0') or (prev1 = tenSec and switch(0) = '0') then
                                    curr <= prev;
                                elsif toggle(2) = '0' and toggle(1) = '1' then
                                    curr <= viewBottom;
                                elsif toggle(0) = '0' then
                                    curr <= prev1;
                                else
                                    curr <= liveData;
                                end if;
                                
                            elsif prev = viewBottom then
                                if toggle(1) = '0' then
                                    curr <= idle;
                                elsif (prev1 = oneSec and switch(3) = '0') or (prev1 = twoSec and switch(2) = '0') or (prev1 = fiveSec and switch(1) = '0') or (prev1 = tenSec and switch(0) = '0') then
                                    curr <= prev;
                                elsif toggle(1) = '0' and toggle(2) = '1' then
                                    curr <= viewTop;
                                elsif toggle(0) = '0' then
                                    curr <= prev1;
                                else
                                    curr <= liveData;
                                end if;
                            end if;
                            
                    end case;
                    if vs = '0' then
                        address_v <= (others => '0');
                        address_bl <= (others => '0');
                        address <= (others => '0');
                        address_1 <= (others => '0');
                        address_2 <= (others => '0');
                        address_5 <= (others => '0');
                        address_10 <= (others => '0');
                        address_X <= (others => '0');
                        address_Freq <= (others => '0');
                        address_Severity <= (others => '0');
                        address_RC <= (others => '0');
                        address_YC <= (others => '0');
                        address_GC <= (others => '0');
                     end if;  
            else
                red <= (others => '0');
                blue <= (others => '0');
                green <= (others => '0');
            end if;
        end if;
    end process;

end Behavioral;