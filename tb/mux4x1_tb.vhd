----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.04.2026 13:53:37
-- Design Name: 
-- Module Name: mux4x1_tb - Behavioral
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

entity mux4x1_tb is
end mux4x1_tb;

architecture Behavioral of mux4x1_tb is
component mux4x1
 Port (s: in std_logic_vector(1 downto 0);
          i: in std_logic_vector(3 downto 0);
          f:out std_logic );
end component;
signal s: std_logic_vector( 1 downto 0):="00";
signal i: std_logic_vector(3 downto 0):="0000";
signal f: std_logic;

begin
uut: mux4x1
port map(
        s => s,
        i => i,
        f => f);
        
 stim_proc: process
 begin
 i<="1010";
 s<="00"; wait for 10 ns ;
 s<="01"; wait for 10 ns;
 s<="10"; wait for 10 ns;
 s<="11"; wait for 10 ns;
 wait;
 end process;
 

end Behavioral;
