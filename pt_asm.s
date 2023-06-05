@ Data section - initialized values
.data
.align 3 @ This alignment is critical - to access our "huge" value, it must
@ be 64 bit aligned
huge: .octa 0xAABBCCDDDDCCBBAA
big: .word 0xAAAABBBB
num: .byte 0xAB
str2: .asciz "Hallo Welt!"
count: .word 12345 @ This is an initialized 32 bit value
@ Function Declaration : int add_test(int x, int y)
@ Test code for my own new function called from C
@ This is a comment. Anything after an @ symbol is ignored.
@@ This is also a comment. Some people use double @@ symbols.
    .code 16 @ This directive selects the instruction set being generated.

@ The value 16 selects Thumb, with the value 32 selecting ARM.
    .text @ Tell the assembler that the upcoming section is to be considered

@ assembly language instructions - Code section (text -> ROM)
@@ Function Header Block
    .align 2 @ Code alignment - 2^n alignment (n=2)

@ This causes the assembler to use 4 byte alignment
    .syntax unified @ Sets the instruction set to the new unified ARM + THUMB

@ instructions. The default is divided (separate instruction sets)
    .global add_test @ Make the symbol name for the function visible to the linker

    .code 16 @ 16bit THUMB code (BOTH .code and .thumb_func are required)
    .thumb_func @ Specifies that the following symbol is the name of a THUMB

@ encoded function. Necessary for interlinking between ARM and THUMB code.
    .type add_test, %function @ Declares that the symbol is a function (not strictly required)
    @ Actual declaration of the symbol
    @ Data section - initialized values


@ Function Declaration : int add_test(int x, int y)
@
@ Input: r0, r1 (i.e. r0 holds x, r1 holds y)
@ Returns: r0
@
@ Here is the actual add_test function
    add_test:
    push {r4,r5, lr}    @ push the r4, r5 and lr register on the stack

    mov r2, r0 @ Load the address of big
    mov r3, #0

    loop:
    cmp r1, #0
    beq out1

    ldrb r1, [r2,r3] @ Load the value of big
    add r3, r3, #1
    b loop

    out1:
    pop {r4,r5, lr}      @ pop the r4,r5 and lr register out of the stack
    bx lr                @ Return (Branch eXchange) to the address in the link register (lr)



    .size add_test, .-add_test @@ - symbol size (not strictly required, but makes the debugger happy)


@ Function Declaration : int busy_delay(int cycles)
@
@ Input: r0 (i.e. r0 holds number of cycles to delay)
@ Returns: r0
@
@ Here is the actual function. DO NOT MODIFY THIS FUNCTION.
    busy_delay:
    push {r5}
    mov r5, r0

    delay_1oop:
    subs r5, r5, #1
    bge delay_1oop
    mov r0, #0 @ Return zero (success)
    pop {r5}
    bx lr @ Return (Branch eXchange) to the address in the link register (lr)



@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   Assignment 2 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Assembly file ended by single .end directive on its own line
    .code 16 @ This directive selects the instruction set being generated.

@ The value 16 selects Thumb, with the value 32 selecting ARM.
    .text @ Tell the assembler that the upcoming section is to be considered

@ assembly language instructions - Code section (text -> ROM)
@@ Function Header Block
    .align 2 @ Code alignment - 2^n alignment (n=2)

@ This causes the assembler to use 4 byte alignment
    .syntax unified @ Sets the instruction set to the new unified ARM + THUMB

@ instructions. The default is divided (separate instruction sets)
    .global pt_led_demo_a2
    .global ptGame_A3

    .code 16 @ 16bit THUMB code (BOTH .code and .thumb_func are required)
    .thumb_func @ Specifies that the following symbol is the name of a THUMB

@ encoded function. Necessary for interlinking between ARM and THUMB code.
    .type pt_led_demo_a2, %function @ Declares that the symbol is a function (not strictly required)
    @ Actual declaration of the symbol
    @ Data section - initialized values

@ Function Declaration : int pt_led_demo_a2(int count, int delay)
@
@ Input: r0, r1 (i.e. r0 holds count, r1 holds delay)
@ Returns: r0
@
@ Here is the actual pt_led_demo_a2 function
    pt_led_demo_a2:
    push {r4,r5,r6,lr}    @ push the r4, r5, r6 and lr register on the stack
   
    mov r4, r0            @ copy the count value and save it in r4 
    mov r5, r1            @ copy the delay value and save it in r5
    mov r6, #8            @ The r6 holds the LEDs index

    @ This main_loop will repeat 8 LEDs based on the user's input
    main_loop:
    subs r4,r4, #1          @ Subtract to count down the loop
    blt exit_main_loop      @ If r4 < 0, exit the loop

        @ This small loop will toggle 8 LEDs
        loop1:
        subs r6, r6, #1        @ Subtract to count down the loop
        blt out                @ if r6 < 0, exit the loop

        mov r0, r6             @ move the led index to r0
        bl BSP_LED_Toggle      @ cal the BSP_LED_Toggle
        
        mov r0, r5             @ copy the r5 value to r0
        bl busy_delay          @ call the busy_delay
        
        mov r0, r6             @ move the led index to r0
        bl BSP_LED_Toggle      @ cal the BSP_LED_Toggle

        mov r0, r5             @ copy the r5 value to r0
        bl busy_delay          @ call the busy_delay

        b loop1                @ back to the loop1 again

        @ exit small loop1
        out:
        mov r6, #8             @ reset the led circle
        b main_loop            @ go back to the main loop


    @ exit main loop
    exit_main_loop:
    pop {r4,r5,r6,lr}        @ pop the r4,r5,r6 and lr register out of the stack
    bx lr                    @ Return (Branch eXchange) to the address in the link register (lr)


@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   Assignment 3 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
ptGame_A3:
    push {r4 - r10, lr}
    mov r6, #10000          
    mul r0,r0, r6       @ Convert delay to milliseconds

    mov r5, #0          @ the index for pattern string
    mov r6, r0          @ After convert, we put the delay in r6
    mov r7, r1          @ move the pattern to r7
    mov r8, r2          @ move the target value to r8
    mov r9, #7          @ The index for turnning off the LEDs
    
@ This loop is used to toggle the LEDs with pattern string
@ And check if user presses the buttion
loop_main:
    ldrb r4, [r7,r5]    @ Load the value of the pattern string at offset r5 and put it in r4 register
    cmp r4, #0          @ Check if it reaches the null character
    beq reset_pattern   @ If r == 0, we reset the pattern to loop again

    sub r4, r4, #48     @ convert the byte to decimal

    mov r0, r4          @ move a single character from the pattern string to r0
    bl BSP_LED_Toggle   @ Toggle that LED

    mov r0, r6          @ Move the value of delay to r0
    bl busy_delay       @ call the busu_delay

    mov r0, #0          @ set the value of r0 to 0
    bl BSP_PB_GetState  @ call BSP_PB_GetState

    cmp r0, #1          @ check if button is pressed
    beq check_winner    @ call the check_button subroutine to check if you user wins or losses

    mov r0, r4          @ move a single character from the pattern string to r0
    bl BSP_LED_Toggle   @ Toggle that LED

    mov r0, r6          @ Move the value of delay to r0
    bl busy_delay       @ call the busu_delay

    add r5, r5, #1      @ increase the index by 1
    b loop_main         @ back to loop_main


@ This part is used to reset the offset of the pattern string
reset_pattern:
    mov r5, #0          @ move 0 to r5
    b loop_main         @ back to loop_main

@ This subroutine is used to check the user presses the LED target
check_winner:
    cmp r8, r4          @ compare the LEDs that user pressed with the LED target
    beq user_win        @ if they are equal
    b user_loss         @ if they are not equal

@ This subroutine is used when user losses the game
@ It will turn on the LED target
user_loss:
    bl turn_off_LEDs    @ Call the turn_off_LEDs subroutine

    mov r0, r8          @ move the LED target to r0
    bl BSP_LED_Toggle   @ Call the BSP_LED_Toggle   

    b exit_loop         @ Exit the game

@ This subroutine is used when user wins the game
@ It will toggle all LEDs twice
user_win:
    bl turn_on_LEDs     @ call turn_on_LEDs subroutine
    mov r9, #7          @ reset The index for turnning on the LEDs

    mov r0, r6          @ Move the value of delay to r0
    bl busy_delay       @ call the busy_delay

    bl turn_off_LEDs    @ call turn_off_LEDs subroutine
    mov r9, #7          @ reset The index for turnning off the LEDs

    mov r0, r6          @ Move the value of delay to r0
    bl busy_delay       @ call the busy_delay

    bl turn_on_LEDs     @ call turn_on_LEDs subroutine
    mov r9, #7          @ reset The index for turnning on the LEDs

    mov r0, r6          @ Move the value of delay to r0
    bl busy_delay       @ call the busy_delay

    bl turn_off_LEDs    @ call turn_off_LEDs subroutine
    b exit_loop         @ Exit the game

@ This subroutine is used to turn off all the LEDS    
turn_off_LEDs:
    push {lr}
    mov r0, r9          @ mov the LED index to r0
    bl BSP_LED_Off      @ call the BSP_LED_Off 
    subs r9, r9, #1     @ decrease the index
    bge turn_off_LEDs   @ Check if the index < 0
    pop {lr}
    bx lr

@ This subroutine is used to turn on all the LEDS    
turn_on_LEDs:
    push {lr}
    mov r0, r9          @ mov the LED index to r0
    bl BSP_LED_On       @ call the BSP_LED_Off 
    subs r9, r9, #1     @ decrease the index
    bge turn_on_LEDs    @Check if the index < 0
    pop {lr}
    bx lr

@ Exit the game
exit_loop:
    pop {r4 - r10, lr}
    bx lr


@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   Assignment 4 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Assembly file ended by single .end directive on its own line
    .code 16 @ This directive selects the instruction set being generated.

@ The value 16 selects Thumb, with the value 32 selecting ARM.
    .text @ Tell the assembler that the upcoming section is to be considered

@ assembly language instructions - Code section (text -> ROM)
@@ Function Header Block
    .align 2 @ Code alignment - 2^n alignment (n=2)

@ This causes the assembler to use 4 byte alignment
    .syntax unified @ Sets the instruction set to the new unified ARM + THUMB

@ instructions. The default is divided (separate instruction sets)
    .global ptTilt_A4

    .code 16 @ 16bit THUMB code (BOTH .code and .thumb_func are required)
    .thumb_func @ Specifies that the following symbol is the name of a THUMB

@ encoded function. Necessary for interlinking between ARM and THUMB code.
    .type ptTilt_A4, %function @ Declares that the symbol is a function (not strictly required)
    @ Actual declaration of the symbol
    @ Data section - initialized values

@ define magic numbers
.equ I2C_Address, 0x32
.equ X_HI, 0x29
.equ Y_HI, 0x2B

@ Function Declaration : int ptTilt_A4(int delay, int target, int time_game)
@
@ Input: r0, r1 (i.e. r0 holds delay, r1 holds target, r2 holds time_game)
@ Returns: r0
ptTilt_A4:
    push {r4 - r10, lr}
    
    mov r0, #I2C_Address
    mov r1, #X_HI
    bl COMPASSACCELERO_IO_Read

    sxtb r0, r0


    pop {r4 - r10, lr}
    bx lr


    .size add_test, .-add_test @@ - symbol size (not strictly required, but makes the debugger happy)


    .end
    Things past the end directive are not processed, as you can see here.