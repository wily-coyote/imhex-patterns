#include <std/mem.pat>
#include <type/magic.pat>
#include <type/color.pat>
#include <std/bit.pat>

// M.U.G.E.N Sprite File Format v2 file
// Version 2 is more advanced, storing pixels
// directly using compression algorithms

struct sffversion_t {
    u8 verlo3;    
    u8 verlo2;
    u8 verlo;
    u8 verhi;
} [[static]];

enum spritefmt_t : u8 {
    Raw,
    Invalid,
    RLE8,
    RLE5,
    LZ5
};

struct sffv2_t{
    type::Magic<"ElecbyteSpr\0">;
    sffversion_t vVersion;
    u32 reserved1;
    u32 reserved2;
    sffversion_t vCompat;
    u32 reserved3;
    u32 reserved4;
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
    type::RGBA8 palData[cbData/4] @ header.bLData + bData;
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
        u8 data[cbData] @ header.bTData + bData;
    } else {
        u8 data[cbData] @ header.bLData + bData;
    }
};

sffv2_t header @ 0x0;
palette_t palettes[header.cPalette] @ header.bFirstPalette;
sprite_t sprites[header.cSprite] @ header.bFirstSprite;
