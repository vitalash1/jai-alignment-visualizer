# jai-alignment-visualizer
Jai alignment visualizer

Use `jai a.jai` to get some compile time prints.

For more information, if you add an `#align 16;` directive, you should also add an `@align=16` note right after, like this  
`linear_quadratic_radius: Vector3 = .{0.7,1.8,25} #align 16; @align=16`  
This will make the printout look like this  
`Byte 32: linear_quadratic_radius #align 16                      32 % 16 == 00`  
Instead of  
`Byte 32: linear_quadratic_radius`

### Example 1.
```
A :: struct
{
    y : u8;
    x : u32;
};

A_nopadding :: struct
{
    y : u8;
    x : u32;
}#no_padding;

B :: struct
{
    x : u32;
    y : u8;
};

B_nopadding :: struct
{
    x : u32;
    y : u8;
}#no_padding;
```
```
-----------------------
size_of(A) == 8
 y 0->1
 x 4->8
Byte 0: y
Byte 1:
Byte 2:
Byte 3:
Byte 4: x
Byte 5: x
Byte 6: x
Byte 7: x
-----------------------
size_of(A_nopadding) == 8
 y 0->1
 x 4->8
Byte 0: y
Byte 1:
Byte 2:
Byte 3:
Byte 4: x
Byte 5: x
Byte 6: x
Byte 7: x
-----------------------
<-<-<-<->->->->->
-----------------------
size_of(B) == 8
 x 0->4
 y 4->5
Byte 0: x
Byte 1: x
Byte 2: x
Byte 3: x
Byte 4: y
Byte 5:
Byte 6:
Byte 7:
-----------------------
size_of(B_nopadding) == 5
 x 0->4
 y 4->5
Byte 0: x
Byte 1: x
Byte 2: x
Byte 3: x
Byte 4: y
```


### Example 2.
```
LightPacket :: struct
{
    position: Vector3 = .{1,1,1} #align 16; @align=16
    color: Vector3 = .{1,1,1} #align 16; @align=16
    linear_quadratic_radius: Vector3 = .{0.7,1.8,25} #align 16; @align=16
}

LightPacket_Align12 :: struct
{
    position: Vector3 = .{1,1,1} #align 16; @align=16
    color: Vector3 = .{1,1,1} #align 16; @align=16
    linear_quadratic_radius: Vector3 = .{0.7,1.8,25} #align 12; @align=12
}
```
```
-----------------------
size_of(LightPacket) == 48
 position 0->12
 color 16->28
 linear_quadratic_radius 32->44
Byte 0: position #align 16                                      00 % 16 == 00
Byte 1: position #align 16                                      01 % 16 == 01
Byte 2: position #align 16                                      02 % 16 == 02
Byte 3: position #align 16                                      03 % 16 == 03
Byte 4: position #align 16                                      04 % 16 == 04
Byte 5: position #align 16                                      05 % 16 == 05
Byte 6: position #align 16                                      06 % 16 == 06
Byte 7: position #align 16                                      07 % 16 == 07
Byte 8: position #align 16                                      08 % 16 == 08
Byte 9: position #align 16                                      09 % 16 == 09
Byte 10: position #align 16                                     10 % 16 == 10
Byte 11: position #align 16                                     11 % 16 == 11
Byte 12:
Byte 13:
Byte 14:
Byte 15:
Byte 16: color #align 16                                        16 % 16 == 00
Byte 17: color #align 16                                        17 % 16 == 01
Byte 18: color #align 16                                        18 % 16 == 02
Byte 19: color #align 16                                        19 % 16 == 03
Byte 20: color #align 16                                        20 % 16 == 04
Byte 21: color #align 16                                        21 % 16 == 05
Byte 22: color #align 16                                        22 % 16 == 06
Byte 23: color #align 16                                        23 % 16 == 07
Byte 24: color #align 16                                        24 % 16 == 08
Byte 25: color #align 16                                        25 % 16 == 09
Byte 26: color #align 16                                        26 % 16 == 10
Byte 27: color #align 16                                        27 % 16 == 11
Byte 28:
Byte 29:
Byte 30:
Byte 31:
Byte 32: linear_quadratic_radius #align 16                      32 % 16 == 00
Byte 33: linear_quadratic_radius #align 16                      33 % 16 == 01
Byte 34: linear_quadratic_radius #align 16                      34 % 16 == 02
Byte 35: linear_quadratic_radius #align 16                      35 % 16 == 03
Byte 36: linear_quadratic_radius #align 16                      36 % 16 == 04
Byte 37: linear_quadratic_radius #align 16                      37 % 16 == 05
Byte 38: linear_quadratic_radius #align 16                      38 % 16 == 06
Byte 39: linear_quadratic_radius #align 16                      39 % 16 == 07
Byte 40: linear_quadratic_radius #align 16                      40 % 16 == 08
Byte 41: linear_quadratic_radius #align 16                      41 % 16 == 09
Byte 42: linear_quadratic_radius #align 16                      42 % 16 == 10
Byte 43: linear_quadratic_radius #align 16                      43 % 16 == 11
Byte 44:
Byte 45:
Byte 46:
Byte 47:
-----------------------
size_of(LightPacket_Align12) == 48
 position 0->12
 color 16->28
 linear_quadratic_radius 36->48
Byte 0: position #align 16                                      00 % 16 == 00
Byte 1: position #align 16                                      01 % 16 == 01
Byte 2: position #align 16                                      02 % 16 == 02
Byte 3: position #align 16                                      03 % 16 == 03
Byte 4: position #align 16                                      04 % 16 == 04
Byte 5: position #align 16                                      05 % 16 == 05
Byte 6: position #align 16                                      06 % 16 == 06
Byte 7: position #align 16                                      07 % 16 == 07
Byte 8: position #align 16                                      08 % 16 == 08
Byte 9: position #align 16                                      09 % 16 == 09
Byte 10: position #align 16                                     10 % 16 == 10
Byte 11: position #align 16                                     11 % 16 == 11
Byte 12:
Byte 13:
Byte 14:
Byte 15:
Byte 16: color #align 16                                        16 % 16 == 00
Byte 17: color #align 16                                        17 % 16 == 01
Byte 18: color #align 16                                        18 % 16 == 02
Byte 19: color #align 16                                        19 % 16 == 03
Byte 20: color #align 16                                        20 % 16 == 04
Byte 21: color #align 16                                        21 % 16 == 05
Byte 22: color #align 16                                        22 % 16 == 06
Byte 23: color #align 16                                        23 % 16 == 07
Byte 24: color #align 16                                        24 % 16 == 08
Byte 25: color #align 16                                        25 % 16 == 09
Byte 26: color #align 16                                        26 % 16 == 10
Byte 27: color #align 16                                        27 % 16 == 11
Byte 28:
Byte 29:
Byte 30:
Byte 31:
Byte 32:
Byte 33:
Byte 34:
Byte 35:
Byte 36: linear_quadratic_radius #align 12                      36 % 12 == 00
Byte 37: linear_quadratic_radius #align 12                      37 % 12 == 01
Byte 38: linear_quadratic_radius #align 12                      38 % 12 == 02
Byte 39: linear_quadratic_radius #align 12                      39 % 12 == 03
Byte 40: linear_quadratic_radius #align 12                      40 % 12 == 04
Byte 41: linear_quadratic_radius #align 12                      41 % 12 == 05
Byte 42: linear_quadratic_radius #align 12                      42 % 12 == 06
Byte 43: linear_quadratic_radius #align 12                      43 % 12 == 07
Byte 44: linear_quadratic_radius #align 12                      44 % 12 == 08
Byte 45: linear_quadratic_radius #align 12                      45 % 12 == 09
Byte 46: linear_quadratic_radius #align 12                      46 % 12 == 10
Byte 47: linear_quadratic_radius #align 12                      47 % 12 == 11
```
