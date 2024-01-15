stack_size equ 0x00000400
	area    stack,noinit,readwrite,align=3
stack_mem space stack_size
__initial_sp
    preserve8
    thumb
; Vector Table Mapped to Address 0 at Reset
    area reset,data,readonly
    export __Vectors
    export __Vectors_End
    export __Vectors_Size
	export Reset_Handler
	export __initial_sp


__Vectors dcd __initial_sp
          dcd Reset_Handler
__Vectors_End

__Vectors_Size equ  __Vectors_End - __Vectors

    area init,code,readonly


Reset_Handler
	b race

race
    ; r0 is index of element in time and dist arrays
    ; get the position of the element in the array
    ldr r1, =time
    ldr r2, =dist
    ldr r3, =1 ; product of all results
    ldr r4, =0 ; count of winning solutions in current race
    ldr r5, =0 ; duration of pressing the button (accelleration)
    b calc

nextrace
    add r1, r1, #4 ; increment index
    add r2, r2, #4 ; increment index
    ldr r4, [r1] ; load total time
    cmp r4, #0 ; if total time is 0, then we have reached the end of the array
    beq end ; end of program
    ldr r4, =0 ;
    ldr r5, =0 ;
    b calc

calc
    ldr r7, [r1] ; load total time
    sub r6, r7, r5 ; time left for sailing = total time - time spent on accelleration
    ; r5 is also the speed of the boat
    mul r7, r6, r5 ; distance sailed in the remaining time
    ldr r6, [r2] ; load distance to destination
    cmp r7, r6 ; compare distance sailed with distance to destination
    ; if the boat has reached the destination (r7 >= dist), r4 += 1
    addge r4, r4, #1
    add r5, r5, #1 ; increase speed by 1
    ldr r7, [r1] ; load total time
    cmp r5, r7 ; compare speed with total time
    ; if r5 >= r7, then multiply r3 with r4 and go to next race
    mulge r3, r3, r4
    bge nextrace
    b calc

end
    ldr r0, =result
    str r3, [r0]
    b here

here
	b here
	align
	area input, data, readonly
	align
time dcd  61,   70,   90,   66, 0
dist dcd 643, 1184, 1362, 1041, 0
    area output, data, readwrite
    align
result dcd 0x0
; B6 78 04 00 (Little Endian) -> 478B6 -> 293046
	end
