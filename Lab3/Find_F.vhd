--Mehmet Çaðrý Aksoy--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Find_F is
		Port(
		A,B,C,D,S0,S1: in std_logic;
		F: out std_logic);
end Find_F;

architecture top of Find_F is
--components:
component Find_X
		Port(
		A,B,C,D: in std_logic;
		X: out std_logic);
end component;

component Find_Y
		Port(
			w1: in std_logic_vector(3 downto 0);
			Y: out std_logic);
end component;			

component Find_Z
		Port (
					w1: in std_logic_vector(3 downto 0);
					Z: out std_logic);
end component;

--Signals

signal w1: std_logic_vector(3 downto 0);
signal s: std_logic_vector(1 downto 0);
signal X,Y,Z,W: std_logic;

begin
		w1 <= (A & B & C & D);
		s <= (S1 & S0);
		
A1: Find_X port map (A,B,C,D,X);
A2: Find_Y port map (w1,Y);
A3: Find_Z port map (w1,Z);

		with s select
		-- 4to1 Mux is defined here:
		F <= X when "00",
			  Y when "01",
			  Z when "10",
			 '0' when others;
end top;

