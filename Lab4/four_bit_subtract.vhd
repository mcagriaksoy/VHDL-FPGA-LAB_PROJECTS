library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity four_bit_subtract is
     port(
         a1 : in STD_LOGIC_VECTOR(3 downto 0);
         a2 : in STD_LOGIC_VECTOR(3 downto 0);
         borrow : out STD_LOGIC;
         out1 : out STD_LOGIC_VECTOR(3 downto 0)
         );
end four_bit_subtract;

architecture subtractor_4bit_arc of four_bit_subtract is  

Component full_adder_sub is
    port (a : in STD_LOGIC;
          b : in STD_LOGIC;
          c : in STD_LOGIC;
          sum : out STD_LOGIC;
          carry : out STD_LOGIC
          );
end component;      

signal s : std_logic_vector (2 downto 0);
signal l : std_logic_vector (3 downto 0);

begin  
  
    l <= not a2;
  
    u0 : full_adder_sub port map (a1(0),l(0),'1',out1(0),s(0));
    u1 : full_adder_sub port map (a1(1),l(1),s(0),out1(1),s(1));
    u2 : full_adder_sub port map (a1(2),l(2),s(1),out1(2),s(2));
    ue : full_adder_sub port map (a1(3),l(3),s(2),out1(3),borrow);    
  

end subtractor_4bit_arc;        