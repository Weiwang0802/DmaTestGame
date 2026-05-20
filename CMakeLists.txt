cmake_minimum_required(VERSION 3.20)
project(IronMan.Core
    VERSION 1.0.0
    LANGUAGES CXX
)

# ─── Custom build configurations ────────────────────────────────────────────
set(CMAKE_CONFIGURATION_TYPES "Release;Release_Console;Release_Debug" CACHE STRING "" FORCE)

# ─── C++ Standard ────────────────────────────────────────────────────────────
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# ─── Static MSVC runtime (all configs) ──────────────────────────────────────
set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")

# ─── Target ──────────────────────────────────────────────────────────────────
add_executable(IronMan.Core-DMANo1 WIN32)

# ─── Precompiled Header ─────────────────────────────────────────────────────
target_precompile_headers(IronMan.Core-DMANo1 PRIVATE
    "Include/WinHeaders.hpp"
)

# ─── Source Files ───────────────────────────────────────────────────────────
target_sources(IronMan.Core-DMANo1 PRIVATE
    # PCH creator
    "Include/WinHeaders.cpp"

    # Root
    "Main.cpp"
    "allocMem.cpp"
    "HijackExport.cpp"

    # Core
    "Core/Core.cpp"
    "Core/Auth.cpp"
    "Core/Config.cpp"
    "Core/DriverControl.cpp"
    "Core/FilePak.cpp"
    "Core/HandWeaponManager.cpp"
    "Core/ItemManager.cpp"
    "Core/Menu.cpp"
    "Core/PatternLoader.cpp"
    "Core/SkinWeaponManager.cpp"
    "Core/VehicleManager.cpp"
    "Core/Visuals.cpp"

    # DirectX
    "Core/DirectX/DirectX11.cpp"
    "Core/DirectX/Drawing.cpp"
    "Core/DirectX/Imgui_dx11.cpp"
    "Core/DirectX/Imgui_win32.cpp"

    # DMA
    "Core/DMA/DMAHandler.cpp"

    # ImGui
    "Core/Imgui/imgui.cpp"
    "Core/Imgui/imgui_draw.cpp"
    "Core/Imgui/imgui_widgets.cpp"

    # Math
    "Core/Math/Math.cpp"

    # MouseController / KMBOX
    "Core/MouseController/KMBOX/KmboxNet.cpp"

    # PhysicsManager
    "Core/PhysicsManager/PhysicsManager.cpp"

    # SDK
    "Core/SDK/SDK.cpp"
    "Core/SDK/ObjectManager.cpp"
    "Core/SDK/ObjectsStore.cpp"
    "Core/SDK/UEncrypt.cpp"
    "Core/SDK/UnrealNames.cpp"
    "Core/SDK/CoreUObject/Class.cpp"
    "Core/SDK/CoreUObject/Object.cpp"

    # Helper / Analysis
    "Helper/Analysis/AnalysisBase.cpp"
    "Helper/Analysis/DecryptAnalysis.cpp"
    "Helper/Analysis/UObjectAnalysis.cpp"

    # Helper / Asm
    "Helper/Asm/AsmHelper64.cpp"

    # Helper / Misc
    "Helper/Misc/Console.cpp"
    "Helper/Misc/InitOnce.cpp"
    "Helper/Misc/JsonHelper.cpp"
    "Helper/Misc/ThreadMutex.cpp"
    "Helper/Misc/Utils.cpp"
    "Helper/Misc/ZydisWrapper.cpp"
)

# ─── ThirdParty Sources (NO precompiled header) ──────────────────────────────
target_sources(IronMan.Core-DMANo1 PRIVATE
    "ThirdParty/AsmJit/base/assembler.cpp"
    "ThirdParty/AsmJit/base/codegen.cpp"
    "ThirdParty/AsmJit/base/compiler.cpp"
    "ThirdParty/AsmJit/base/constpool.cpp"
    "ThirdParty/AsmJit/base/containers.cpp"
    "ThirdParty/AsmJit/base/context.cpp"
    "ThirdParty/AsmJit/base/cpuinfo.cpp"
    "ThirdParty/AsmJit/base/cputicks.cpp"
    "ThirdParty/AsmJit/base/error.cpp"
    "ThirdParty/AsmJit/base/globals.cpp"
    "ThirdParty/AsmJit/base/intutil.cpp"
    "ThirdParty/AsmJit/base/logger.cpp"
    "ThirdParty/AsmJit/base/operand.cpp"
    "ThirdParty/AsmJit/base/runtime.cpp"
    "ThirdParty/AsmJit/base/string.cpp"
    "ThirdParty/AsmJit/base/vmem.cpp"
    "ThirdParty/AsmJit/base/zone.cpp"
    "ThirdParty/AsmJit/x86/x86assembler.cpp"
    "ThirdParty/AsmJit/x86/x86compiler.cpp"
    "ThirdParty/AsmJit/x86/x86context.cpp"
    "ThirdParty/AsmJit/x86/x86cpuinfo.cpp"
    "ThirdParty/AsmJit/x86/x86inst.cpp"
    "ThirdParty/AsmJit/x86/x86operand.cpp"
    "ThirdParty/AsmJit/x86/x86operand_regs.cpp"
    "ThirdParty/AsmJit/x86/x86scheduler.cpp"
)

# Mark ThirdParty sources as NOT using the precompiled header
set_source_files_properties(
    "ThirdParty/AsmJit/base/assembler.cpp"
    "ThirdParty/AsmJit/base/codegen.cpp"
    "ThirdParty/AsmJit/base/compiler.cpp"
    "ThirdParty/AsmJit/base/constpool.cpp"
    "ThirdParty/AsmJit/base/containers.cpp"
    "ThirdParty/AsmJit/base/context.cpp"
    "ThirdParty/AsmJit/base/cpuinfo.cpp"
    "ThirdParty/AsmJit/base/cputicks.cpp"
    "ThirdParty/AsmJit/base/error.cpp"
    "ThirdParty/AsmJit/base/globals.cpp"
    "ThirdParty/AsmJit/base/intutil.cpp"
    "ThirdParty/AsmJit/base/logger.cpp"
    "ThirdParty/AsmJit/base/operand.cpp"
    "ThirdParty/AsmJit/base/runtime.cpp"
    "ThirdParty/AsmJit/base/string.cpp"
    "ThirdParty/AsmJit/base/vmem.cpp"
    "ThirdParty/AsmJit/base/zone.cpp"
    "ThirdParty/AsmJit/x86/x86assembler.cpp"
    "ThirdParty/AsmJit/x86/x86compiler.cpp"
    "ThirdParty/AsmJit/x86/x86context.cpp"
    "ThirdParty/AsmJit/x86/x86cpuinfo.cpp"
    "ThirdParty/AsmJit/x86/x86inst.cpp"
    "ThirdParty/AsmJit/x86/x86operand.cpp"
    "ThirdParty/AsmJit/x86/x86operand_regs.cpp"
    "ThirdParty/AsmJit/x86/x86scheduler.cpp"
    PROPERTY SKIP_PRECOMPILE_HEADERS ON
)

# ─── Include Directories ────────────────────────────────────────────────────
target_include_directories(IronMan.Core-DMANo1 PRIVATE
    "${CMAKE_SOURCE_DIR}"
    "${CMAKE_SOURCE_DIR}/Core"
    "${CMAKE_SOURCE_DIR}/ThirdParty"
    "${CMAKE_SOURCE_DIR}/Include"
    "${CMAKE_SOURCE_DIR}/Include/OpenSSL-Win64/include"
    "${CMAKE_SOURCE_DIR}/Include/PxShared/include"
    "${CMAKE_SOURCE_DIR}/Include/PhysX_3.4/Include"
    "${CMAKE_SOURCE_DIR}/Include/PhysX_3.4/Include/characterkinematic"
    "${CMAKE_SOURCE_DIR}/Include/PhysX_3.4/Include/common"
    "${CMAKE_SOURCE_DIR}/Include/PhysX_3.4/Include/cooking"
    "${CMAKE_SOURCE_DIR}/Include/PhysX_3.4/Include/extensions"
    "${CMAKE_SOURCE_DIR}/Include/PhysX_3.4/Include/foundation"
    "${CMAKE_SOURCE_DIR}/Include/PhysX_3.4/Include/geometry"
    "${CMAKE_SOURCE_DIR}/Include/PhysX_3.4/Include/pxtask"
    "${CMAKE_SOURCE_DIR}/Include/PhysX_3.4/Include/pvd"
    "${CMAKE_SOURCE_DIR}/Core/DMA/Include"
    "${CMAKE_SOURCE_DIR}/Helper/Misc"
    "${CMAKE_SOURCE_DIR}/Helper/Asm"
    "${CMAKE_SOURCE_DIR}/Helper/HttpLib"
    "${CMAKE_SOURCE_DIR}/Helper/Analysis"
)

# ─── Preprocessor Definitions ───────────────────────────────────────────────
target_compile_definitions(IronMan.Core-DMANo1 PRIVATE
    $<$<CONFIG:Release>:
        NOMINMAX
        NDEBUG
        ZYCORE_STATIC_DEFINE
        ZYDIS_STATIC_DEFINE
        U_STATIC_IMPLEMENTATION
        IRONMANCORE_EXPORTS
        _WINDOWS
        _USRDLL
        _CRT_SECURE_NO_WARNINGS
        _SILENCE_CXX17_ITERATOR_BASE_CLASS_DEPRECATION_WARNING
    >
    $<$<CONFIG:Release_Console>:
        NOMINMAX
        NDEBUG
        ZYCORE_STATIC_DEFINE
        ZYDIS_STATIC_DEFINE
        U_STATIC_IMPLEMENTATION
        IRONMANCORE_EXPORTS
        _WINDOWS
        _USRDLL
        ENABLE_CONSOLE
        _DISABLE_VECTOR_ANNOTATION
        PX_SUPPORT_PVD
    >
    $<$<CONFIG:Release_Debug>:
        NOMINMAX
        NDEBUG
        ZYCORE_STATIC_DEFINE
        ZYDIS_STATIC_DEFINE
        U_STATIC_IMPLEMENTATION
        IRONMANCORE_EXPORTS
        _WINDOWS
        _USRDLL
        _CRT_SECURE_NO_WARNINGS
        _SILENCE_CXX17_ITERATOR_BASE_CLASS_DEPRECATION_WARNING
    >
)

# ─── Compiler Flags ─────────────────────────────────────────────────────────
target_compile_options(IronMan.Core-DMANo1 PRIVATE
    /W3
    /EHca                     # Async exception handling (C exceptions + C++)
    /fp:precise
    /GF                       # String pooling
    /MP                       # Multi-processor compilation
    /wd4307                   # Disable warning C4307
    /wd4530                   # Disable warning C4530
)

# Release config: optimize for speed
target_compile_options(IronMan.Core-DMANo1 PRIVATE
    $<$<CONFIG:Release>:/O2 /Oi /Ob2 /GS->
    $<$<CONFIG:Release>:/W0>   # Turn off all warnings in Release
)

# Release_Console config: debug-like for troubleshooting
target_compile_options(IronMan.Core-DMANo1 PRIVATE
    $<$<CONFIG:Release_Console>:/Od>
)

# Release_Debug config: debug-like
target_compile_options(IronMan.Core-DMANo1 PRIVATE
    $<$<CONFIG:Release_Debug>:/Od>
)

# ─── Linker Flags ───────────────────────────────────────────────────────────
target_link_options(IronMan.Core-DMANo1 PRIVATE
    /SUBSYSTEM:WINDOWS
    /INCREMENTAL:NO
    /DEBUG:FULL              # Generate PDB
    /OPT:REF                 # Remove unreferenced functions/data
    /OPT:ICF                 # Identical COMDAT folding
    /LTCG                    # Link-time code generation
    /SETCHECKSUM             # Set checksum in PE header
    /HEAPCOMMIT:16384        # Heap commit size
)

# ─── Library Paths ──────────────────────────────────────────────────────────
target_link_directories(IronMan.Core-DMANo1 PRIVATE
    "${CMAKE_SOURCE_DIR}/ThirdParty/Zydis/lib"
    "${CMAKE_SOURCE_DIR}/ThirdParty/Zycore/lib"
    "${CMAKE_SOURCE_DIR}/Core/DMA/Lib"
    "${CMAKE_SOURCE_DIR}/Include/OpenSSL-Win64/lib/VC/x64/MT"
    "${CMAKE_SOURCE_DIR}/Include/Lib"
)

# ─── Link Libraries ─────────────────────────────────────────────────────────
target_link_libraries(IronMan.Core-DMANo1 PRIVATE
    # DMA / VMM
    "${CMAKE_SOURCE_DIR}/Core/DMA/Lib/vmm.lib"
    "${CMAKE_SOURCE_DIR}/Core/DMA/Lib/leechcore.lib"

    # PhysX
    PhysX3_x64.lib
    PhysX3Common_x64.lib
    PhysX3Cooking_x64.lib
    PhysX3Extensions.lib
    PxFoundation_x64.lib
    PxPvdSDK_x64.lib
    PhysX3CharacterKinematic_x64.lib
    PhysX3Vehicle.lib

    # Zydis disassembler
    "${CMAKE_SOURCE_DIR}/ThirdParty/Zydis/lib/Zydis.lib"
    "${CMAKE_SOURCE_DIR}/ThirdParty/Zycore/lib/Zycore.lib"

    # OpenSSL
    libcrypto_static.lib
    libssl_static.lib

    # VMProtect (disabled — uncomment if needed)
    # VMProtectSDK64.lib

    # System
    OpenGL32.lib
    Dbghelp.lib
)

# ─── Output Name & Path ─────────────────────────────────────────────────────
set_target_properties(IronMan.Core-DMANo1 PROPERTIES
    OUTPUT_NAME "IronMan.Core-DMANo1"
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/bin/$<CONFIG>"
)

# Release_Console → Paod.exe
set_target_properties(IronMan.Core-DMANo1 PROPERTIES
    OUTPUT_NAME_Release_Console "Paod"
)

# Release → NeoDMA.exe
set_target_properties(IronMan.Core-DMANo1 PROPERTIES
    OUTPUT_NAME_Release "NeoDMA"
)

# Release_Debug → PaodDebug.exe
set_target_properties(IronMan.Core-DMANo1 PROPERTIES
    OUTPUT_NAME_Release_Debug "PaodDebug"
)

# ─── Post-Build: Copy to output dir ─────────────────────────────────────────
# (Disabled by default; uncomment and adjust paths as needed)
# install(TARGETS IronMan.Core-DMANo1 RUNTIME DESTINATION "C:/Users/Administrator/Documents/NeoDMA")

message(STATUS "IronMan.Core (PAOD PUBG DMA) CMake configuration loaded")
message(STATUS "  Configurations: Release | Release_Console | Release_Debug")
message(STATUS "  C++ Standard: C++17 (${CMAKE_CXX_STANDARD})")
message(STATUS "  Platform: Windows x64")
