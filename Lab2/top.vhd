----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:21:22 02/14/2009 
-- Design Name: 
-- Module Name:    top - Behavioral 
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

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    Port ( clk : in  STD_LOGIC;
           inp1 : in  STD_LOGIC_VECTOR (3 downto 0);
           inp2 : in  STD_LOGIC_VECTOR (3 downto 0);
           seg_out : out  STD_LOGIC_VECTOR (7 downto 0);
           seg_sel : out  STD_LOGIC_VECTOR (7 downto 0));
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

component four_bit_adder
Port ( in1 : in  STD_LOGIC_VECTOR (3 downto 0);
           in2 : in  STD_LOGIC_VECTOR (3 downto 0);
           sout : out  STD_LOGIC_VECTOR (3 downto 0);
           cout : out  STD_LOGIC
			);
end component;

signal w1, w2 : STD_LOGIC_VECTOR (3 downto 0);
signal w3, w4 : STD_LOGIC;
signal w5 : STD_LOGIC_VECTOR (6 downto 0);
signal seg_sel_4 : STD_LOGIC_VECTOR (3 downto 0);

begin

A1 : four_bit_adder port map (inp1, inp2, w1, w3);
w2 <= ("000" & w3);
A2 : seven_four port map (w1, w2, "0000", "0000", clk, w4, seg_sel_4, w5);
seg_out <= (w5 & w4);
seg_sel <= "1111" & seg_sel_4;
end Behavioral;

