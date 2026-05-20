# Project Guidelines — IronMan.Core (PAOD PUBG DMA)

## Project Overview

This is a **Windows x64 C++17** project that implements a DMA-based PUBG memory reading overlay. It uses a kernel DMA (Direct Memory Access) device to read game memory from **TslGame.exe** and renders an ImGui overlay via DirectX 11.

- **Solution**: `IronMan.Core.sln`
- **Language**: C++17 (`stdcpp17`)
- **Platform**: x64 only
- **Toolchain**: Visual Studio 2022 (v143)
- **Target**: Windows Application (DLL injection via `DllMain` or standalone EXE via `WinMain`)

## Code Style

### Namespaces
- Project root namespace: `IronMan`
- Core runtime: `IronMan::Core`
- SDK/Unreal Engine objects: `IronMan::Core::SDK`
- Math utilities: `IronMan::Math`

### Type Aliases
```cpp
using ptr_t = uint64_t;    // Pointer-sized integer (DMA address)
using module_t = ptr_t;    // Module base address
```

### Naming Conventions
| Pattern | Example | Usage |
|---------|---------|-------|
| `PascalCase` | `DMAHandler`, `PatternData`, `CConfig` | Classes, structs, enums |
| `camelCase` | `g_PatternData`, `m_Data`, `offset_UWorld` | Variables, member fields |
| `m_` prefix | `m_MemAddr`, `m_Buffer` | Class member variables |
| `g_` prefix | `g_PatternData`, `g_expireDate` | Global variables |
| `offset_` prefix | `offset_UWorld`, `offset_Actor_Owner` | Unreal Engine memory offsets |
| `fn` prefix | `fnProcessEvent`, `fnLineTraceSingle` | Function pointers |
| `decrypt`/`encry` prefix | `decryptUWorld`, `encryAActors` | Decryption/encryption function pointers |
| `SETUPVALUE(s)` → `HASH(s)` | `SETUPVALUE("espHuman")` | Config hash-based key setup |
| `CONSOLE_INFO2(...)` | Chinese string literals | Console logging macro |

### Header Guards
Use `#pragma once` (never `#ifndef` guards).

### Include Order
1. `"Include/WinHeaders.hpp"` (precompiled header / platform headers)
2. Project headers from `Core/`, `Helper/`, etc.
3. SDK headers from `Core/SDK/`
4. Third-party headers from `ThirdParty/`
5. Standard library headers
6. `#pragma comment(lib, ...)` for linker directives

## Architecture

```
Main.cpp / WinMain / DllMain
  └─ IronMan::Core::Initialize(imageBase)
       ├─ Console::Attach()                     — Debug console
       ├─ Config / FilePak                      — Load settings & resources
       ├─ DirectX11::Initialize                 — Create overlay window + DX11 device
       ├─ ImGui_Init                            — Setup ImGui for overlay rendering
       ├─ DMAHandler::Initialize                — Attach VMM / DMA device
       ├─ PatternLoader::SetupOffset            — Load game offset patterns (HTTP or local)
       ├─ sdk::Initialize / sdk::updateHandle   — Enumerate UE objects
       ├─ UpdateThread / ResourceThread          — Background threads
       └─ Main loop: MessagePump → Render → ImGui_NewFrame → Menu/Drawing → Present
```

### Key Modules

| Module | Path | Responsibility |
|--------|------|----------------|
| **Core** | `Core/Core.cpp` | Bootstrap, resource loading, main loop |
| **DMAHandler** | `Core/DMA/DMAHandler.h/cpp` | Wraps leechcore/VMM for DMA process attach & memory read/write |
| **PatternLoader** | `Core/PatternLoader.h/cpp` | Stores PUBG offset struct `PatternData`, loads from HTTP or config |
| **SDK** | `Core/SDK/` | UE object scanning (`ObjectsStore`, `ObjectManager`), property accessors |
| **DirectX** | `Core/DirectX/` | DX11 overlay engine, drawing primitives |
| **ImGui** | `Core/Imgui/`, `Core/DirectX/Imgui_dx11.cpp`, `Imgui_win32.cpp` | UI framework integration |
| **Visuals** | `Core/Visuals.cpp/h` | ESP rendering, aim assist, player/item/vehicle drawing |
| **Menu** | `Core/Menu.cpp/h` | In-game configuration menu |
| **Config** | `Core/Config.cpp/h` | Hash-key based config system, save/load to JSON |
| **FilePak** | `Core/FilePak.cpp/h` | Encrypted/compressed resource package loading |
| **Auth** | `Core/Auth.cpp/h` | License/expiration check |
| **DriverControl** | `Core/DriverControl.cpp/h` | Kernel driver load/unload |
| **Item/Weapon/Vehicle Mgr** | `Core/ItemManager.*`, `Core/SkinWeaponManager.*`, `Core/HandWeaponManager.*`, `Core/VehicleManager.*` | Game item databases |
| **PhysicsManager** | `Core/PhysicsManager/` | PhysX raycast/world query |
| **Helper** | `Helper/` | Analysis, Asm (JIT helpers), HttpLib, Misc utilities |
| **Math** | `Core/Math/` | Math utilities, Matrix/Vector types |

### Threading Model
- **Bootstrap thread** (`Bootstarp`): Calls `Core::Initialize`, blocks on message loop
- **UpdateThread**: `sdk::updateHandle()` — refreshes UE object list, pattern data
- **VEH-based threads** (Vectored Exception Handler): `UpdateViewPortVEH`, `UpdateSelfPlayerVEH`, `UpdateRadarToServerVEH` — timer-driven inline hook callbacks
- **ResHandle/ResourceThread**: Loads external resources

## Build & Debug

### Configurations
| Configuration | Description |
|---------------|-------------|
| `Release|x64` | Release build (no console) |
| `Release_Console|x64` | Release with debug console |
| `Release_Debug|x64` | Debug build with console |

### Build Commands
```powershell
# Via MSBuild (from Developer Command Prompt)
msbuild IronMan.Core.sln /p:Configuration=Release|x64 /p:Platform=x64

# Via Visual Studio
# Open IronMan.Core.sln → Build → Build Solution (Ctrl+Shift+B)
```

### Precompiled Header
- **Create**: `Include/WinHeaders.cpp` (PCH creator)
- **Usage**: Most `.cpp` files include `"Include/WinHeaders.hpp"` first

### External Dependencies (prebuilt .lib)
| Library | Purpose |
|---------|---------|
| `vmm.lib` / `leechcore.lib` | DMA/VMM kernel access |
| `PhysX3_x64.lib` (+ variants) | Physics simulation |
| `VMProtectSDK64.lib` | Code obfuscation / protection |
| `Zydis.lib` / `Zydisd.lib` | x86/x64 disassembler |
| `libcrypto.lib` / `libssl.lib` | OpenSSL crypto |
| `Dbghelp.lib` | Windows debug helpers |

## Conventions

### UE Property Access Pattern
Use `MAKE_*_PROPERTY` macros from `Include/Macro.hpp` to define UE property accessors:
```cpp
MAKE_OBJECT_PROPERTY(ptr_t, PlayerName, 0xAE2351A3, 0x310);
// Expands to GetPlayerName(), SGetPlayerName(), etc.
// Property is accessed via DMA scatter read with hash-based encryption
```

### Config Setup Pattern
In `Core/Config.cpp`, use `SetupValue` with hashed keys:
```cpp
SetupValue(Vars.espHuman.Enable, true, SETUPVALUE("espHuman"), SETUPVALUE("Enable"));
// SETUPVALUE(s) → HASH(s) — compile-time string hashing
```

### Pattern Data (Offsets)
All game offsets live in `Core/PatternLoader.h` as `PatternData` struct.
Naming: `offset_<UE_Type>_<Field>` or descriptive name.
Loaded from HTTP server or fallback config in `GetPatternFromHost()`.
See `https://github.com/DreamyDuck/PUBG-DMA-offset` for reference offsets.

### Scatter Read Pattern
Use scatter reads for batch memory access:
```cpp
GetDMA().Read<type>(address);
// For scatter: build ScatterStruct array, then read batch
```

### DMA Access
All DMA read/write goes through `DMAHandler` (singleton via `GetDMA()`).
Handle process attach/detach lifecycle. Refresh handles after game restart.

### Console Logging
```cpp
CONSOLE_INFO2(u8"中文日志信息");     // Info level (supports UTF-8)
CONSOLE_ERROR(u8"错误信息");         // Error level
```

### VEH Threads
Use Vectored Exception Handler for timer-driven execution in hooked regions:
```cpp
static void UpdateViewPortVEH();    // Called via VEH hook
static DWORD UpdateViewPort(LPVOID Param);  // Thread version
```

### Third-Party Libraries
- **AsmJit**: Runtime x86/x64 code generation (in `ThirdParty/AsmJit/`)
- **Zydis**: x86/x64 instruction decoder (in `ThirdParty/Zydis/`)
- **rapidjson**: JSON parsing (in `ThirdParty/rapidjson/`)
- **cpplinq**: LINQ-style query operators for C++ (in `ThirdParty/cpplinq.hpp`)
- **stb_image**: Image loading (in `ThirdParty/stb_image.h`)
- **httplib**: HTTP client (in `Helper/HttpLib/httplib.h`)
