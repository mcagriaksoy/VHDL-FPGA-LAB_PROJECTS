--Mehmet Cagri Aksoy
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity rotate_right is
      Port(
		  clk : in  STD_LOGIC;
        enable  : in  STD_LOGIC;
		  rst  : in  STD_LOGIC;
		  reg_out :out std_logic_vector (7 downto 0)
		);
end rotate_right;

architecture Behavioral of rotate_right is
signal r_reg : unsigned(7 downto 0):="00000001";
signal r_next : std_logic_vector(7 downto 0);

begin
	
	process (rst,r_reg,clk,enable)
	begin
		if(rst = '1') then
			r_reg <="00000001"  ;		  
			elsif(enable = '1') then
				if (clk'event and clk = '1') then
					r_reg <= r_reg ror 1;
				end if ;
			elsif (enable = '0') then 
				r_reg <= r_reg;
			end if;
	end process ;
	reg_out <= std_logic_vector (r_reg );
end Behavioral;

