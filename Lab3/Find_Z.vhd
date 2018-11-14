--- Mehmet Çaðrý Aksoy ---
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Find_Z is
		Port (
					w1: in std_logic_vector(3 downto 0);
					Z: out std_logic);
end Find_Z;

architecture selected_c of Find_Z is
		
begin
		with w1 select
			Z <= '1' when "0000",
				  '0' when "0001",
				  '1' when "0010",
				  '1' when "0011",
				  '0' when "0100",
				  '0' when "0101",
				  '0' when "0110",
				  '1' when "0111",
				  '0' when "1000",
				  '0' when "1001",
				  '0' when "1010",
				  '0' when "1011",
				  '1' when "1100",
				  '0' when "1101",
				  '1' when "1110",
				  '0' when others;

end selected_c;

