
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity div is
    generic(
       W: integer:=6;
       CBIT: integer:=4   -- CBIT=log2(W)+1
    );
    port(
        clk, reset: in std_logic;
        start: in std_logic;
        dvnd: in std_logic_vector(W-1 downto 0);
		  dvsr : in std_logic_vector(CBIT-1 downto 0);
        ready, done_tick: out std_logic;
       -- quo, rmd: out std_logic_vector(W-1 downto 0);
		  seg_out: out std_logic_vector(7 downto 0);
		 seg_sel: out std_logic_vector(7 downto 0)		
    );
end div;

architecture arch of div is

component seven_four
port(in1 : in  STD_LOGIC_VECTOR (3 downto 0);
           in2 : in  STD_LOGIC_VECTOR (3 downto 0);
           in3 : in  STD_LOGIC_VECTOR (3 downto 0);
           in4 : in  STD_LOGIC_VECTOR (3 downto 0);
           clk : in  STD_LOGIC;
			  dp  : out  STD_LOGIC;
           sel : out  STD_LOGIC_VECTOR (3 downto 0);
           segment : out  STD_LOGIC_VECTOR (6 downto 0)
			  
			  );
end component;


   type state_type is (idle,op,last,done);
   signal state_reg, state_next: state_type;
   signal rh_reg, rh_next: unsigned(W-1 downto 0);
   signal rl_reg, rl_next: std_logic_vector(W-1 downto 0);
   signal rh_tmp: unsigned(W-1 downto 0);
   signal d_reg, d_next: unsigned(W-1 downto 0);
   signal n_reg, n_next: unsigned(CBIT-1 downto 0);
   signal q_bit,dp: std_logic;
	signal seg_sel_4 : STD_LOGIC_VECTOR(3 downto 0);
	signal quo, rmd:  std_logic_vector(w-1 downto 0);
	signal seg_out_7 :STD_LOGIC_VECTOR(6 downto 0);
	signal state_nerde : STD_LOGIC_VECTOR(3 downto 0);
begin
   
U6: seven_four port map(rmd(3 downto 0),quo(3 downto 0),"00"&quo(w-1 downto 4),state_nerde,clk,dp,seg_sel_4,seg_out_7);
seg_out <= (seg_out_7 & dp);
seg_sel <= "1111" & seg_sel_4;
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
      ready <='0';
      done_tick <= '0';
      state_next <= state_reg;
      rh_next <= rh_reg;
      rl_next <= rl_reg;
      d_next <= d_reg;
      n_next <= n_reg;
      case state_reg is
         when idle =>
			   state_nerde<="0000";
            ready <= '1';
            if start='1' then
               rh_next <= (others=>'0');
               rl_next <= dvnd;                  -- dividend
               d_next <= unsigned("00"&dvsr);         -- divisor
               n_next <= to_unsigned(W+1, CBIT); -- index
               state_next <= op;
            end if;
         when op =>
           
				state_nerde<="0001";
            rl_next <= rl_reg(W-2 downto 0) & q_bit;
            rh_next <= rh_tmp(W-2 downto 0) & rl_reg(W-1);
            --decrease index
            n_next <= n_reg - 1;
            if (n_next=1) then
               state_next <= last;
            end if;
         when last =>  -- last iteration
			   state_nerde<="0010";
            rl_next <= rl_reg(W-2 downto 0) & q_bit;
            rh_next <= rh_tmp;
            state_next <= done;
         when done =>
			   state_nerde<="0011";
            state_next <= idle;
            done_tick <= '1';
      end case;
   end process;

   
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

   
   quo <= rl_reg;
   rmd <= std_logic_vector(rh_reg );
end arch;