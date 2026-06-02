----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.06.2026 17:02:04
-- Design Name: 
-- Module Name: alu_16bit - Behavioral
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

entity alu_16bit is
    Port ( 
    a,b : in std_logic_vector(15 downto 0);
    sel : in std_logic_vector(2 downto 0);
    result: out std_logic_vector(15 downto 0);
    carry: out std_logic; 
    zero: out std_logic);
end alu_16bit;

architecture Behavioral of alu_16bit is
     signal result_int : STD_LOGIC_VECTOR(15 downto 0);

begin
process(a,b,sel)
variable  temp: unsigned(16 downto 0);
begin
    carry<='0';
    case sel is 
    when "000" =>            --addition
        temp:=('0'& unsigned(a)) + ('0' & unsigned(b));
        result_int<= std_logic_vector(temp(15 downto 0));
        carry<= temp(16);
    when "001" =>            --subtraction
        temp:=('0' & unsigned(a)) - ('0' & unsigned(b));
        result_int<=std_logic_vector(temp(15 downto 0));
        carry<= temp(16);
    when "010" => --AND
        result_int<= a and b; 
    when "011" => --or
        result_int<= a or b;
    when "100" =>   --XOR
        result_int<= a xor b;        
    when "101" =>       --not a
        result_int<= not a;
    when "110" => --shift left
        result_int<= std_logic_vector(shift_left(unsigned(a),1));
        
    when "111" => --shift right 
        result_int<= std_logic_vector(shift_right(unsigned(a),1));
    when others =>
        result_int<= (others => '0');
    
    end case;
 
   end process;

    result <= result_int;

    zero <= '1' when result_int = x"0000"
        else '0';


   
end Behavioral;
