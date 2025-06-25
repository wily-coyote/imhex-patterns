#pragma description Elf Bowling GFX archive file

#include <std/string.pat>
#include <std/mem.pat>

struct FILE {
    char filename[0x100];
    if(!std::string::starts_with(filename, "< THIS IS THE END OF A GFX FILE >")){
        char unknown[0x100];
        char length[0x100];
        u8 data[std::string::parse_int(length, 10)] [[sealed]];
        char texname[0x100];
    }
};

FILE file[while(!std::mem::eof())] @ 0x00;
