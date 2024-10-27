#include <std/math.pat>
#include <type/color.pat>

// Longhorn .msstyles VARIANT chunk
// Define POST for 4042 format, which has byte padding
// Ref: https://github.com/nptr/msstyleEditor/wiki/.msstyles-Format

#define POST

struct LOGFONTW {
    // MSVC LOGFONT structure
    s32 height;
    s32 width;
    s32 escapement;
    s32 orientation;
    s32 weight;
    s8 italic;
    s8 underline;
    s8 strikeOut;
    s8 charSet;
    s8 outPrecision;
    s8 clipPrecision;
    s8 quality;
    s8 pitchAndFamily;
    char16 faceName[32];
} [[static]];

struct GENERIC{
    u32 shortFlag;
    u32 reserved;
    u32 sizeInBytes;
    // Data
    match(parent.typeID){
        (201): char16 data[sizeInBytes/2]; // STRING
        (204): type::RGBA8 rgba; // COLOR
        (205): s32 margins[sizeInBytes/4]; // MARGINS
        (208): s16 position[sizeInBytes/2]; // POSITION
        (209): s32 rect[sizeInBytes/4]; // RECT
        (210): LOGFONTW font;
        (_): u8 data[sizeInBytes];
    }
};

struct FLAGGED{
    // May refer to a FILENAME or STRINGTABLE entry
    match(parent.typeID){
        (201): u32 string[3]; // STRING
        (206): u32 filename[3]; // FILENAME
        (210): u32 font[3]; // FONT
        (_):   u32 data[3];
    }
} [[static]];

struct PROPERTY{
    // Property header
    u32 nameID [[color("FFFFFF")]];
    u32 typeID;
    u32 classID; // Refers to a class in CMAP
    u32 partID;
    u32 stateID;
    u32 shortFlag [[no_unique_address,hidden]];
    if(shortFlag != 0){
        FLAGGED data;
    } else {
        GENERIC data;
    }
#ifdef POST
    std::mem::AlignTo<8>; // In 4042, properties are 8-aligned
#endif
};

PROPERTY propertyStream[while(!std::mem::eof())] @ 0x00;
