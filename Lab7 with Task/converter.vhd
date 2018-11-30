
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity converter is
    Port (
        clk_in : in  STD_LOGIC;
        enable  : in  STD_LOGIC;
		  rst  : in  STD_LOGIC;
        clk_out: out STD_LOGIC
    );
end converter;

architecture Behavioral of converter is
    signal temporal: STD_LOGIC :='1';
    signal counter : integer range 0 to 50000000 := 0;
begin
    frequency_divider: process (enable,rst,clk_in,temporal,counter) begin
		  if(rst='1') then
		  temporal <= '1';				
        counter <= 0;
        elsif (enable = '0') then
            temporal <= temporal;				
            counter <= counter;
        elsif rising_edge(clk_in) then
            if (counter = 49999999) then
                temporal <= NOT(temporal);
					 
                counter <= 0;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;
	 clk_out <= temporal;
    
    
end Behavioral;


