----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.06.2026 21:52:04
-- Design Name: 
-- Module Name: instruction_memory - Behavioral
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

entity instruction_memory is
  generic (
  mem_size: integer:=256; --memory depth
  bank_size: integer:=128;  --size of each memory bank
  data_width: integer:= 16;  --instruction width
  addr_width: integer:= 8;  --address widht
  clock_gating: boolean:= true --enable clock gating
   );
   
   port (
   clk: in std_logic;
   reset_n: in std_logic;  --active low reset
   --instruction fetch interface
   addr_a: in std_logic_vector(addr_width-1 downto 0);  --port a
   addr_b: in std_logic_vector(addr_width-1 downto 0);  --port b
   instr_a:out std_logic_vector(data_width-1 downto 0); 
   instr_b:out std_logic_vector(data_width-1 downto 0);
   
   --pre-decode output
   opcode_a: out std_logic_vector(3 downto 0);
   rs1_addr_a: out std_logic_vector(3 downto 0);
   rs2_addr_b: out std_logic_vector(3 downto 0);
   rd_addr_a: out std_logic_vector(3 downto 0);
   
   --JTAG boundary scan interface (IEEE 1149.1)
   jtag_tck: in std_logic;
   jtag_tms: in std_logic;
   jtag_tdi: in std_logic; 
   jtag_tdo: out std_logic;
   
   --memory control
   mem_enable: in std_logic; --memory enable 
   sleep_mode: in std_logic     --clock gatting control
   );
end instruction_memory;

architecture Behavioral of instruction_memory is

    --memory array with banking 
    type bank_type is array(0 to bank_size-1) of std_logic_vector(data_width-1 downto 0);
    signal bank0,bank1: bank_type:=(others=>(others=>'0'));  
    
    --CLOCK GATTING SIGNLAS
    signal gated_clk: std_logic;
    signal clk_en: std_logic;
    
    --JTAG signal
    signal jtag_shift_reg: std_logic_vector(7 downto 0);
    signal jtag_state: std_logic_vector(3 downto 0);
    
    --pre decode signal
    signal instr_a_int: std_logic_vector(data_width-1 downto 0);
    signal predecoded_instr: std_logic_vector(data_width-1 downto 0);
    
    
    
    --instruction set constants
    constant op_add: std_logic_vector(3 downto 0):= "0000";
    constant op_addi: std_logic_vector(3 downto 0):="0001";
    constant op_sub: std_logic_vector(3 downto 0):="0010";
    constant op_and: std_logic_vector(3 downto 0):="0011";
    constant op_or: std_logic_vector(3 downto 0):="0100";
    constant op_slt: std_logic_vector(3 downto 0):="0101";
    constant op_sw: std_logic_vector(3 downto 0):="0110";
    constant op_lw: std_logic_vector(3 downto 0):="0111";
    constant op_beq: std_logic_vector(3 downto 0):="1000";
    constant op_bne: std_logic_vector(3 downto 0):="1001";
    constant op_jmp: std_logic_vector(3 downto 0):="1010";
    constant op_jal: std_logic_vector(3 downto 0):="1011";
    constant op_halt: std_logic_vector(3 downto 0):="1111";
    
    --funtion to initialize memory with test program 
    impure function init_memory return bank_type is 
        variable mem: bank_type:=(others=>(others=>'0'));
    begin
        --test program factorial calculation
        --addi R1, R),5 l R1=5(n)
        mem(0):= op_addi & "0000" & "0001" & "0101";
        
        --addi R@,R0,1 ; R2=1(result)
        mem(1):= op_addi & "0000" & "0010" & "0001";
        
        --ADDI R3, R0, 1 ; R3=1(constant)
        mem(2):= op_addi & "0000" & "0011" & "0001";
        
        --LOOP BEQ R1,R0, 6 ; if n==0 exit loop
        mem(3):=op_beq & "0001" & "0000" & "0110";
        
        --MUL R2,R2,R1; result=result*n
        mem(4):= "1100" & "0010" & "0001" & "0010";
        
        --SUB R1, R1, R3 ; n=n-1
        mem(5):= op_sub & "0001" & "0011" & "0001";
        
        --JMP 3
        mem(6):= op_jmp & "0000" & "0000" & "0011";
        
        --halt
        mem(7):= op_halt & "0000" & "0000" & "0000";
         for i in 8 to bank_size-1 loop
            mem(i):= (others=>'0');
         end loop;
         return mem;
         end function;
               
begin
        --initialize memory bank
        bank0<=init_memory;
        bank1<=(others=>(others=>'0'));  --second bank for expansion
        
        --clock gating logic(low power design)
        clk_en<=mem_enable and not sleep_mode;
        gated_clk<= clk and clk_en when clock_gating else clk;
        
        --dual port read with banking (parallel access for even and odd address)
        process(gated_clk)
            variable addr_int_a, addr_int_b : integer;
        begin
            if rising_edge(gated_clk) then
                addr_int_a:= TO_INTEGER(unsigned(addr_a));
                addr_int_b:= TO_INTEGER(unsigned(addr_b));
             --bank 0 even address lsb=0  
            if addr_a(0)='0' then
                instr_a<=bank0(addr_int_a/2);
            else 
                instr_b<=bank1(addr_int_a/2);
            end if;
            
            --bank 1 odd address (lsb=1)
            if addr_b(0)='0' then
                instr_b<=bank0(addr_int_b/2);
            else 
                instr_b<=bank1(addr_int_b/2);
            end if;
         end if;
     end process;
     instr_a<=instr_a_int;
--pre decode  logic (critical path optimization)
--extract instruciton fields in parallel with fetch
predecoded_instr <= instr_a_int;
process(predecoded_instr)
begin   
    opcode_a<=predecoded_instr(15 downto 12);
    rs1_addr_a<=predecoded_instr(11 downto 8);
    rs2_addr_b<=predecoded_instr(7 downto 4);
    rd_addr_a<=predecoded_instr(3 downto 0); 
  end process;
--predecoded_instr <= instr_a;
--instr_a<=instr_a_int;

--JTAG boundry scan controller (IEEE 1149.1 compliant)
jtag_controller: process(jtag_tck, reset_n)
begin
    if reset_n='0' then
        jtag_state<="0001";   --test logic reset state
        jtag_shift_reg<=(others=>'0');
    elsif rising_edge(jtag_tck) then
        --tag controller state machine
        case jtag_state is 
            when "0001"=> --test logic reset
                if jtag_tms='0' then
                    jtag_state<="0010"; --run test/idle
                end if;
            when "0010" => --run-test/idle 
                if jtag_tms='1' then
                    jtag_state<="0011"; --select-dr-scan
                end if;
                
            when "0011" => --select-dr-scan
                if jtag_tms='1' then
                    jtag_state<="0100";  --capture dr 
                else 
                    jtag_state<="0111";  --select ir scan
                end if;
           
           when "0100"=> --capture DR
                jtag_shift_reg<=addr_a; --capture address bus
                if jtag_tms='0' then
                    jtag_state<="0101";
                end if;
           when "0101"=>  --shift DR
                jtag_tdo<=jtag_shift_reg(0);
                jtag_shift_reg<=jtag_tdi & jtag_shift_reg(7 downto 1);
                if jtag_tms ='1' then 
                    jtag_state<="0110"; --exit1-DR
                end if;
                
           when "0110" => --exit1-DR
                if jtag_tms='1' then
                    jtag_state<="1000"; --update DR
                end if;
                
           when "1000" => --update DR
            if jtag_tms='0' then 
                jtag_state<="0010"; --Run test/idle
            end if;
            
            when others=>
                jtag_state<="0001"; --return to test-logic reset
            end case;
         end if;
       end process;

end Behavioral;
