----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.06.2026 12:11:30
-- Design Name: 
-- Module Name: tb_program_counter - Behavioral
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

entity tb_program_counter is
end tb_program_counter;

architecture Behavioral of tb_program_counter is
    component program_counter
    Port (
  clk, reset, pc_write: in std_logic; --clock, reset(active high), PC write Enable
  pc_src: in std_logic_vector(1 downto 0); --00 PC+1 sequential, 01 branch target(PC+offset) , 10 jump target
  branch_offset: in std_logic_vector(7 downto 0);-- branch offset(signed) it tell how much to jump from current position
  jump_target: in std_logic_vector(7 downto 0); --Jump Target address
  pc_out: out std_logic_vector(7 downto 0)--current pc value
   );
end component;
signal clk: std_logic:='0';
signal reset: std_logic:='1';
signal pc_write: std_logic:='1';
signal pc_src: std_logic_vector(1 downto 0):="00";
signal branch_offset: std_logic_vector(7 downto 0):=(others=>'0');
signal jump_target: std_logic_vector(7 downto 0):=(others=>'0');
signal pc_out: std_logic_vector(7 downto 0);

constant clk_period: time := 10 ns;
begin
    uut: program_counter port map(
    clk=> clk, 
    reset=> reset,
    pc_write=> pc_write,
    pc_src=> pc_src,
    branch_offset=> branch_offset,
    jump_target=>jump_target,
    pc_out=> pc_out);
    
    clk_process: process
    begin
        clk<='0';
        wait for clk_period/2;
        clk<='1';
        wait for clk_period/2;
    end process;
    stimulus: process 
    begin 
    --test 1 reset
    reset<='1';
    wait for 10 ns;
    reset<='0';
    wait for 10 ns;
    --expected pc_out = 0x00
    
    --Test 2 sequential operation (pc_src= "00")
    pc_src<="00";
    pc_write<='1';
    for i in 0 to 10 loop  
        wait for 10 ns;
        report "pc = " & integer'image(TO_INTEGER(unsigned(pc_out)));
    end loop;
    --expected output 0 1 2 3 4 5 6 7 8 9 10
    
    --TEST 3 Freeze PC(pc_write= 0)
    report "Test 3: Freeze pc (PC_write='0')";
    pc_write<='0';
    wait for 30 ns ;
    --expected pc stays at current value (should be 10)
    report "PC frozen at: " & integer'image(TO_INTEGER(unsigned(pc_out)));
    
    --TEST4 Resume sequential (pc_write='1')
    report "Test 4 : resume sequential ";
    pc_write<='1';
    wait for 20 ns;
    -- expected pc increment to 11 then 12 
    
    --Test 5 Forward branch (pc_src= "01", positive offset)
    report "Test 5 Forward branch (+5)";
    pc_src<="01";
    branch_offset<=std_logic_vector(TO_SIGNED(5,8));
    wait for 10 ns;
    pc_src<="00";
    wait for 30 ns;
    -- expected current pc+5 then continuous sequential 
    
    -- test 6 Backward branch (pc_src= "01" negative offset)
    report "Test 6 Backward branch (-3)"; 
    pc_src<="01";
    branch_offset<=std_logic_vector(TO_SIGNED(-3,8));
    wait for 10 ns;
    pc_src<="00";
    wait for 30 ns;
    -- expected current pc-3 then continues sequential
    
    --TEST 7 jump (pc_src="10")
    report "Test 7: jump to address 0x42";
    pc_src<="10";
    jump_target<=x"42"; --0x42= 66 decimal 
    wait for 10 ns;
    pc_src<="00";
    wait for 30 ns;
    -- expected pc jumps to 0x42 then continues +1 from there 
    
    --Test 8 jump to zero
    report "Test 8: Jump to address 0x00";
    pc_src<="10";
    jump_target<=x"00";
    wait for 10 ns;
    pc_src<="00";
    wait for 20 ns;
    
    --Test 9 : Branch with wrap around
    report "Test 9: branch wrap-around test";
    --first jump near end of memory 
    pc_src<="10";
    jump_target<=x"FD";  --253 decimal
    wait for 10 ns;
    pc_src<= "00";
    wait for 20 ns;  --pc become 253 then 254
    
    -- now branch forward from 254 with offset 5 (should wrap to 3)
    pc_src<="01";
    branch_offset<=x"05";
    wait for 10 ns;
    pc_src<="00";
    wait for 20 ns;
    --expected 254+5=259 -> wrap to 3 (259-256)
    report "Wrap-around test complete";
    
    --Test 10: reset during operation
    report "Reset during Operation";
    wait for 10 ns;
    reset<='1';
    wait for 15 ns;
    reset<='0';
    wait for 10 ns;
    --expected Pc becomes 0 immediately
    
    --end simulation
    report "ALL TEST ARE COMPLETED";
    wait ;
    end process; 
    
    
    
end Behavioral;
