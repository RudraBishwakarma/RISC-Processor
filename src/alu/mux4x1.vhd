----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.04.2026 13:42:09
-- Design Name: 
-- Module Name: mux4x1 - Behavioral
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

entity mux4x1 is
    Port (s: in std_logic_vector(1 downto 0);
          i: in std_logic_vector(3 downto 0);
          f:out std_logic );
end mux4x1;

architecture Behavioral of mux4x1 is

begin
process(s,i)
begin 
    case s is
        when "00" => f<=i(0);
        when "01" => f<=i(1);
        when "10" => f<=i(2);
        when "11" => f<=i(3);
        when others => f<='0';
        end case;
     end process;
end Behavioral;
