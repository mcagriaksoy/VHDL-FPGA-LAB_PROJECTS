
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity increment is

Port( a1 : in  STD_LOGIC_VECTOR(3 downto 0);
		carry: out STD_LOGIC;
		out1 : out STD_LOGIC_VECTOR(3 downto 0));
end increment;

architecture Behavioral of increment is

signal temp : STD_LOGIC_VECTOR (4 downto 0); 


begin

	temp <= (('0'&a1) + "00001") ;
	out1 <= temp(3 downto 0);
	carry <= temp(4);


end Behavioral;

