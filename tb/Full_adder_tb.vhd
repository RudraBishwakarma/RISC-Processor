----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.04.2026 12:49:26
-- Design Name: 
-- Module Name: Full_adder_tb - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Full_adder_tb is
end Full_adder_tb;

architecture Behavioral of Full_adder_tb is
component full_adder
Port  (a,b,cin: in std_logic;
  sum,cout: out std_logic);
end component;

signal a,b,cin: std_logic:='0';
signal sum,cout: std_logic;
begin

uut: full_adder
port map(
           a=> a,
           b=> b,
           cin=> cin,
           sum => sum,
           cout => cout);
stim_proc: process
begin 
        a<='0'; b<='0'; cin<='0';
        wait for 10 ns;
        a<='0'; b<='0'; cin<='1';
        wait for 10 ns;
        a<='0'; b<='1'; cin<='0';
        wait for 10 ns;
        a<='0'; b<='1'; cin<='1';
        wait for 10 ns;
        a<='1'; b<='0'; cin<='0';
        wait for 10 ns;
        a<='1'; b<='0'; cin<='1';
        wait for 10 ns;
        a<='1'; b<='1'; cin<='0';
        wait for 10 ns;
        a<='1'; b<='1'; cin<='1';
        wait for 10 ns;
        wait;
        end process;
end Behavioral;
