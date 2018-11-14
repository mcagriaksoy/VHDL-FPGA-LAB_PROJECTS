
-- Engineer: Mehmet Cagri Aksoy

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity top is
    Port ( clk : in  STD_LOGIC;
			  reset : in  STD_LOGIC;
           up_down : in  STD_LOGIC;
           enable : in  STD_LOGIC; 
			  seg_out : out STD_LOGIC_VECTOR(7 downto 0);
			  seg_sel : out STD_LOGIC_VECTOR(7 downto 0)
			  );
end top;

architecture Behavioral of top is

component clk_converter
    Port (
        clk_in : in  STD_LOGIC;
        enable  : in  STD_LOGIC;
		  rst   : in  STD_LOGIC;
        clk_out: out STD_LOGIC
    );
end component;

component universal_counter 
		Port ( clk : in STD_LOGIC;
			    rst : in STD_LOGIC;
				 up_down : in STD_LOGIC;
				 enable : in STD_LOGIC;
				 upperlimit : in STD_LOGIC_VECTOR(3 downto 0);
				 enable_out : out STD_LOGIC;
				 result : out STD_LOGIC_VECTOR(3 downto 0));
		end component;

component seven_four 
    Port ( in1 : in  STD_LOGIC_VECTOR (3 downto 0);
           in2 : in  STD_LOGIC_VECTOR (3 downto 0);
           in3 : in  STD_LOGIC_VECTOR (3 downto 0);
           in4 : in  STD_LOGIC_VECTOR (3 downto 0);
           clk : in  STD_LOGIC;
			  dp  : out  STD_LOGIC;
           sel : out  STD_LOGIC_VECTOR (3 downto 0);
           segment : out  STD_LOGIC_VECTOR (6 downto 0)
			);
			
end component;


	signal clk1,w0,w1,w2,w3,dp: STD_LOGIC; --enable outs
	signal b0,b1,b2,b3 : STD_LOGIC_VECTOR(3 downto 0); --results
	signal seg_out_7 :STD_LOGIC_VECTOR(6 downto 0); 
	signal seg_sel_4 : STD_LOGIC_VECTOR(3 downto 0);

begin
	C0:clk_converter port map(clk,enable,reset,clk1);
	sec1:universal_counter port map(clk1,reset,up_down,enable,"1001",w0,b0);
	sec10:universal_counter port map(clk1,reset,up_down,w0,"0101",w1,b1);
	min1:universal_counter port map(clk1,reset,up_down,w1,"1001",w2,b2);
	min10:universal_counter port map(clk1,reset,up_down,w2,"0101",w3,b3);
	C5 :seven_four port map (b0, b1, b2, b3, clk, dp,seg_sel_4,seg_out_7);
--seven segment te hangi clock kullanýlacak bir bak !!
	seg_out <= (seg_out_7 &dp);

	seg_sel <= "1111" &seg_sel_4;

end Behavioral;

