----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.04.2026 21:41:20
-- Design Name: 
-- Module Name: alu_4bit - Behavioral
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

entity alu_4bit is
    generic(n : integer :=4);
  Port (s : in std_logic_vector(2 downto 0);
        a : in std_logic_vector(n-1 downto 0);
        b : in std_logic_vector(n-1 downto 0);
        cin: in std_logic;
        f: out std_logic_vector(n-1 downto 0);
        cout: out std_logic );
end alu_4bit;

architecture Behavioral of alu_4bit is
component mux8x1_alu 
Port ( s: in std_logic_vector(2 downto 0);
        a,b: in std_logic;
        cin: in std_logic;
        cout: out std_logic;
        f: out std_logic);
end component;
signal c: std_logic_vector(n downto 0);

begin
--initial carry
c(0)<=cin;
alu_gen: for i in 0 to n-1 generate

alu: mux8x1_alu 
port map(s=> s,
         a=> a(i),
         b=>b(i),
         cin=>c(i),
         f=>f(i),
         cout=>c(i+1));
end generate; 
cout<=c(n);
         


end Behavioral;
