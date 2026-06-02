----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.04.2026 21:32:22
-- Design Name: 
-- Module Name: mux8x1_alu - Behavioral
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

entity mux8x1_alu is
  Port ( s: in std_logic_vector(2 downto 0);
        a,b: in std_logic;
        cin: in std_logic;
        cout: out std_logic;
        f: out std_logic);
end mux8x1_alu;

architecture Behavioral of mux8x1_alu is
component Full_Adder
 Port  (a,b,cin : in std_logic;
  sum,cout : out std_logic);
end component;
signal a1,a2,a3,a4,a5,a6,a7: std_logic;
signal sum_out,carry_out: std_logic;
begin 
a1<= a and b;
a2<= a or b;
a3<= a xor b;
fa1: Full_Adder port map(
                         a=>a,
                         b=>b,
                         cin=>cin,
                         sum=>sum_out,
                         cout=>carry_out);
 a4<=not a;
 a5<=a;
 a6<= not a; -- a+1= a xor 1 (sum) ,carry= a and 1 (increment (a+1))
 a7<='0';
process(s,a1,a2,a3,sum_out,a4,a5,a6,a7)
begin
case s is 
    when "000" => f<=a1;
    when "001" => f<=a2;
    when "010" => f<=a3;
    when "011" => f<=sum_out;
    when "100" => f<=a4;
    when "101" => f<=a5;
    when "110" => f<=a6;
    when "111" => f<=a7;
    when others => f<='0';
  end case;
  end process;
cout<= carry_out when s="011" else '0';
    

end Behavioral;
