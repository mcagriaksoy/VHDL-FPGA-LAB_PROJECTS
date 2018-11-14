
-- Engineer: Mehmet Cagri Aksoy

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk_converter is
    Port (
        clk_in : in  STD_LOGIC;
        enable  : in  STD_LOGIC;
		  rst  : in  STD_LOGIC;
        clk_out: out STD_LOGIC
    );
end clk_converter;

architecture Behavioral of clk_converter is
    signal temporal: STD_LOGIC :='1';
    signal counter : integer range 0 to 100000000 := 0;
    begin
        process (enable,rst,clk_in,temporal,counter) 
			  begin
			  if(rst='1') then
			  temporal <= '1';				
			  counter <= 0;
			  elsif (enable = '0') then
					temporal <= temporal;				
					counter <= counter;
			  elsif rising_edge(clk_in) then
					if (counter = 100000000) then
						 temporal <= NOT(temporal);
						 
						 counter <= 0;
					else
						 counter <= counter + 1;
					end if;
			  end if;
    end process;
	 clk_out <= temporal;
    
    
end Behavioral;


