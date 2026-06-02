----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.06.2026 11:40:41
-- Design Name: 
-- Module Name: program_counter - Behavioral
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


--Analogy	Processor                   Equivalent
--Recipe book	                        Instruction Memory
--Current recipe number	            Program Counter (PC)
--"Turn to page 5"	                Jump instruction
--"Skip to step 10"	                Branch instruction
--"Next page please"	                PC + 1 (sequential)
--Bookmark	                        PC register (saves position)
entity program_counter is
  Port (
  clk, reset, pc_write: in std_logic; --clock, reset(active high), PC write Enable
  pc_src: in std_logic_vector(1 downto 0); --00 PC+1 sequential, 01 branch target(PC+offset) , 10 jump target
  branch_offset: in std_logic_vector(7 downto 0);-- branch offset(signed) it tell how much to jump from current position
  jump_target: in std_logic_vector(7 downto 0); --Jump Target address
  pc_out: out std_logic_vector(7 downto 0)--current pc value
   );
end program_counter;

architecture Behavioral of program_counter is
    signal pc_reg: unsigned(7 downto 0):= (others=>'0');
    signal next_pc: unsigned(7 downto 0);
  
begin
--NEXT PC LOGIC (COMBINATIONAL)
process(pc_reg,pc_src,branch_offset,jump_target)
begin 
    case pc_src is 
        when "00" =>
            next_pc<= pc_reg+1;
        when "01" =>
            next_pc<= pc_reg+ unsigned(branch_offset);
        when "10" =>
            next_pc<= unsigned(jump_target);
        when others =>
            next_pc <= pc_reg+1;
        end case;
    end process; 
-- NEXT PC LOGIC (SEQUENTIALLY)
process(clk, reset)
begin
    if reset='1' then
        pc_reg<=(others=>'0');
    elsif rising_edge(clk) then
        if pc_write='1' then
            pc_reg<=next_pc;
        end if; 
    end if;   
  end process; 
  pc_out<= std_logic_vector(pc_reg);
end Behavioral;
