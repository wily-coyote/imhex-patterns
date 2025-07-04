#pragma description Crazy Drake .res file
#pragma magic [ 52 45 53 48 ] @ 0x00

struct file {
    char filename[40];
    u32 cbSize;
    u8 *data[cbSize] : u32;
};

struct RESH {
    u32 signature;
    u8 unk[21];
    u32 cItems;
    file files[cItems];
};

RESH resh @ 0x0;