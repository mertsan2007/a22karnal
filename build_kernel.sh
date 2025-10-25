#!/bin/bash

export CROSS_COMPILE=/home/vigus/zyc-clang/bin/aarch64-linux-gnu-
export LD=/home/vigus/zyc-clang/bin/ld.lld
export OBJCOPY=/home/vigus/zyc-clang/bin/llvm-objcopy
export AS=/home/vigus/zyc-clang/bin/llvm-as
export NM=/home/vigus/zyc-clang/bin/llvm-nm
export STRIP=/home/vigus/zyc-clang/bin/llvm-strip
export OBJDUMP=/home/vigus/zyc-clang/bin/llvm-objdump
export READELF=/home/vigus/zyc-clang/bin/llvm-readelf
export CC=/home/vigus/zyc-clang/bin/clang
export CROSS_COMPILE_ARM32=/home/vigus/zyc-clang/bin/arm-linux-gnueabi-
export ARCH=arm64
export ANDROID_MAJOR_VERSION=r

export KCFLAGS=' -w -pipe -O3'
export KCPPFLAGS=' -O3'
export CONFIG_SECTION_MISMATCH_WARN_ONLY=y

make -C $(pwd) O=$(pwd)/out KCFLAGS=' -w -pipe -O3' CONFIG_SECTION_MISMATCH_WARN_ONLY=y clean -j$(nproc) && make -C $(pwd) O=$(pwd)/out KCFLAGS='-w -O3' CONFIG_SECTION_MISMATCH_WARN_ONLY=y mrproper -j$(nproc)
clear
make -C $(pwd) O=$(pwd)/out KCFLAGS=' -w -pipe -O3' CONFIG_SECTION_MISMATCH_WARN_ONLY=y -j$(nproc) a22_sukisu_defconfig
make -C $(pwd) O=$(pwd)/out KCFLAGS=' -w -pipe -O3' CONFIG_SECTION_MISMATCH_WARN_ONLY=y -j$(nproc)

to copy all the kernel modules (.ko) to "modules" folder.
mkdir -p modules
find . -type f -name "*.ko" -exec cp -n {} modules \;
echo "Module files copied to the 'modules' folder."

cp out/arch/arm64/boot/Image $(pwd)/arch/arm64/boot/Image
cp out/arch/arm64/boot/Image ~/Downloads/buildkernal/
