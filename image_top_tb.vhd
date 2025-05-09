library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity image_top_tb is
end image_top_tb;

architecture Behavioral of image_top_tb is

    component tremor_top_wrapper is
    port(clk, btn0, btn1, btn2, btn3, SDO: in std_logic;
         vga_hs, vga_vs, led0, led1, led2, SCK, CS, SDI: out std_logic;
         sw: in std_logic_vector(3 downto 0);
         vga_r, vga_b: out std_logic_vector (4 downto 0);
         vga_g: out std_logic_vector (5 downto 0));
         
    end component;
    
    signal tb_clk, tb_vga_hs, tb_vga_vs: std_logic; 
    signal btn0, btn1: std_logic := '1';
    signal btn2, btn3, SCK, CS, SDI, SDO, led0, led1, led2: std_logic;
    signal tb_vga_r, tb_vga_b: std_logic_vector (4 downto 0);
    signal tb_sw: std_logic_vector(3 downto 0);
    signal tb_vga_g: std_logic_vector (5 downto 0);
    
begin

    dut: tremor_top_wrapper port map (clk => tb_clk, vga_hs => tb_vga_hs, vga_vs => tb_vga_vs, btn0 => btn0, btn1 => btn1, btn2 => btn2, btn3 => btn3, 
                                      SCK => SCK, CS => CS, SDI => SDI, SDO => SDO, led0 => led0, led1 => led1, led2 => led2, vga_r => tb_vga_r,
                                      vga_b => tb_vga_b, vga_g => tb_vga_g, sw => tb_sw); 
    
    clk_gen_proc:process
    begin
        SDO <= '1';
        tb_sw(0) <= '1';
        tb_clk <= '0';
        wait for 4 ns;
        tb_clk <= '1';
        wait for 4 ns;
    end process;

   
end Behavioral;
