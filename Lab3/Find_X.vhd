-- Mehmet ÇAÐRI Aksoy --

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Find_X is
		Port(
		A,B,C,D: in std_logic;
		X: out std_logic);
end Find_X;

architecture Sop_arc of Find_X is
	signal and_1,and_2: std_logic;

begin

	and_1 <= (A and B and (not C));
	and_2 <= (B and D and (not C));
	X 		<= (and_1 or and_2);

end Sop_arc;



