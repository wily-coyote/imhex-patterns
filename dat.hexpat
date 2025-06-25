#pragma description Moorhuhn X XXL .dat file

// This pattern can write to the filesystem
// #define ALSO_WRITE

#include <std/io.pat>
#include <std/mem.pat>
#include <std/string.pat>
#include <std/file.pat>

fn writeFile(str name, str data){
    std::file::Handle hFile = std::file::open(std::format("datOutput/{}", name), std::file::Mode::Create);
    std::file::write(hFile, data);
    std::file::close(hFile);
};

struct File {
    char filename[0x30] [[static]];
    u32 offset [[static]];
    u32 size [[static]];
    padding[8] [[static]];
    #ifdef ALSO_WRITE
    char data[size] @ offset [[sealed]];
    writeFile(this.filename, this.data);
    #endif
    #ifndef ALSO_WRITE
    u8 data[size] @ offset [[sealed]];
    #endif
};

$ = 0x0;
u32 count = 0;
while(true){
    File file @ $;
    $ += sizeof(file);
    count+=1;
    if(std::string::starts_with(file.filename, "****")){
        break;
    }
}
$ = 0x0;

File files[count] @ 0x0;

for(u32 i=0, i<count, i+=1){
    builtin::hex::core::add_virtual_file(files[i].filename, files[i].data);
}
