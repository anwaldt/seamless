# Signal Flow

The following flow chart visualizes the interconnection between the software components. Scroll down to get the exact input and output assignment.

![Signal Flow](graphics/hufo_flow_2.png)

## Input-Output Assignment

## Linux: MAIN (DANTE)



Inputs  | Source
---     | ---  
001-032  | Source channels from Mac Book
033-036  | Direct to 1st order HOA
037-052  | Direct to 3rd order HOA
053      | Direct to SUB
065-096  | Source channels from Mac Book
097-100  | Direct to 1st order HOA
101-115  | Direct to 3rd order HOA
116      | Direct to SUB


Outputs | Target
---     | ---  
1-22    | DAC 1 (Ambisonics speakers 1-22)
23-44   | DAC 2 (Ambisonics speakers 23-44)
45      | DAC 1 (Ambisonics spekaer 45)
46-47   | DAC 1 (SUB 1-2)
48-49   | DAC 2 (SUB 3-4)

----
