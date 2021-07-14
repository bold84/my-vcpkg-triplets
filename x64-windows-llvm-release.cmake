set(VCPKG_TARGET_ARCHITECTURE x64)
set(VCPKG_LIBRARY_LINKAGE static)
set(VCPKG_CRT_LINKAGE dynamic)
if(NOT PORT MATCHES "(boost|hwloc|libpq|icu|harfbuzz|qt*)")
    set(VCPKG_CHAINLOAD_TOOLCHAIN_FILE "${CMAKE_CURRENT_LIST_DIR}/x64-windows-llvm.toolchain.cmake")
    if(DEFINED VCPKG_PLATFORM_TOOLSET)
        set(VCPKG_PLATFORM_TOOLSET ClangCL)
    endif()
    if (DEFINED ENV{ProgramW6432})
        file(TO_CMAKE_PATH "$ENV{ProgramW6432}" PROG_ROOT)
    else()
        file(TO_CMAKE_PATH "$ENV{PROGRAMFILES}" PROG_ROOT)
    endif()
    file(TO_CMAKE_PATH "${PROG_ROOT}/LLVM/bin" POSSIBLE_LLVM_BIN_DIR)
    if(EXISTS "${POSSIBLE_LLVM_BIN_DIR}")
        set(ENV{PATH} "${POSSIBLE_LLVM_BIN_DIR};$ENV{PATH}")
    endif()
elseif(PORT MATCHES "(benchmark|gtest)")
    # Cannot have LTO enabled in gtest or benchmark since this eliminates/remove main from (gtest|benchmark)_main
    set(VCPKG_CHAINLOAD_TOOLCHAIN_FILE "${CMAKE_CURRENT_LIST_DIR}/x64-windows-llvm.toolchain-no-lto.cmake")
    if(DEFINED VCPKG_PLATFORM_TOOLSET)
        set(VCPKG_PLATFORM_TOOLSET ClangCL)
    endif()
    if (DEFINED ENV{ProgramW6432})
        file(TO_CMAKE_PATH "$ENV{ProgramW6432}" PROG_ROOT)
    else()
        file(TO_CMAKE_PATH "$ENV{PROGRAMFILES}" PROG_ROOT)
    endif()
    file(TO_CMAKE_PATH "${PROG_ROOT}/LLVM/bin" POSSIBLE_LLVM_BIN_DIR)
    if(EXISTS "${POSSIBLE_LLVM_BIN_DIR}")
        set(ENV{PATH} "${POSSIBLE_LLVM_BIN_DIR};$ENV{PATH}")
    endif()
endif()



set(VCPKG_POLICY_SKIP_ARCHITECTURE_CHECK enabled)
set(VCPKG_POLICY_SKIP_DUMPBIN_CHECKS enabled)
set(VCPKG_LOAD_VCVARS_ENV ON)

set(VCPKG_C_FLAGS "-arch:AVX")
set(VCPKG_CXX_FLAGS "${VCPKG_C_FLAGS} -EHsc -GR")

set(VCPKG_BUILD_TYPE release)