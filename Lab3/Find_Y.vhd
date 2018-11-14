-- Mehmet Çaðrý Aksoy ---

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Find_Y is
	Port(
			w1: in std_logic_vector(3 downto 0);
			Y: out std_logic);
end Find_Y;

architecture conditional_c of Find_Y is
	
				
begin
		Y  <= '1' when (w1="0001") else
				'1' when (w1="0100") else
				'1' when (w1="0101") else
				'1' when (w1="1001") else
				'1' when (w1="1011") else
				'1' when (w1="1111") else
				'0';

end conditional_c;

