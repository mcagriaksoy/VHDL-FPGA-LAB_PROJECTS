library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity top is
    Port ( item_select : in STD_LOGIC_VECTOR (1 downto 0);
           request     : in STD_LOGIC;
           one_tl       : in STD_LOGIC;
           take_item   : in STD_LOGIC;
           reset       : in STD_LOGIC;
           clk         : in STD_LOGIC;
           ready_led   : out STD_LOGIC;
           seg_out     : out  STD_LOGIC_VECTOR (7 downto 0);
           seg_sel     : out  STD_LOGIC_VECTOR (7 downto 0)
       );
end top;

architecture Behavioral of top is

    component seven_four
        Port ( in1     : in  STD_LOGIC_VECTOR (3 downto 0);
               in2     : in  STD_LOGIC_VECTOR (3 downto 0);
               in3     : in  STD_LOGIC_VECTOR (3 downto 0);
               in4     : in  STD_LOGIC_VECTOR (3 downto 0);
               clk     : in  STD_LOGIC;
               dp      : out  STD_LOGIC;
               sel     : out  STD_LOGIC_VECTOR (3 downto 0);
               segment : out  STD_LOGIC_VECTOR (6 downto 0)
                );
    end component;
    
    component FSM
        Port ( item_select : in STD_LOGIC_VECTOR (1 downto 0);
               request : in STD_LOGIC;
               one_tl : in STD_LOGIC;
               take_item : in STD_LOGIC;
               reset : in STD_LOGIC;
               clk : in STD_LOGIC;
               ready_led : out STD_LOGIC;
               current_state : out STD_LOGIC_VECTOR(3 downto 0);
               girilen_para_out : out STD_LOGIC_VECTOR(3 downto 0)
					);
    end component;

    signal current_state_out :  STD_LOGIC_VECTOR(3 downto 0);
    signal w4 : STD_LOGIC;
    signal w5 : STD_LOGIC_VECTOR (6 downto 0);
    signal seg_sel_4 : STD_LOGIC_VECTOR (3 downto 0); 
    signal show_TL : STD_LOGIC_VECTOR (3 downto 0);
    

begin

    c0 : FSM port map(item_select, request,  one_tl, take_item, reset, clk, ready_led, current_state_out, show_TL); 
    c1 : seven_four port map (show_TL, "0000", current_state_out, "0101", clk , w4, seg_sel_4, w5);
    
    seg_out <= (w5 & w4);
    seg_sel <= "1111" & seg_sel_4;

end Behavioral;
