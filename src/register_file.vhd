----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.06.2026 00:03:02
-- Design Name: 
-- Module Name: register_file - Behavioral
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

entity register_file is
    Port (
    clk: in std_logic; --clock
    reset: in std_logic; --reset
    reg_write: in std_logic;   --write enable
    read_reg1, read_reg2, write_reg: in std_logic_vector(3 downto 0); 
     write_data: in std_logic_vector(15 downto 0); --write data
     read_data1, read_data2: out std_logic_vector(15 downto 0));
end register_file;

architecture Behavioral of register_file is
type reg_array_type is array (0 to 15) of std_logic_vector(15 downto 0);
--Define register array type : 16 register of 16 bits each
signal reg_array: reg_array_type:=(others=>(others=>'0'));
begin
process(clk, reset)
begin
    if reset='1' then
        --clear all regiester on reset(asyncronous reset)
        reg_array<=(others=>(others=>'0'));
    elsif rising_edge(clk) then 
        if reg_write='1' then
        --only write to non zero register(R0is read only ZERO)
        if write_reg/="0000" then 
            --convert the 4 bit address to integer, write data is stored as before no convertion 
            reg_array(to_integer(unsigned(write_reg)))<=write_data;
        end if;
            --Force R0 to zero
            reg_array(0)<=(others=>'0');
            end if; end if; 
            end process;
 --read data immediately when addressing change and R0 always remain as zero
 read_data1<=reg_array(TO_INTEGER(unsigned(read_reg1)));
 read_data2<=reg_array(TO_INTEGER(unsigned(read_reg2)));
 

end Behavioral;
