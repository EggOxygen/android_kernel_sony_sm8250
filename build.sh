#!/bin/bash

mkdir -p out

GCC_PATH=/run/media/bbn/7b433792-2537-4661-97dd-14052ca9b4b9/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu/bin
CLANG_PATH=/run/media/bbn/7b433792-2537-4661-97dd-14052ca9b4b9/LineageOS/prebuilts/clang/host/linux-x86/clang-r353983c1/bin

BUILD_CROSS_COMPILE=${GCC_PATH}/aarch64-linux-gnu-
CLANG_TRIPLE=aarch64-linux-gnu-

DEFCONFIG=kona-bbn_defconfig

# export KBUILD_DIFFCONFIG=pdx203_j_diffconfig
export PATH=${CLANG_PATH}:${PATH}

if [[ -n "$1" ]]
then
    make -j16 -C $(pwd) O=$(pwd)/out ARCH=arm64 \
        CC=clang CLANG_TRIPLE=aarch64-linux-gnu- \
        CROSS_COMPILE=$BUILD_CROSS_COMPILE $1
else
    make -j16 -C $(pwd) O=$(pwd)/out ARCH=arm64 \
        CC=clang CLANG_TRIPLE=aarch64-linux-gnu- \
        CROSS_COMPILE=$BUILD_CROSS_COMPILE ${DEFCONFIG}

    make -j16 -C $(pwd) O=$(pwd)/out ARCH=arm64 \
        CC=clang CLANG_TRIPLE=aarch64-linux-gnu- \
        CROSS_COMPILE=$BUILD_CROSS_COMPILE 2>&1 | tee build.txt
fi 
# cp out/arch/arm64/boot/Image $(pwd)/boot.img-zImage
