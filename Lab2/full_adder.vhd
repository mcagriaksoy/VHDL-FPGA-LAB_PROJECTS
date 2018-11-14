----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:06:14 01/20/2009 
-- Design Name: 
-- Module Name:    full_adder - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity full_adder is
    Port ( in1 : in  STD_LOGIC;
           in2 : in  STD_LOGIC;
           cin : in  STD_LOGIC;
           cout : out  STD_LOGIC;
           sout : out  STD_LOGIC);
end full_adder;

architecture Behavioral of full_adder is

	signal sum_low : std_logic;
	signal c_low   : std_logic;
	signal c_high  : std_logic;


component half_adder
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           s1 : out  STD_LOGIC;
           c1 : out  STD_LOGIC);
end component;

begin
ha_low : half_adder
   port map (
         a    =>    in1,
         b    =>    in2,
         s1   =>    sum_low,
         c1   =>    c_low
    );     

ha_high : half_adder
   port map (
         a    =>    cin,
         b    =>    sum_low,
         s1   =>    sout,
         c1   =>    c_high
    );         
cout <= (c_low OR c_high);

end Behavioral;

