library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity decrement is

Port(  a1 : in  STD_LOGIC_VECTOR(3 downto 0);
		 out1: out STD_LOGIC_VECTOR(3 downto 0));


end decrement;

architecture Behavioral of decrement is


begin

	out1 <= (a1-"0001");
	

end Behavioral;

