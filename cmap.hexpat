#include <std/mem.pat>

// Longhorn .msstyles CMAP chunk
// Define POST for 4042 format, which has byte padding

// The CLASS's place in the file (0-indexed) is used
// in the properties of VARIANT chunks

#define POST

struct CLASS {
    char16 name[];
#ifdef POST
    std::mem::AlignTo<8>;
#endif
};

CLASS cmap[while(!std::mem::eof())] @ 0x0;
