#pragma description Minecraft XBOX 360 Edition PCK file
// Ref: https://team-lodestone.github.io/Legacy-Docs/Formats/PCK/
// Ref: https://aluigi.altervista.org/bms/minecraft_x360_pck.bms

// This doesn't work for some reason.
//
// I needed to put `be` hints in all the types
// for it to work.
#pragma endian big
#pragma magic [ 00 00 00 03 ] @ 0x00

#include <std/io.pat>
#include <std/string.pat>
#include <hex/core.pat>


u32 iFile = 0;
bool bXmlVersion = false;

struct String {
    //u32 cwData;
    //char16 data[cwData];
    be std::string::SizedString16<be u32> value;
    padding[4];
} [[sealed, format("format_string")]];

struct Name {
    be u32 index;
    String name;
    if(name.value == "XMLVERSION"){
        bXmlVersion = true;
    }
};

struct Prop {
    be u32 type [[format("prop_type")]];
    String value;
};

struct Entry {
    be u32 size;
    be u32 type;
    String name;
};

struct File {
    be u32 cProp;
    Prop rgProp[cProp];
    u8 data[parent.rgEntry[iFile].size] [[sealed]];
    builtin::hex::core::add_virtual_file(std::format("{}", parent.rgEntry[iFile].name), data);
    iFile += 1;
};

struct PCK {
    be u32 type;
    be u32 cName;
    Name rgName[cName];
    if(bXmlVersion == true){
        be u32 xmlVersion; // WHATEVER THIS IS
    }
    be u32 cEntry;
    Entry rgEntry[cEntry];
    File rgFile[cEntry];
} [[inline]];

fn format_string(String string){
    return string.value;
};

fn prop_type(u32 type){
    for(u32 i=0, i<pck.cName, i+=1){
        if(pck.rgName[i].index == type){
            return pck.rgName[i].name;
        }
    }
};

PCK pck @ 0x0;
