---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
-------------------------------------- Name: Mhd Feras Aljoudi ------------------------------------------------
-------------------------------------------- Major: SSE -------------------------------------------------------
---------------------------------------- ENEL384-Lab-Project --------------------------------------------------
----------------------------------- Project Name: ClassesSchedule ---------------------------------------------
---------------------------------------- Date: Nov. 21, 2023 --------------------------------------------------
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Enel384Project is
    Port (
        -- 4 Switches for 4 classes
        sw : in STD_LOGIC_VECTOR(3 downto 0);
        -- 7 Segment Display
        seg : out STD_LOGIC_VECTOR (6 downto 0);
        -- Controlling each of the 4 7Segment display
        an : out STD_LOGIC_VECTOR(3 downto 0);
        -- Clock
        clk : in STD_LOGIC;
        -- The first 4 LEDs on the right of the FPGA will highlight which switch is corresponding to which class
        led : out std_logic_vector (3 downto 0);
        -- The first 5 LEDs on the left of the FPGA will represent the weekdays (Monday to Friday)
        weekDays : out STD_LOGIC_VECTOR (15 downto 11);
        -- Left button will represent the class time and days
        class : in STD_LOGIC;
        -- Center button will represent the lab time and day
        lab : in STD_LOGIC;
        -- Right button will represent the seminar time and day
        seminar : in std_logic;
        -- Top button will represent the midterm time and day
        midterm : in STD_LOGIC;
        -- Bottom button will represent the final time and day
        final : in std_logic
        );
end Enel384Project;

architecture Behaviour of Enel384Project is
    signal first_clk : integer := 0;
    signal seg_display : integer range 0 to 3 := 0;
    signal second_clk : integer := 0;
    signal led_display : integer range 0 to 3 := 0;
begin
    -- The fist clk will be for 0.0025 seconds
    -- This will allow us to represent 4 different 7Segment display
    -- The delay between each 7segment display is 0.0025 seconds
    -- And this can not be catched by the human eye
    -- So I will create the impression that the 4 different 7Segment are displayed at the same time 
    process(clk)
    begin
        if rising_edge(clk) then
            if first_clk < 250000  then
                first_clk <= first_clk + 1;
            else
                first_clk <= 0;
                seg_display <= (seg_display + 1);
            end if;
        end if;
    end process;
    -- The second clk will be for 3 seconds
    -- When all 4 switches are OFF, 
    -- this clk will help to represent the pattren of the 4 LEDs on the right of the FPGA
    -- Each LED with its corresponding class and days will be represented for 3 seconds
    process(clk)
    begin
        if rising_edge(clk) then
            if second_clk < (100000000 * 3)  then
                second_clk <= second_clk + 1;
            else
                second_clk <= 0;
                led_display <= (led_display + 1);
            end if;
        end if;
    end process;
    
    process(sw, seg_display, led_display, clk)
    begin
        case seg_display is
            when 0 => an <= "1110"; -- Activate the first 7segment from the right of the FPGA 
            when 1 => an <= "1101"; -- Activate the second 7segment from the right of the FPGA 
            when 2 => an <= "1011"; -- Activate the third 7segment from the right of the FPGA 
            when 3 => an <= "0111"; -- Activate the fourth 7segment from the right of the FPGA 
        end case;
        -- If the first switch is ON and no button is pressed
        if (sw(0) = '1' and class = '0' and lab = '0' and midterm = '0' and final = '0') then
            case seg_display is
                when 0 => seg <= "0011001"; -- Representing '4'
                when 1 => seg <= "0000000"; -- Representing '8'
                when 2 => seg <= "0110000"; -- Representing '3'
                when 3 => seg <= "0000110"; -- Representing 'E'
                weekDays <= "00000";
                led <= "0001";
            end case;
        -- If the first switch is ON and class button is pressed
        elsif (sw(0) = '1' and class = '1') then
            case seg_display is
                when 0 => seg <= "1000000"; -- Representing '0'
                when 1 => seg <= "0110000"; -- Representing '3'
                when 2 => seg <= "0011001"; -- Representing '4'
                when 3 => seg <= "1111001"; -- Representing '1'
                weekDays <= "10100";
                led <= "0001";
            end case;
        -- If the first switch is ON and lab button is pressed
        elsif (sw(0) = '1' and lab = '1') then
            case seg_display is
                when 0 => seg <= "1000000"; -- Representing '0'
                when 1 => seg <= "0110000"; -- Representing '3'
                when 2 => seg <= "0000000"; -- Representing '8'
                when 3 => seg <= "1000000"; -- Representing '0'
                weekDays <= "00001";
                led <= "0001";
            end case;
        -- If the first switch is ON and midterm button is pressed
        elsif (sw(0) = '1' and midterm = '1') then
            case seg_display is
                when 0 => seg <= "0010010"; -- Representing '5'
                when 1 => seg <= "0100100"; -- Representing '2'
                when 2 => seg <= "0100111"; -- Representing 'c'
                when 3 => seg <= "0100011"; -- Representing 'o'
                weekDays <= "00100";
                led <= "0001";
            end case;
        -- If the first switch is ON and final button is pressed
        elsif (sw(0) = '1' and final = '1') then
            case seg_display is
                when 0 => seg <= "0100100"; -- Representing '2'
                when 1 => seg <= "1111001"; -- Representing '1'
                when 2 => seg <= "0000110"; -- Representing 'E'
                when 3 => seg <= "0100001"; -- Representing 'd'
                weekDays <= "01000";
                led <= "0001";
            end case;
        -- If the second switch is ON and no button is pressed
        elsif (sw(1) = '1' and class = '0' and lab = '0' and midterm = '0' and final = '0') then
            case seg_display is
                when 0 => seg <= "0100100"; -- Representing '2'
                when 1 => seg <= "0010010"; -- Representing '5'
                when 2 => seg <= "0110000"; -- Representing '3'
                when 3 => seg <= "0000110"; -- Representing 'E'
                weekDays <= "00000";
                led <= "0010";
            end case;
        -- If the second switch is ON and class button is pressed
        elsif (sw(1) = '1' and class = '1') then
            case seg_display is
                when 0 => seg <= "1000000"; -- Representing '0'
                when 1 => seg <= "1000000"; -- Representing '0'
                when 2 => seg <= "0000010"; -- Representing '6'
                when 3 => seg <= "1111001"; -- Representing '1'
                weekDays <= "10100";
                led <= "0010";
            end case;
        -- If the second switch is ON and lab button is pressed
        elsif (sw(1) = '1' and lab = '1') then
            case seg_display is
                when 0 => seg <= "1000000"; -- Representing '0'
                when 1 => seg <= "0110000"; -- Representing '3'
                when 2 => seg <= "0000000"; -- Representing '8'
                when 3 => seg <= "1000000"; -- Representing '0'
                weekDays <= "00100";
                led <= "0010";
            end case;
        -- If the second switch is ON and midterm button is pressed
        elsif (sw(1) = '1' and midterm = '1') then
            case seg_display is
                when 0 => seg <= "1111001"; -- Representing '1'
                when 1 => seg <= "1000000"; -- Representing '0'
                when 2 => seg <= "0100011"; -- Representing 'o'
                when 3 => seg <= "0101011"; -- Representing 'n'
                weekDays <= "00100";
                led <= "0010";
            end case;
        -- If the second switch is ON and final button is pressed
        elsif (sw(1) = '1' and final = '1') then
            case seg_display is
                when 0 => seg <= "0110000"; -- Representing '3'
                when 1 => seg <= "1111001"; -- Representing '1'
                when 2 => seg <= "0000110"; -- Representing 'E'
                when 3 => seg <= "0100001"; -- Representing 'd'
                weekDays <= "00100";
                led <= "0010";
            end case;
        -- If the third switch is ON and no button is pressed
        elsif (sw(2) = '1' and class = '0' and seminar = '0' and midterm = '0' and final = '0') then
            case seg_display is
                when 0 => seg <= "0110000"; -- Representing '3'
                when 1 => seg <= "1000000"; -- Representing '0'
                when 2 => seg <= "0110000"; -- Representing '3'
                when 3 => seg <= "0000110"; -- Representing 'E'
                weekDays <= "00000";
                led <= "0100";
            end case;
        -- If the third switch is ON and class button is pressed
        elsif (sw(2) = '1' and class = '1') then
            case seg_display is
                when 0 => seg <= "1000000"; -- Representing '0'
                when 1 => seg <= "0110000"; -- Representing '3'
                when 2 => seg <= "1111000"; -- Representing '7'
                when 3 => seg <= "1111001"; -- Representing '1'
                weekDays <= "01010";
                led <= "0100";
            end case;
        -- If the third switch is ON and seminar button is pressed
        elsif (sw(2) = '1' and seminar = '1') then
            case seg_display is
                when 0 => seg <= "1000000"; -- Representing '0'
                when 1 => seg <= "1000000"; -- Representing '0'
                when 2 => seg <= "0000010"; -- Representing '6'
                when 3 => seg <= "1111001"; -- Representing '1'
                weekDays <= "00001";
                led <= "0100";
            end case;
        -- If the third switch is ON and midterm button is pressed
        elsif (sw(2) = '1' and midterm = '1') then
            case seg_display is
                when 0 => seg <= "1111000"; -- Representing '7'
                when 1 => seg <= "1111001"; -- Representing '1'
                when 2 => seg <= "0100111"; -- Representing 'c'
                when 3 => seg <= "0100011"; -- Representing 'o'
                weekDays <= "01000";
                led <= "0100";
            end case;
        -- If the third switch is ON and final button is pressed
        elsif (sw(2) = '1' and final = '1') then
            case seg_display is
                when 0 => seg <= "0100100"; -- Representing '2'
                when 1 => seg <= "1111001"; -- Representing '1'
                when 2 => seg <= "0000110"; -- Representing 'E'
                when 3 => seg <= "0100001"; -- Representing 'd'
                weekDays <= "01000";
                led <= "0100";
            end case;
        -- If the fourth switch is ON and no button is pressed
        elsif (sw(3) = '1' and class = '0' and final = '0') then
            case seg_display is
                when 0 => seg <= "0100100"; -- Representing '2'
                when 1 => seg <= "1111000"; -- Representing '7'
                when 2 => seg <= "0110000"; -- Representing '3'
                when 3 => seg <= "1000110"; -- Representing 'C'
                weekDays <= "00000";
                led <= "1000";
            end case;
        -- If the fourth switch is ON and class button is pressed
        elsif (sw(3) = '1' and class = '1') then
            case seg_display is
                when 0 => seg <= "1000000"; -- Representing '0'
                when 1 => seg <= "0110000"; -- Representing '3'
                when 2 => seg <= "0010000"; -- Representing '9'
                when 3 => seg <= "1111001"; -- Representing '1'
                weekDays <= "01010";
                led <= "1000";
            end case;
        -- If the fourth switch is ON and final button is pressed
        elsif (sw(3) = '1' and final = '1') then
            case seg_display is
                when 0 => seg <= "0010000"; -- Representing '9'
                when 1 => seg <= "1111001"; -- Representing '1'
                when 2 => seg <= "0000110"; -- Representing 'E'
                when 3 => seg <= "0100001"; -- Representing 'd'
                weekDays <= "01000";
                led <= "1000";
            end case;
        else
            -- When all 4 switches are OFF, we will represent the pattren of the 4 LEDs on the right of the FPGA
            case led_display is
                when 0 => led <= "0001"; -- Representing the first led on the right of the FPGA
                when 1 => led <= "0010"; -- Representing the second led on the right of the FPGA
                when 2 => led <= "0100"; -- Representing the third led on the right of the FPGA
                when 3 => led <= "1000"; -- Representing the fourth led on the right of the FPGA
            end case;
            -- For each LED, we will represent the class associate with it 
            -- and the days which are occupied by a class, lab or seminar
            if (led_display = 0) then
                case seg_display is
                    when 0 => seg <= "0011001"; -- Representing '4'
                    when 1 => seg <= "0000000"; -- Representing '8'
                    when 2 => seg <= "0110000"; -- Representing '3'
                    when 3 => seg <= "0000110"; -- Representing 'E'
                    weekDays <= "10101";
                end case;
            elsif (led_display = 1) then
                case seg_display is
                    when 0 => seg <= "0100100"; -- Representing '2'
                    when 1 => seg <= "0010010"; -- Representing '5'
                    when 2 => seg <= "0110000"; -- Representing '3'
                    when 3 => seg <= "0000110"; -- Representing 'E'
                    weekDays <= "10100";
                end case;
            elsif (led_display = 2) then
                case seg_display is
                    when 0 => seg <= "0110000"; -- Representing '3'
                    when 1 => seg <= "1000000"; -- Representing '0'
                    when 2 => seg <= "0110000"; -- Representing '3'
                    when 3 => seg <= "0000110"; -- Representing 'E'
                    weekDays <= "01011";
                end case;
            elsif (led_display = 3) then
                case seg_display is
                    when 0 => seg <= "0100100"; -- Representing '2'
                    when 1 => seg <= "1111000"; -- Representing '7'
                    when 2 => seg <= "0110000"; -- Representing '3'
                    when 3 => seg <= "1000110"; -- Representing 'C'
                    weekDays <= "01010";
                end case;
            end if;
        end if;
        
    end process;
    
end Behaviour;