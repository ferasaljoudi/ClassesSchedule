<div style="width: 100%;">
    <a href="#"><img src="https://raw.githubusercontent.com/ferasaljoudi/AssetsRepository/main/SVGsHeader/classSchedules.svg" alt="Class Schedules" style="width: 100%"></a>
</div>
<br>

This is an individual lab project for the ENEL384 class. The requirement of the project is to design a synchronous circuit of reasonable complexity ( > 1 stage, < 100 stages), which means that the project can not be composed solely of combinational logic.

To design the chosen project (Class Schedules), I used VHSIC Hardware Description Language (VHDL), Vivado (a software for hardware description language designs) and the BASYS-3 FPGA 
Board.

<br>
<div style="width: 100%;">
    <a href="#"><img src="https://raw.githubusercontent.com/ferasaljoudi/AssetsRepository/main/BrownSVGs/demo.svg" alt="Demo" style="width: 100%"></a>
</div>
<br>

<div align="center">
    <a href="https://www.youtube.com/watch?v=rJdZfiHNr7o" target="_blank">
    <img src="DemoGif/classSchedules.gif" alt="Demo Gif">
    </a>
</div>


<br>
<div style="width: 100%;">
    <a href="#"><img src="https://raw.githubusercontent.com/ferasaljoudi/AssetsRepository/main/BrownSVGs/technologiesUsed.svg" alt="Technologies Used" style="width: 100%"></a>
</div>
<br>

<div align="center">
<table>
  <tr>
    <td>
        <a href="https://www.doulos.com/knowhow/vhdl/what-is-vhdl/"><img src="https://raw.githubusercontent.com/ferasaljoudi/AssetsRepository/main/Badges/Languages/Right/vhdl.svg" alt="VHDL"></a>
        <br>
        <a href="https://www.xilinx.com/products/design-tools/vivado.html"><img src="https://raw.githubusercontent.com/ferasaljoudi/AssetsRepository/main/Badges/ToolsAndPlatforms/Middle/vivado.svg" alt="Vivado"></a>
        <br>
        <a href="https://digilent.com/reference/programmable-logic/basys-3/start"><img src="https://raw.githubusercontent.com/ferasaljoudi/AssetsRepository/main/Badges/Hardware/Middle/basys3.svg" alt="Basys3"></a>
    </td>
  </tr>
</table>
</div>

<br>
<div style="width: 100%;">
    <a href="#"><img src="https://raw.githubusercontent.com/ferasaljoudi/AssetsRepository/main/BrownSVGs/description.svg" alt="Description" style="width: 100%"></a>
</div>
<br>

In the FPGA board, I used:
- Four Switches to turn ON or OFF the 4 classes/subjects.
- Five buttons to select what do we want to display
    - Left button for class
    - Center button for lab
    - Right button for seminar
    - Top button for midterm
    - Bottom button for final
- Four 7-Segments to display class names, time and date.
- The first 4 LEDs on the right of the FPGA to highlight which switch is corresponding to which class
- The first 5 LEDs on the left of the FPGA to represent the weekdays (Monday to Friday)

To display 4 different letters/numbers on the four 7-segment displays where the anode of each 7- segment is driven from four transistors which have common 3.3V, I used a multiplexing technique. I created a clock which will switch between each display at intervals of 0.0025 seconds, which is too fast for the human eye to discern. I produce the illusion that all four displays are lighting simultaneously. This allowed me to represent different letters/numbers on each display.

Then I created a second clock which is for 3 seconds. When all 4 switches are OFF, this clock allows me to represent the pattern of the 4 LEDs on the right of the FPGA. Each LED is represented for 3 seconds and it highlights a class switch. Along with these LEDs, the 7 segment displays the name of the class for the corresponding led, and the 5 LEDs on the left will display the days that are occupied by the displayed class.

Then I used combinational logic (if, elsif, case) to determine the output (9 LEDs and 7 segment display) based on the input (4 switches and 5 buttons).

<br>
<div style="width: 100%;">
    <a href="#"><img src="https://raw.githubusercontent.com/ferasaljoudi/AssetsRepository/main/BrownSVGs/resources.svg" alt="Resources" style="width: 100%"></a>
</div>
<br>

<b>To view the YouTube video demonstrating the ClassesSchedule on the FPGA:</b>

- _<a href="https://www.youtube.com/watch?v=rJdZfiHNr7o" title="Watch a demonstration of the ClassesSchedule">Click Here</a>_


### Note:
I only had to write the Enel384Project.vhd file. The Basys-3-Master.xdc is a general .xdc file for the Basys3, and it is essential to define the pins and constraints for the Basys3 FPGA board. To view the .xdc file on the Digilent website:

Click _<a href="https://digilent.com/reference/programmable-logic/basys-3/start" title="Basys 3 - Digilent Reference">HERE</a>_ then find the "Master XDC Files" link.
