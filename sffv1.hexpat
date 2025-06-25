#pragma description M.U.G.E.N Sprite File Format v1 file
#pragma magic [ 45 6C 65 63 62 79 74 65 53 70 72 00 ] @ 0x00

#include <type/magic.pat>

// Version 1 of the spec is simply a collection of PCX files

struct pcx_t{
    type::Magic<"\x0a">;
    u8 version;
    u8 fRle;
    u8 cBits;
    s16 wMinX;
    s16 wMinY;
    s16 wMaxX;
    s16 wMaxY;
    u16 wDpiX;
    u16 wDpiY;
    u8 reserved;
    u8 cColorPlanes;
    u16 cbColorPlane;
    u16 wPalMode;
    u16 wSrcWidth;
    u16 wSrcHeight;
    u8 reserved2[54];
} [[static]];

struct sffversion_t {
    u8 verlo3;    
    u8 verlo2;
    u8 verlo;
    u8 verhi;
} [[static]];

struct sffv1_t{
    u32 cGroup;
    u32 cSprite;
    u32 bFirst;
    u32 cbSubheader;
    u8 fPalShared;
    u8 zero[3];
    u8 reserved[476];
} [[static]];

struct sffv1file_t{
    u32 bNext;
    u32 cbData;
    s16 wAxisX;
    s16 wAxisY;
    u16 iGroup;
    u16 iSprite;
    u16 iLinked;
    u8 fPalShared;
    u8 reserved[13];
    u8 data[cbData] [[sealed]];
    builtin::hex::core::add_virtual_file(std::format("{}-{}.pcx", iGroup, iSprite), data);
};

struct sff_t{
    type::Magic<"ElecbyteSpr\0">;
    sffversion_t version;
    sffv1_t header;
    sffv1file_t sprites[header.cSprite];
};

sff_t sff @ 0x0;
