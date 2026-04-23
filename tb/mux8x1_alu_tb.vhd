----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.04.2026 21:35:29
-- Design Name: 
-- Module Name: mux8x1_alu_tb - Behavioral
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

entity mux8x1alu_tb is
end mux8x1alu_tb;

architecture Behavioral of mux8x1alu_tb is

component mux8x1_alu
Port ( 
    s    : in std_logic_vector(2 downto 0);
    a,b  : in std_logic;
    cin  : in std_logic;
    cout : out std_logic;
    f    : out std_logic
);
end component;

-- Signals
signal s    : std_logic_vector(2 downto 0) := "000";
signal a    : std_logic := '0';
signal b    : std_logic := '0';
signal cin  : std_logic := '0';
signal cout : std_logic;
signal f    : std_logic;

begin

-- DUT
uut: mux8x1_alu
port map(
    s => s,
    a => a,
    b => b,
    cin => cin,
    cout => cout,
    f => f
);

-- Stimulus Process
stim_proc: process
begin

    -- AND
    s <= "000"; a <= '1'; b <= '0'; cin <= '0';
    wait for 10 ns;

    -- OR
    s <= "001"; 
    wait for 10 ns;

    -- XOR
    s <= "010"; 
    wait for 10 ns;

    -- ADD
    s <= "011"; cin <= '1';
    wait for 10 ns;

    -- NOT A
    s <= "100"; 
    wait for 10 ns;

    -- PASS A
    s <= "101"; 
    wait for 10 ns;

    -- A + 1
    s <= "110"; 
    wait for 10 ns;

    -- RESERVED
    s <= "111"; 
    wait for 10 ns;

    wait;
end process;

end Behavioral;