----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.04.2026 12:39:16
-- Design Name: 
-- Module Name: Full_Adder - Behavioral
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
entity Full_Adder is
  Port  (a,b,cin: in std_logic;
  sum,cout: out std_logic);
end Full_Adder;
architecture Behavioral of Full_Adder is
begin
sum<=(a xor b)xor cin;
cout<= (a and b) or (b and cin) or (a and cin);
end Behavioral;
