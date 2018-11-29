--Mehmet Cagri Aksoy

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity top is
    Port ( clk100Mhz : in  STD_LOGIC;
			  reset : in  STD_LOGIC;
           DATA : in  STD_LOGIC;
           enable : in  STD_LOGIC;
			 
			  ledo:out std_logic_vector(7 downto 0);
			  seg_out : out STD_LOGIC_VECTOR(7 downto 0);
			  seg_sel : out STD_LOGIC_VECTOR(7 downto 0)
			  );
end top;

architecture Behavioral of top is
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

component converter 
    Port (
        clk_in : in  STD_LOGIC;
        enable  : in  STD_LOGIC;
		  rst   : in  STD_LOGIC;
        clk_out: out STD_LOGIC
    );
end component;

type  state_type is (s0,s1,s2,s3,s4);
signal present_state,next_state: state_type;

signal leds:std_logic_vector(7 downto 0):="00000000";
signal sout:std_logic;

signal clk1,dp: STD_LOGIC;
signal tmp,tmp2:std_logic_vector(7 downto 0):="00000000";
signal seg_out_7 :STD_LOGIC_VECTOR(6 downto 0);
signal seg_sel_4 : STD_LOGIC_VECTOR(3 downto 0);

signal swhat,swhat2 : STD_LOGIC_VECTOR(3 downto 0);

begin
A1:converter port map(clk100Mhz,enable,reset,clk1);


process(clk1,reset) 
	begin
		if reset = '1' then 
			present_state<=s0;
			
			ledo<="00000000";
			leds<="00000000";
			
		elsif clk1'event and clk1='1' then
		
			if enable='1' then
				present_state<=next_state;
				leds<=leds(6 downto 0) & DATA;
				ledo<=leds;
			else
				present_state<=present_state;
				leds<=leds;
				ledo<=leds;
			end if;
			
		end if;
end process;

process(present_state,DATA)
	begin
		case present_state is
			when s0=>
			
				swhat<="0000";
				if DATA='1' then
					next_state<=s1;
				else
					next_state<=s0;
				end if;
			when s1=>
				swhat<="0001";
				if DATA='1' then
					next_state<=s2;
				else
					next_state<=s0;
				end if;
			when s2=>
				swhat<="0010";
				if DATA='0' then
					next_state<=s3;
				else
					next_state<=s2;
				end if;
			when s3=>
				swhat<="0011";
				if DATA='1' then
					next_state<=s4;
				else
					next_state<=s0;
				end if;
			when s4=>
				swhat<="0100";
				if DATA='0' then
					next_state<=s0;
				else
					next_state<=s2;
				end if;
			when others =>
				null;
		end case;
end process;

process(present_state,tmp,tmp2) --dikkat tmp,tmp2 verdi!
	begin
		if present_state=s4 then
			
			tmp2 <= tmp + '1';
			
		else
			
			tmp<=tmp2;
		end if;
end process;

swhat2 <= swhat;
A6 :seven_four port map (tmp2(3 downto 0), tmp2(7 downto 4), swhat, "0000", clk100Mhz, dp,seg_sel_4,seg_out_7);

seg_out <= (seg_out_7 & dp);
seg_sel <= "1111" & seg_sel_4;

end Behavioral;

