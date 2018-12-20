library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity FSM is
    Port ( item_select : in STD_LOGIC_VECTOR (1 downto 0);
           request : in STD_LOGIC;
           one_tl : in STD_LOGIC;
           take_item : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           ready_led : out STD_LOGIC;
           current_state : out STD_LOGIC_VECTOR(3 downto 0);
           girilen_para_out : out STD_LOGIC_VECTOR(3 downto 0));
end FSM;

architecture Behavioral of FSM is

    type state_type is (s0, s1, s2);
	 
    signal state_reg, state_next : state_type;
    signal istenen_urun_kaydi : std_logic_vector(1 downto 0);	
	 signal cash_increase : std_logic := '0';
    signal girilen_para : unsigned(3 downto 0) := "0000";
    signal count : unsigned (31 downto 0) := (others => '0');
	
    begin
    
			-- first process --
        process (state_reg, clk, reset)
			  begin
					if (reset = '1') then
						 state_reg <= s0;
					elsif (clk = '1' and clk'event) then
						 state_reg <= state_next;
            end if;
        end process;
        
        process (state_reg, take_item, request, item_select, one_tl)                         
                begin
                if (clk = '1' and clk'event) then
                    case state_reg is
                        when s0 =>
                            ready_led <= '0';
                            cash_increase <= '0';
                            girilen_para <= "0000";
                            if (request = '1') then
                                istenen_urun_kaydi <= item_select;
                                state_next <= s1;
                            else
                                state_next <= state_reg;
                            end if;
                        when s1 =>
                            -- burada kullaniciya vakit taniyoruz !! --
									 if (count < 250000000) then  
                                count <= count + 1;
                                
                                girilen_para_out <= std_logic_vector(girilen_para);
                                
                                if (cash_increase = '0' and one_tl = '1') then
                                    cash_increase <= '1';
                                    girilen_para <= girilen_para +1; 
                                elsif (one_tl = '0') then
                                    cash_increase <= '0';
                                end if;
                            else
                                count <= (others => '0');
                                girilen_para <= "0000";
                                
                                if (item_select = "00" and (girilen_para = 1 or girilen_para > 1)) then
                                    istenen_urun_kaydi <= "00";
                                    state_next <= s2;
                                elsif (item_select = "01" and (girilen_para = 2 or girilen_para > 2)) then
                                    istenen_urun_kaydi <= "01";
                                    state_next <= s2;
                                elsif (item_select = "10" and (girilen_para = 3 or girilen_para > 3)) then
                                    istenen_urun_kaydi <= "10";
                                    state_next <= s2;
                                elsif (item_select = "11" and (girilen_para = 4 or girilen_para > 4)) then
                                    istenen_urun_kaydi <= "11";
                                    state_next <= s2;
                                else
                                    state_next <= s0;
                                end if;
                            end if;             

                        when s2 =>
                                ready_led <= '1';    
                            if (take_item = '1') then
                                state_next <= s0;
                            end if;
                        end case;
                                  
                end if;
                end process;
        
        -- 7 segment
        process (state_reg)
        
        begin
        
            if (state_reg = s0) then
                  current_state <= "0000";
            elsif (state_reg = s1) then
                  current_state <= "0001";
            elsif (state_reg = s2) then
                  current_state <= "0010";
            end if;
            
         end process;

end Behavioral;