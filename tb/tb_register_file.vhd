----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.06.2026 10:44:05
-- Design Name: 
-- Module Name: tb_register_file - Behavioral
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

entity tb_register_file is
end tb_register_file;

architecture Behavioral of tb_register_file is
component register_file
     Port (
    clk: in std_logic; --clock
    reset: in std_logic; --reset
    reg_write: in std_logic;   --write enable
    read_reg1, read_reg2, write_reg: in std_logic_vector(3 downto 0); 
     write_data: in std_logic_vector(15 downto 0); --write data
     read_data1, read_data2: out std_logic_vector(15 downto 0));
end component;
signal clk: std_logic:= '0';
signal reset: std_logic:= '1';
signal reg_write: std_logic:='0'; 
signal read_reg1, read_reg2, write_reg: std_logic_vector(3 downto 0) :=(others=>'0');
signal write_data: std_logic_vector(15 downto 0);
signal read_data1, read_data2: std_logic_vector(15 downto 0); 

constant clk_period: time:= 10 ns;
begin
uut: register_file port map(
                       clk=> clk,
                       reset=> reset,
                       reg_write=>reg_write,
                       read_reg1=>read_reg1,
                       read_reg2=>read_reg2,
                       write_reg=>write_reg,
                       write_data=>write_data,
                       read_data1=>read_data1,
                       read_data2=>read_data2
                       );
      clk_process: process
      begin
        clk<='0';
        wait for clk_period/2;
        clk<='1';
        wait for clk_period/2; 
        end process;  
        
      stimulus: process 
      begin
      --test1: reset
        reset<='1';
        wait for 20 ns;
        reset<='0';
        wait for 10 ns;
      --test 2 write to R3
        write_reg<="0011";
        write_data<=x"1234";
        reg_write<='1';
        wait for 10 ns;
        reg_write<='0';
        wait for 10 ns;
        --read back R3 to verify
        read_reg1<="0011"; --read R3
        wait for 10 ns;  --data expected x"1234"
        -- test 3 write to R0 which should be ==0
        write_reg<="0000";
        write_data<=x"abcd";
        reg_write<='1';
        wait for 10 ns;
        reg_write<='0';
        wait for 10 ns;
        --read RO expected output x"0000"
        read_reg1<="0000";
        wait for 10 ns;
        --test 4 write multiple register 
        write_reg<="0100" ;--R5;
        write_data<=x"5555";
        reg_write<='1';
        wait for 10 ns;
        write_reg<="1010"; --R10
        write_data<=x"aaaa";
        wait for 10 ns;
        write_reg<="1111";
        write_data<=x"ffff";
        wait for 10 ns;
        reg_write<='0';
        wait for 10 ns;
        
        --Read two register simultaneously 
        read_reg1<="0101"; --R5
        read_reg2<="1010"; --R10
        wait for 10 ns;
        
        --Test reset again
        reset<='1';
        wait for 10 ns;
        reset<='0';
        --after reset all should be zero
        read_reg1<="0011"; --R3
        read_reg2<="1111";  --R15
        wait for 10 ns;
        
        wait;
      end process;
end Behavioral;
