--Mehmet Cagri Aksoy

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
    generic(
       W: integer:=8;
       CBIT: integer:=4   -- CBIT=log2(W)+1
    );
    port(
        clk, reset: in std_logic;
        start: in std_logic;
        dvsr: in std_logic_vector(W-1 downto 0);
		  dvnd: in std_logic_vector(W-1 downto 0);
        ready, done_tick: out std_logic;
		  curr_state_led : out std_logic_vector(3 downto 0);
        quo, rmd: out std_logic_vector(W downto 0)
    );
end top;

architecture arch of top is

component seven_four
Port ( in1 : in STD_LOGIC_VECTOR (3 downto 0);
		 in2 : in STD_LOGIC_VECTOR (3 downto 0);
		 in3 : in STD_LOGIC_VECTOR (3 downto 0);
		 in4 : in STD_LOGIC_VECTOR (3 downto 0);
		 clk : in STD_LOGIC;
		 dp : out STD_LOGIC;
		 sel : out STD_LOGIC_VECTOR (3 downto 0);
		 segment : out STD_LOGIC_VECTOR (6 downto 0));
		 
end component;

   type state_type is (idle,op,last,done);
   signal state_reg, state_next: state_type;
   signal rh_reg, rh_next: unsigned(W-1 downto 0);
   signal rl_reg, rl_next: std_logic_vector(W-1 downto 0);
   signal rh_tmp: unsigned(W-1 downto 0);
   signal d_reg, d_next: unsigned(W-1 downto 0);
   signal n_reg, n_next: unsigned(CBIT-1 downto 0);
   signal q_bit: std_logic;
	signal seg_out_7 : STD_LOGIC_VECTOR(6 downto 0);
   signal seg_sel_4: STD_LOGIC_VECTOR (3 downto 0);
	
begin
   -- fsmd state and data registers
   process(clk,reset)	
   begin
      if reset='1' then
         state_reg <= idle;
         rh_reg <= (others=>'0');
         rl_reg <= (others=>'0');
         d_reg <= (others=>'0');
         n_reg <= (others=>'0');
      elsif (clk'event and clk='1') then
         state_reg <= state_next;
         rh_reg <= rh_next;
         rl_reg <= rl_next;
         d_reg <= d_next;
         n_reg <= n_next;
      end if;
   end process;

   -- fsmd next-state logic and data path logic
   process(state_reg,n_reg,rh_reg,rl_reg,d_reg,
           start,dvsr,dvnd,q_bit,rh_tmp,n_next)
   begin
	   curr_state_led <= "0000";
      ready <='0';
      done_tick <= '0';
      state_next <= state_reg;
      rh_next <= rh_reg;
      rl_next <= rl_reg;
      d_next <= d_reg;
      n_next <= n_reg;
      case state_reg is
         when idle =>
			   curr_state_led <= "0001";
            ready <= '1';
            if start='1' then
               rh_next <= (others=>'0');
               rl_next <= dvnd;                  -- dividend
               d_next <= unsigned(dvsr);         -- divisor
               n_next <= to_unsigned(W+1, CBIT); -- index
               state_next <= op;
            end if;
         when op =>
			   curr_state_led <= "0010";
            -- shift rh and rl left
            rl_next <= rl_reg(W-2 downto 0) & q_bit;
            rh_next <= rh_tmp(W-2 downto 0) & rl_reg(W-1);
            --decrease index
            n_next <= n_reg - 1;
            if (n_next=1) then
               state_next <= last;
            end if;
         when last =>  -- last iteration
				curr_state_led <= "0100";
            rl_next <= rl_reg(W-2 downto 0) & q_bit;
            rh_next <= rh_tmp;
            state_next <= done;
         when done =>
			   curr_state_led <= "1000";
            state_next <= idle;
            done_tick <= '1';
      end case;
   end process;

   -- compare and subtract
   process(rh_reg, d_reg)
   begin
      if rh_reg >= d_reg then
         rh_tmp <= rh_reg - d_reg;
         q_bit <= '1';
      else
         rh_tmp <= rh_reg;
         q_bit <= '0';
      end if;
end process;

   -- output
	C1 : seven_four port map (quo, rmd, "0000", "0000", clk, '1', seg_sel_4, seg_out_7);
	
	quo <= (seg_out_7 & '1');
   rmd <= ("1111" & seg_sel_4);
	
end arch;