--Mehmet Cagri Aksoy
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
	Port (
		clk : in STD_LOGIC;
		enable : in STD_LOGIC;
		rst : in STD_LOGIC;
		dir : in STD_LOGIC;
		seg_out : out STD_LOGIC_VECTOR(7 downto 0);
	   seg_sel : out STD_LOGIC_VECTOR(7 downto 0)
			  );
end top;

architecture Behavioral of top is
	component converter is
		 Port (
			  clk_in : in  STD_LOGIC;
			  enable  : in  STD_LOGIC;
			  rst  : in  STD_LOGIC;
			  clk_out: out STD_LOGIC
		 );
	end component;
	component rotate_left is
			Port(
			  clk : in  STD_LOGIC;
			  enable  : in  STD_LOGIC;
			  rst  : in  STD_LOGIC;
			
			  reg_out :out std_logic_vector (7 downto 0)
			);
	end component;
	component rotate_right is
			Port(
			  clk : in  STD_LOGIC;
			  enable  : in  STD_LOGIC;
			  rst  : in  STD_LOGIC;
			
			  reg_out :out std_logic_vector (7 downto 0)
			);
	end component;
	component seven_four is
		 Port ( in1 : in  STD_LOGIC_VECTOR (7 downto 0);
				  clk : in  STD_LOGIC;
				  dp  : out  STD_LOGIC;
				  sel : out  STD_LOGIC_VECTOR (3 downto 0);
				  segment : out  STD_LOGIC_VECTOR (6 downto 0)
				);
	end component;
	
signal clk1,dp : std_logic;
signal w0,w1,w2,w3 : std_logic_vector (7 downto 0);
signal result : std_logic_vector (7 downto 0):=x"00";
signal seg_out_7 :STD_LOGIC_VECTOR(6 downto 0);
signal seg_sel_4 : STD_LOGIC_VECTOR(3 downto 0);

begin
	C1:converter port map(clk,enable,rst,clk1);
	C2:rotate_left port map (clk1,enable,rst,w0);
	C3:rotate_right port map (clk1,enable,rst,w1);
	C4:seven_four port map (result,clk,dp,seg_sel_4,seg_out_7);
	seg_out <= seg_out_7 & dp;
	seg_sel <= "1111"& seg_sel_4;

		with  dir select  
			result<= w0 when '0',
						w1 when others;
		

end Behavioral;