#include <type/magic.pat>

// Quake PAK file
// Ref: https://quakewiki.org/wiki/.pak

struct File {
    char fileName[56];
    u32 fileOffset;
    u32 fileSize;
    u8 fileData[fileSize] @ fileOffset;
} [[static]];

struct PAK {
    type::Magic<"PACK">;
    u32 fileTableOffset;
    u32 fileTableSize;
    File entries[this.fileTableSize/56] @ this.fileTableOffset;
};

PAK pak @ 0x0;
