library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity half_adder is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           s1 : out  STD_LOGIC;
           c1 : out  STD_LOGIC);
end half_adder;

architecture Behavioral of half_adder is

begin
	s1 <= (a XOR b);
    c1 <= (a AND b);   -- the logical operator "AND" and "XOR" is defined in VHDL.


end Behavioral;
