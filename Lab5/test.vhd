
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity test is
end test;

architecture Behavioral of test is

component top
    Port ( clk : in  STD_LOGIC;
			  reset : in  STD_LOGIC;
           up_down : in  STD_LOGIC;
           enable : in  STD_LOGIC; 
			  seg_out : out STD_LOGIC_VECTOR(7 downto 0);
			  seg_sel : out STD_LOGIC_VECTOR(7 downto 0)
			  );
end component;

	signal clk : std_logic := '0';
	signal  reset: std_logic:= '0';
   signal  up_down: std_logic:= '1';
   signal  enable : std_logic:= '1';
 	--Outputs
   signal seg_out : std_logic_vector(7 downto 0);
	signal seg_sel : std_logic_vector(7 downto 0);
	constant clk_period : time := 500 ms;
begin
	uut: top PORT MAP (
          clk => clk,
          reset => reset,
          up_down => up_down,
			 enable => enable,
          seg_out => seg_out,
          seg_sel => seg_sel
        );

   -- Clock process definitions
   clk_process : process
   begin
		clk <= '0';
		wait for clk_period;
		clk <= '1';
		wait for clk_period;
		clk <= '0';
		wait for clk_period;
		clk <= '1';
		wait for clk_period;
		clk <= '0';
		wait for clk_period;
		clk <= '1';
		wait for clk_period;
		clk <= '0';
		wait for clk_period;
		clk <= '1';
		wait for clk_period;
		clk <= '0';
		wait for clk_period;
		clk <= '1';
		wait for clk_period;
		clk <= '0';
		wait for clk_period;
		clk <= '1';
		wait for clk_period;
		
   end process;
 

   

end Behavioral;

