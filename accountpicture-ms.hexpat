#pragma description Windows 8+ account picture file
#pragma magic [ ?? 31 53 50 53 18 B0 8B 0B 25 27 44 4B 92 BA 79 33 AE ]

// Ref: https://www.bilibili.com/opus/487940690358510578

struct SUBFILE {
	u8 unk1;
		// 1st file: 0xB2
		// 2nd file: 0x00

	u8 unk2;
		// 1st file: 0xDD
		// 2nd file: 0x00

	u8 unk3;
		// 1st file: 0xE7
		// 2nd file: 0x00

	u32 size;
		// 1st file: cbData + 56
		// 2nd file: cbData + 54
	
	u32 unk4;
		// 1st file: 0x4
		// 2nd file: 0x3
	
	padding[1];
	
	u32 unk5; // Both files: 0x42
	
	u32 cbName;
	u8 wszName[cbName];
	
	padding[2];
	
	u32 cbData;
	u8 szData[cbData];
};

struct ACCOUNTPICTURE {
	u32 cbAfterThisField; // filesize - 4
	u32 cbAfterThisFieldAgain; // filesize - 8
	
	u8 szSignatureProbably[17]; // Same in every file

	SUBFILE sbFirst;
	SUBFILE sbSecond;
};

ACCOUNTPICTURE ac @ 0x0;
