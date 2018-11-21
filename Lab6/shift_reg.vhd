library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity shift_reg is
    Port ( clk1 : in  STD_LOGIC;
			  inp1 : in STD_LOGIC_VECTOR(7 downto 0);
				rot : in STD_LOGIC;
           out1 : out STD_LOGIC_VECTOR(7 downto 0)
			  );
end shift_reg;
    
architecture Behavioral of shift_reg is

    signal shift_reg : STD_LOGIC_VECTOR(7 downto 0);
begin
	shift_reg <= inp1;
    -- shift register
    process (clk1,rot,inp1,shift_reg)
		 begin
			if(rot = '1') then
			  if (clk1'event and clk1 = '1') then  
					shift_reg(7) <= '0';
					shift_reg(6) <= shift_reg(7);
					shift_reg(5) <= shift_reg(6);
					shift_reg(4) <= shift_reg(5);
					shift_reg(3) <= shift_reg(4);
					shift_reg(2) <= shift_reg(3);
					shift_reg(1) <= shift_reg(2);
					shift_reg(0) <= shift_reg(1);
				  else
					shift_reg <= shift_reg;
				  end if;
			  elsif (rot = '0') then
					if (clk1'event and clk1 = '1') then
						shift_reg(7) <= shift_reg(6);
						shift_reg(6) <= shift_reg(5);
						shift_reg(5) <= shift_reg(4);
						shift_reg(4) <= shift_reg(3);
						shift_reg(3) <= shift_reg(2);
						shift_reg(2) <= shift_reg(1);
						shift_reg(1) <= shift_reg(0);
						shift_reg(0) <= '0';
					else
						shift_reg <= shift_reg;
					end if;	
					
			  end if;
		 
    end process;
    
    -- hook up the shift register bits to the LEDs
    out1 <= shift_reg;

end Behavioral;