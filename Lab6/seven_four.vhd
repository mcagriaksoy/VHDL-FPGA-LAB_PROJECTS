--Mehmet Cagri Aksoy
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity seven_four is
    Port ( in1 : in  STD_LOGIC_VECTOR (7 downto 0);
           clk : in  STD_LOGIC;
			  dp  : out  STD_LOGIC;
           sel : out  STD_LOGIC_VECTOR (3 downto 0);
           segment : out  STD_LOGIC_VECTOR (6 downto 0)
			);
end seven_four;


architecture Behavioral of seven_four is

signal counter : STD_LOGIC_VECTOR (17 downto 0);
signal sev_in1, sev_in2, sev_in3, sev_in4 : STD_LOGIC_VECTOR (6 downto 0);

begin
	
	dp <= '1';
	process (clk,in1, sev_in1, sev_in2, sev_in3, sev_in4)	
	variable sec : STD_LOGIC_VECTOR (2 downto 0) := "000" ;
	begin
		case (in1) is
			when "00000001" =>
				sel <= "1110";
				segment <= "0011100";
						
			when "00000010" =>
				sel <= "1101";
				segment <= "0011100";
			
			when "00000100" =>
				sel <= "1011";
				segment <= "0011100";
			
			when "00001000" => 
				sel <= "0111";
				segment <="0011100";
				
			when "00010000" => 
				sel <= "0111";
				segment <= "0100011";
				
			when "00100000" => 
				sel <= "1011";
				segment <= "0100011";
				
			when "01000000" => 
				sel <= "1101";
				segment <= "0100011";
				
			when "10000000" => 
				sel <= "1110";
				segment <= "0100011";
			when others => 
				sel <= "1111";
				segment <= "1111111";
			
		end case;
		
end process;

end Behavioral;


