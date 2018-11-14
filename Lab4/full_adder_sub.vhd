library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity full_adder_sub is
    port (a : in STD_LOGIC;
          b : in STD_LOGIC;
          c : in STD_LOGIC;
          sum : out STD_LOGIC;
          carry : out STD_LOGIC
          );
end full_adder_sub;

architecture fa_arc of full_adder_sub is

begin
  
    sum <= a xor b xor c;
    carry <= (a and b) or (b and c) or (c and a);
  
end fa_arc;