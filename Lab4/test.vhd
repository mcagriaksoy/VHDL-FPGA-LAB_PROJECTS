
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test IS
END test;
 
ARCHITECTURE behavior OF test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU_top
    PORT(
         clk : IN  std_logic;
         in1 : IN  std_logic_vector(3 downto 0);
         in2 : IN  std_logic_vector(3 downto 0);
         op_sel : IN  std_logic_vector(2 downto 0);
         flag_out : OUT  std_logic_vector(2 downto 0);
		
         seg_out : OUT  std_logic_vector(7 downto 0);
         seg_sel : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal in1 : std_logic_vector(3 downto 0) := (others => '0');
   signal in2 : std_logic_vector(3 downto 0) := (others => '0');
   signal op_sel : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal flag_out : std_logic_vector(2 downto 0);
   signal seg_out : std_logic_vector(7 downto 0);
   signal seg_sel : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU_top PORT MAP (
          clk => clk,
          in1 => in1,
          in2 => in2,
          op_sel => op_sel,
          flag_out => flag_out,
          seg_out => seg_out,
		
          seg_sel => seg_sel
        );


   -- Stimulus process
   stim_proc: process
   begin		
		in1 <= "0110";
		in2 <= "0001";
		op_sel <= "001";
		wait for 1000 ns;

		
		
      -- insert stimulus here 

      wait;
   end process;

END;
