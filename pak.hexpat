#pragma description Quake PAK file
// Ref: https://quakewiki.org/wiki/.pak

#include <type/magic.pat>

struct File {
    char fileName[56];
    u32 fileOffset;
    u32 fileSize;
    u8 fileData[fileSize] @ fileOffset [[sealed]];
};

struct PAK {
    type::Magic<"PACK">;
    u32 fileTableOffset;
    u32 fileTableSize;
    File entries[this.fileTableSize/56] @ this.fileTableOffset;
};

PAK pak @ 0x0;
