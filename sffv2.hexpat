#pragma description M.U.G.E.N Sprite File Format v2 file
#pragma magic [ 45 6C 65 63 62 79 74 65 53 70 72 00 ?? ?? ?? 02] @ 0x00

#include <std/mem.pat>
#include <type/magic.pat>
#include <std/bit.pat>

// Version 2 is more advanced, storing pixels
// directly using compression algorithms

struct sffversion_t {
    u8 verlo3;    
    u8 verlo2;
    u8 verlo;
    u8 verhi;
    u32 reserved1;
    u32 reserved2;
} [[static]];

enum spritefmt_t : u8 {
    Raw = 0,
    Invalid = 1,
    RLE8 = 2,
    RLE5 = 3,
    LZ5 = 4,
    PNG8 = 10,
    PNG24 = 11,
    PNG32 = 12
};

struct sffv2_t{
    type::Magic<"ElecbyteSpr\0">;
    sffversion_t vVersion;
    sffversion_t vCompat;
    u32 bFirstSprite;
    u32 cSprite;
    u32 bFirstPalette;
    u32 cPalette;
    u32 bLData;
    u32 cbLData;
    u32 bTData;
    u32 cbTData;
    u32 reserved5;
    u32 reserved6;
    char reserved7[436];
} [[static]];

bitfield spriteflag_t{
    translate: 1;
    padding: 15;
};

struct palette_t{
    u16 iGroup;
    u16 iItem;
    u16 cColor;
    u16 iLinked;
    u32 bData;
    u32 cbData;
    u8 palData[cbData] @ header.bLData + bData [[sealed]];
};

struct sprite_t{
    u16 iGroup;
    u16 iItem;
    u16 wWidth;
    u16 wHeight;
    s16 wAxisX;
    s16 wAxisY;
    u16 linkIdx;
    spritefmt_t sfFormat;
    u8 coldepth;
    u32 bData;
    u32 cbData;
    u16 iPalette;
    spriteflag_t sfFlags;
    if(sfFlags.translate){
        u8 data[cbData] @ header.bTData + bData [[sealed]];
    } else {
        u8 data[cbData] @ header.bLData + bData [[sealed]];
    }
};

sffv2_t header @ 0x0;
palette_t palettes[header.cPalette] @ header.bFirstPalette;
sprite_t sprites[header.cSprite] @ header.bFirstSprite;
