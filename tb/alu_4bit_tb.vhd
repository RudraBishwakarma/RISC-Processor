library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alu_4bit_tb is
end alu_4bit_tb;

architecture Behavioral of alu_4bit_tb is

-- Component Declaration
component alu_4bit
    generic(n : integer := 4);
    Port (
        s    : in std_logic_vector(2 downto 0);
        a    : in std_logic_vector(n-1 downto 0);
        b    : in std_logic_vector(n-1 downto 0);
        cin  : in std_logic;
        f    : out std_logic_vector(n-1 downto 0);
        cout : out std_logic
    );
end component;

-- Signals
signal s    : std_logic_vector(2 downto 0);
signal a    : std_logic_vector(3 downto 0);
signal b    : std_logic_vector(3 downto 0);
signal cin  : std_logic;
signal f    : std_logic_vector(3 downto 0);
signal cout : std_logic;

begin

-- DUT (Device Under Test)
uut: alu_4bit
    generic map(n => 4)
    port map(
        s => s,
        a => a,
        b => b,
        cin => cin,
        f => f,
        cout => cout
    );

-- Stimulus Process
stim_proc: process
begin

    -- Test values
    a <= "1011";  -- 11
    b <= "0101";  -- 5
    cin <= '0';

    -- AND
    s <= "000";
    wait for 10 ns;

    -- OR
    s <= "001";
    wait for 10 ns;

    -- XOR
    s <= "010";
    wait for 10 ns;

    -- ADD
    s <= "011";
    cin <= '1';
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

    -- Reserved
    s <= "111";
    wait for 10 ns;

    wait;
end process;

end Behavioral;