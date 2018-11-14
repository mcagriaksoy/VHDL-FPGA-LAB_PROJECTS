
-- Engineer: Mehmet Cagri Aksoy

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

	entity universal_counter is
		Port ( clk : in STD_LOGIC;
			    rst : in STD_LOGIC;
				 up_down : in STD_LOGIC;
				 enable : in STD_LOGIC;
				 upperlimit : in STD_LOGIC_VECTOR(3 downto 0);
				 enable_out : out STD_LOGIC;
				 result : out STD_LOGIC_VECTOR(3 downto 0));
		end universal_counter;
		
architecture Behavioral of universal_counter is
	signal count : unsigned (3 downto 0) := "0000";
	signal lmt : unsigned(3 downto 0);
	begin
	lmt<=unsigned(upperlimit);
		process (clk,rst, enable, up_down,upperlimit,count,lmt)
		
			begin
				if (rst = '1' and up_down='1') then
					count <= "0000";
					
				elsif(rst='1' and up_down='0')then
					count<=lmt; end if;
			
			if (clk = '1' and clk'event) then

					
				if (enable = '1') then
					if (up_down = '1') then
						if(count=lmt) then count<="0000";						
						else count <= count + 1; end if;
					elsif(up_down='0') then
						if(count="0000")then count<=lmt;						
						else count <= count - 1; end if;
					end if ;
				else 
					 count<=count;
					
				end if ;
			end if;
		if(count=lmt)  then
			if(up_down='1' and enable='1')then
			enable_out<='1';
			else
			enable_out<='0';
			end if;
		else
			if(up_down='1')then
			enable_out<='0';
			elsif(count="0000" and up_down='0' and enable='1') then
			enable_out<='1';
			else
			enable_out<='0';
			end if;
		end if;	

		
		end process;
	
		result <= std_logic_vector(count);
end Behavioral;

