
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity four_bit_and is


Port(  a1 : in  STD_LOGIC_VECTOR(3 downto 0);
		 a2 : in  STD_LOGIC_VECTOR(3 downto 0); 
		 out1:out STD_LOGIC_VECTOR(3 downto 0));

end four_bit_and;

architecture Behavioral of four_bit_and is

signal temp : STD_LOGIC_VECTOR (4 downto 0); 


begin

temp <= ('0'&a1) and ('0'&a2) ;
out1 <= temp(3 downto 0);


end Behavioral;

