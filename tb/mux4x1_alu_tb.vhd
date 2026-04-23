----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.04.2026 15:33:41
-- Design Name: 
-- Module Name: mux4x1_alu_tb - Behavioral
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

entity mux4x1_alu_tb is
end mux4x1_alu_tb;

architecture Behavioral of mux4x1_alu_tb is
component mux4x1
Port ( s: in std_logic_vector(1 downto 0);
        a,b: in std_logic;
        cin: in std_logic;
        cout: out std_logic;
        f: out std_logic);
end component;
signal s: in std_logic_vector:="00";
signal a,b: in std_logic:='0';
signal cin: in std_logc:='0';
signal cout : out std_logic;
signal f: out std_logic;
begin
utt: mux4x1_alu
port map(
          s=> s,
          a=> a,
          b=> b,
          cin=>cin,
          cout=>cout,
          f=>f);
stim_proc: process
begin
    s<="00"
    a<=0; b<=1;
    wait for 10 ns;
      s<="01"
    a<=0; b<=1;
    wait for 10 ns;
     s<="10"
    a<=0; b<=1;
    wait for 10 ns;
     s<="11"
    a<=0; b<=1; cin<=1;
    wait for 10 ns;
    
    

end Behavioral;
