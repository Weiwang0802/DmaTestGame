#include "Include/WinHeaders.hpp"
#include "Auth.h"
#include "Helper/Misc/Utils.hpp"
#include "Helper/Misc/DynImport.hpp"
#include "Helper/Asm/AsmFactory.hpp"
#include "Core/DirectX/DirectX11.h"
#include "Core/DirectX/Drawing.h"
IronMan::ServerResult g_ServerResult = { 0 };
namespace IronMan::Core::Auth
{

	ULONGLONG ServerTime = 0ull;

	static unsigned char layoutBuffer[0x1000] = { 0 };
	static int errorCount = 0;

	typedef struct times
	{
		int Year;
		int Mon;
		int Day;
		int Hour;
		int Min;
		int Second;
	}Times;

	Times stamp_to_standard(int stampTime)
	{
		time_t tick = (time_t)stampTime;
		struct tm tm;
		char s[100];
		Times standard;

		tm = *localtime(&tick);
		strftime(s, sizeof(s), "%Y-%m-%d %H:%M:%S", &tm);
		//printf("%d: %s\n", (int)tick, s);

		standard.Year = atoi(s);
		standard.Mon = atoi(s + 5);
		standard.Day = atoi(s + 8);
		standard.Hour = atoi(s + 11);
		standard.Min = atoi(s + 14);
		standard.Second = atoi(s + 17);

		return standard;
	}

	bool Check(bool foreceCheck)
	{
		// [BYPASS] Always return true — expiration check disabled
		return true;
	}
}