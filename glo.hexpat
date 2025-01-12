#define ALSO_WRITE

// Blast-Thru GLO file
// This pattern can write to the filesystem

#include <std/io.pat>
#include <std/file.pat>
#include <std/string.pat>

struct glofile_t{
    u32 cbName;
    char sName[cbName];
    u32 bData;
    u32 cbData;
    #ifdef ALSO_WRITE
    char data[cbData] @ bData [[sealed]];
    writeFile(this.sName, this.data);
    #endif
    #ifndef ALSO_WRITE
    u8 data[cbData] @ bData [[sealed]];
    builtin::hex::core::add_virtual_file(sName, data);
    #endif
};

struct glo_t {
    u32 cFile;
    glofile_t rgFile[cFile];
};

fn writeFile(str name, str data){
    std::file::Handle hFile = std::file::open(std::format("gloOutput/{}", name), std::file::Mode::Create);
    std::file::write(hFile, data);
    std::file::close(hFile);
};

glo_t glo @ 0x0;
