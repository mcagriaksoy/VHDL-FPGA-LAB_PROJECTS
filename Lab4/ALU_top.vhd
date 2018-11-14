library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU_top is  

Port( clk: in  STD_LOGIC;
		in1: in  STD_LOGIC_VECTOR(3 downto 0); 
		in2: in  STD_LOGIC_VECTOR(3 downto 0);
		op_sel: in  STD_LOGIC_VECTOR(2 downto 0);
		flag_out: out STD_LOGIC_VECTOR(2 downto 0);
		seg_out: out STD_LOGIC_VECTOR(7 downto 0);
		seg_sel: out STD_LOGIC_VECTOR(7 downto 0));
	 	
end ALU_top;

architecture  ALU_top of ALU_top is 
 
component four_bit_adder

Port(  in1: in  STD_LOGIC_VECTOR(3 downto 0);
		 in2: in  STD_LOGIC_VECTOR(3 downto 0);
		 sout: out STD_LOGIC_VECTOR(3 downto 0);
		 cout: out STD_LOGIC);
end component; 

component four_bit_subtract 
Port(  a1 : in  STD_LOGIC_VECTOR(3 downto 0);
		 a2 : in  STD_LOGIC_VECTOR(3 downto 0); 
		 out1:out STD_LOGIC_VECTOR(3 downto 0));
end component; 

component decrement 
Port(  a1 : in  STD_LOGIC_VECTOR(3 downto 0);
		 out1: out STD_LOGIC_VECTOR(3 downto 0));
end component; 

component increment 
Port( a1 : in  STD_LOGIC_VECTOR(3 downto 0);
		carry: out STD_LOGIC;
		out1 : out STD_LOGIC_VECTOR(3 downto 0));
end component; 

component four_bit_and
Port(  a1 : in  STD_LOGIC_VECTOR(3 downto 0);
		 a2 : in  STD_LOGIC_VECTOR(3 downto 0); 
		 out1:out STD_LOGIC_VECTOR(3 downto 0));
end component; 

component four_bit_or 
Port(  a1 : in  STD_LOGIC_VECTOR(3 downto 0);
		 a2 : in  STD_LOGIC_VECTOR(3 downto 0); 
       out1:out STD_LOGIC_VECTOR(3 downto 0));
end component;

component NotA
Port(  a1 : in  STD_LOGIC_VECTOR(3 downto 0);
		 out1: out STD_LOGIC_VECTOR(3 downto 0));
end component; 

component four_bit_xor 
Port (  a1 : in  STD_LOGIC_VECTOR(3 downto 0);
		  a2 : in  STD_LOGIC_VECTOR(3 downto 0);
		  out1 : out STD_LOGIC_VECTOR(3 downto 0));
end component; 

component seven_four
Port ( in1 : in STD_LOGIC_VECTOR (3 downto 0);
		 in2 : in STD_LOGIC_VECTOR (3 downto 0);
		 in3 : in STD_LOGIC_VECTOR (3 downto 0);
		 in4 : in STD_LOGIC_VECTOR (3 downto 0);
		 clk : in STD_LOGIC;
		 dp : out STD_LOGIC;
		 sel : out STD_LOGIC_VECTOR (3 downto 0);
		 segment : out STD_LOGIC_VECTOR (6 downto 0));
end component;

signal add_out, sub_out, and_out, or_out : STD_LOGIC_VECTOR(3 downto 0);
signal xor_out, inc_out, dec_out, not_out, final_out, carry_show: STD_LOGIC_VECTOR(3 downto 0);
signal add_carry,inc_carry: STD_LOGIC;
signal Z, V, C : STD_LOGIC; -- Flag bits
signal dp,temp1 : STD_LOGIC;
signal seg_out_7 : STD_LOGIC_VECTOR(6 downto 0);
signal seg_sel_4: STD_LOGIC_VECTOR (3 downto 0);
signal temp2: STD_LOGIC_VECTOR (4 downto 0);
begin

	carry_show<= ("000" & C); --To showcarrybit on seven segment (concatenate)
	A0 : four_bit_adder port map(in1,in2,add_out,add_carry); -- You should complete the component port maps
	A1 : four_bit_subtract port map(in1,in2,sub_out); -- You should also design these modules
	A2 : four_bit_and port map(in1,in2,and_out);
	A3 : four_bit_or port map(in1,in2,or_out);
	A4 : four_bit_xor port map(in1,in2,xor_out);
	A5 : increment port map(in1,inc_carry,inc_out);
	A6 : decrement port map(in1,dec_out);
	A7 : NotA port map(in1,not_out);
	A8 : seven_four port map (final_out, carry_show, "0000", "0000", clk, dp, seg_sel_4, seg_out_7);

	-- Seven segment related part
	
	seg_out <= (seg_out_7 & dp);
	seg_sel <= "1111" & seg_sel_4;
	
	-- Finding the flag_out output

	temp1 <= '1' when in2>in1 else
				'0';
	V <= temp1 when op_sel = "001" else
		  temp1 when op_sel = "110" else
		  '0';
	C <= add_carry when op_sel = "000" else
		  inc_carry when op_sel = "101" else
		  '0';

	temp2 <= (final_out & C);
		 Z <= '1' when temp2 = "00000" else
				'0';
	flag_out <= Z & C & V; -- concatenation flags.

	with op_sel select
			final_out <= add_out when "000",
							 sub_out when "001",
							 dec_out when "010",
						    inc_out when "011",
							 and_out when "100",
							 or_out  when "101",
						    not_out when "110",
							 xor_out when others;							  

end ALU_top;