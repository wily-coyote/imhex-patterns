#pragma description M.U.G.E.N SND file
#pragma magic [ 45 6C 65 63 62 79 74 65 53 6E 64 00 ] @ 0x00

#include <type/magic.pat>
#include <std/mem.pat>

struct sndheader_t{
    type::Magic<"ElecbyteSnd\0">;
    u16 verhi;
    u16 verlo;
    u32 cFile;
    u32 bFirstFile;
    char reserved[488];
} [[static]];

struct sndfile_t{
    u32 bNextFile;
    u32 cbData;
    u32 dwGroup;
    u32 dwItem;
    u8 data[cbData] [[sealed]];
    $ = bNextFile;
    builtin::hex::core::add_virtual_file(std::format("{}-{}.wav", dwGroup, dwItem), data);
};

sndheader_t header @ 0x0;
sndfile_t firstFile[while(std::mem::read_unsigned($, 4) != 0x0000)] @ header.bFirstFile;
