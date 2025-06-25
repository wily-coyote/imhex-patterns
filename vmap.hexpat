#pragma description Longhorn .msstyles VMAP chunk

// Define POST for 4042 file format, which has byte padding
#define POST

#include <std/math.pat>

struct VARIANT {
    u32 sz;
#ifdef POST
    char16 name[std::math::max(8, sz)];
    std::mem::AlignTo<4>; // VMAP name entries are minimum 16 bytes
#endif
#ifndef POST
    char16 name[sz];
#endif
};

VARIANT vmap[while(!std::mem::eof())] @ 0x0;
