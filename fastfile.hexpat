#pragma description Microsoft FASTFILE, used in FOXBEAR
// Ref: MSDN 6.0

// This pattern can write to the filesystem
#define ALSO_WRITE

#include <hex/core.pat>
#ifdef ALSO_WRITE
#define DATA_TYPE char
#include <std/file.pat>
#endif
#ifndef ALSO_WRITE
#define DATA_TYPE u8
#endif

u32 cnt = 0;

struct File {
    u32 offset [[static]];
    char name[13] [[static]];
    u32 next_offset [[no_unique_address]];
    if(parent.count-1 > cnt){
        DATA_TYPE data[(next_offset - offset)] @ offset [[sealed]];
        #ifdef ALSO_WRITE
        std::file::Handle hFile = std::file::open(name, std::file::Mode::Create);
        std::file::write(hFile, data);
        std::file::close(hFile);
        #endif
        #ifndef ALSO_WRITE
        hex::core::add_virtual_file(name, data);
        #endif
    }
    cnt = cnt + 1;
};

struct FastFile {
    u32 count;
    File files[count];
    
};

FastFile ff @ 0x0;
