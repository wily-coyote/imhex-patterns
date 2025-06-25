#pragma description Epsitec SA Smaky AUDIO collection
#pragma magic [ A0 00 00 00 ] @ 0x00
#pragma endian big

#include <std/mem.pat>

// audio files seem to be stored by unsigned 8-bit PCM,
// 1 byte per sample with 1 mono channel

struct Audio {
    padding[4];
    u16 size;
    u16 sample_rate;
    padding[8];
    
    // the name is 16 chars max with a null terminator
    char name[] [[no_unique_address]];
    padding[16];
    
    u8 data[size];
};

Audio files[while(!std::mem::eof())] @ 0x0;
