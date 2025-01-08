#run {
    // run_test(LightPacket);
    // run_test(LightPacket_Align12);
    run_test(A);
    run_test(A_nopadding);
    print("-----------------------\n");
    print("<-<-<-<->->->->->\n");
    run_test(B);
    run_test(B_nopadding);
};

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
#import "Math";

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

// 
// 
// 

run_test :: ($struct_type : Type) {
    print("-----------------------\n");
    print("size_of(%) == %\n", struct_type, size_of(struct_type));

    MemberInfo :: struct {
        name : string;
        align : int = 0;
    }
    bytes : []MemberInfo;
    bytes.count = size_of(struct_type);
    allocation_size := size_of(MemberInfo)*bytes.count;
    bytes.data = alloc(allocation_size);
    assert(bytes.data != null);
    memset(dest = bytes.data, value = 0, count = allocation_size);

    for member : type_info(struct_type).members {
        start : int = member.offset_in_bytes;
        end : int = member.offset_in_bytes + member.type.runtime_size;
        align : int = 0;
        for note : member.notes {
            test :: "align=";
            if note.count >= test.count && string.{test.count, note.data} == test { // starts with "align="
                remainder : string = .{ note.count - test.count, note.data + test.count };
                align = string_to_int(remainder);
            }
        }
        for start .. end - 1 {
            bytes[it].name = member.name;
            bytes[it].align = align;
        }
        print(" % %->%\n", member.name, start, end);
    }
    for 0 .. size_of(struct_type) - 1 {
        align_str : string = ifx bytes[it].align then tprint(" #align %", bytes[it].align) else "";
        str := tprint("Byte %: %0%0", it, bytes[it].name, align_str);
        print(str);
        pad_next_info_to_spaces :: 64;
        for str.count .. pad_next_info_to_spaces - 1  print(" ");
        if(bytes[it].align != 0) {
            print("% %% % == %", FormatInt.{value=it,minimum_digits=2},
                                 FormatInt.{value=bytes[it].align,minimum_digits = 2},
                                 FormatInt.{value=it % bytes[it].align,minimum_digits = 2});
        }
        print("\n");
    }
}

#import "Basic";
main :: () {}
