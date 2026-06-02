----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.06.2026 21:45:57
-- Design Name: 
-- Module Name: alu_16bit_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all; 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu_16bit_tb is
end alu_16bit_tb;

architecture Behavioral of alu_16bit_tb is

    component alu_16bit
    Port ( 
    a,b : in std_logic_vector(15 downto 0);
    sel : in std_logic_vector(2 downto 0);
    result: out std_logic_vector(15 downto 0);
    carry: out std_logic; 
    zero: out std_logic);
end component;
signal a: std_logic_vector(15 downto 0);
signal b: std_logic_vector(15 downto 0);
signal sel: std_logic_vector(2 downto 0);
signal result: std_logic_vector(15 downto 0);
signal carry: std_logic; 
signal zero: std_logic; 

begin
    uut: alu_16bit
        port map(
        a=>a ,
        b=> b,
        sel=> sel, 
        result=> result, 
        carry=> carry, 
        zero=> zero);
    stim_proc: process
    begin
        --addition (5+8)
        a<=x"0005";
        b<=x"0008";
        sel<="000";
        wait for 20 ns;
        
        --subtraction(10-5)
        a<=x"000a";
        b<=x"0005";
        sel<="001";
        wait for 20 ns;
        
        --and
        a<=x"00ff";
        b<=x"0f0f";
        sel<="010";
        wait for 20 ns;
        
        --or
        a<=x"00ff";
        b<=x"0f0f";
        sel<="011";
        wait for 20 ns;
        
          -- XOR
        a <= x"00FF";
        b <= x"0F0F";
        sel <= "100";
        wait for 20 ns;

        -- NOT A
        a <= x"00FF";
        b <= x"0000";
        sel <= "101";
        wait for 20 ns;

        -- SHIFT LEFT
        a <= x"0004";
        b <= x"0000";
        sel <= "110";
        wait for 20 ns;

        -- SHIFT RIGHT
        a <= x"0008";
        b <= x"0000";
        sel <= "111";
        wait for 20 ns;

        -- ZERO FLAG TEST (5 - 5 = 0)
        a <= x"0005";
        b <= x"0005";
        sel <= "001";
        wait for 20 ns;
        
        wait;
    end process;
end Behavioral;
