#include <type/magic.pat>
#include <std/mem.pat>

// M.U.G.E.N SND file

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
    u8 data[cbData];
    $ = bNextFile;
};

sndheader_t header @ 0x0;
sndfile_t firstFile[while(std::mem::read_unsigned($, 4) != 0x0000)] @ header.bFirstFile;