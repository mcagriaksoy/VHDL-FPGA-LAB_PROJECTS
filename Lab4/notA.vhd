----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:36:19 10/21/2018 
-- Design Name: 
-- Module Name:    notA - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity notA is

Port(  a1 : in  STD_LOGIC_VECTOR(3 downto 0);
		 out1: out STD_LOGIC_VECTOR(3 downto 0));

end notA;

architecture Behavioral of notA is

begin

out1 <= not(a1) ;

end Behavioral;

