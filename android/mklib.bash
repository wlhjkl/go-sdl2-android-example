#!/usr/bin/env bash

if [ -z "$1" ]; then
  echo "Usage: mklib.bash [arm|arm64|x86|x86_64]"
  exit 1
fi

case "$1" in 
    arm)

    if [ -z "$ANDROID_TOOLCHAIN_ARM" ]; then
      echo "You must define ANDROID_TOOLCHAIN_ARM before starting. It should point to directory where you have installed arm toolchain."
      exit 1
    fi

    export PATH=$ANDROID_TOOLCHAIN_ARM/bin:${PATH}

    export CC=arm-linux-androideabi-gcc
    export CXX=arm-linux-androideabi-g++
    export PKG_CONFIG_PATH=$ANDROID_TOOLCHAIN_ARM/lib/pkgconfig
    export PKG_CONFIG_LIBDIR=$ANDROID_TOOLCHAIN_ARM/lib/pkgconfig

    CGO_CFLAGS="-I$ANDROID_TOOLCHAIN_ARM/include/SDL2" \
    CGO_LDFLAGS="-L$ANDROID_TOOLCHAIN_ARM/lib -L$ANDROID_TOOLCHAIN_ARM/sysroot/usr/lib" \
    GOOS=android GOARCH=arm GOARM=7 CGO_ENABLED=1 \
    ${GOROOT}/bin/go build -v -x -buildmode=c-shared -ldflags="-s -w" -o=jni/src/armeabi-v7a/libexample.so github.com/gen2brain/go-sdl2-android-example/example

    ;;

    arm64)

    if [ -z "$ANDROID_TOOLCHAIN_ARM64" ]; then
      echo "You must define ANDROID_TOOLCHAIN_ARM64 before starting. It should point to directory where you have installed arm64 toolchain."
      exit 1
    fi

    export PATH=$ANDROID_TOOLCHAIN_ARM64/bin:${PATH}

    export CC=aarch64-linux-android-gcc
    export CXX=aarch64-linux-android-gcc
    export PKG_CONFIG_PATH=$ANDROID_TOOLCHAIN_ARM64/lib/pkgconfig
    export PKG_CONFIG_LIBDIR=$ANDROID_TOOLCHAIN_ARM64/lib/pkgconfig

    CGO_CFLAGS="-I$ANDROID_TOOLCHAIN_ARM64/include/SDL2" \
    CGO_LDFLAGS="-L$ANDROID_TOOLCHAIN_ARM64/lib -L$ANDROID_TOOLCHAIN_ARM64/sysroot/usr/lib" \
    GOOS=android GOARCH=arm64 CGO_ENABLED=1 \
    ${GOROOT}/bin/go build -v -x -buildmode=c-shared -ldflags="-s -w" -o=jni/src/arm64-v8a/libexample.so github.com/gen2brain/go-sdl2-android-example/example

    ;;

    x86)

    if [ -z "$ANDROID_TOOLCHAIN_X86" ]; then
      echo "You must define ANDROID_TOOLCHAIN_ARM64 before starting. It should point to directory where you have installed x86 toolchain."
      exit 1
    fi

    export PATH=$ANDROID_TOOLCHAIN_X86/bin:${PATH}

    export CC=i686-linux-android-gcc
    export CXX=i686-linux-android-gcc
    export PKG_CONFIG_PATH=$ANDROID_TOOLCHAIN_X86/lib/pkgconfig
    export PKG_CONFIG_LIBDIR=$ANDROID_TOOLCHAIN_X86/lib/pkgconfig

    CGO_CFLAGS="-I$ANDROID_TOOLCHAIN_X86/include/SDL2" \
    CGO_LDFLAGS="-L$ANDROID_TOOLCHAIN_X86/lib -L$ANDROID_TOOLCHAIN_X86/sysroot/usr/lib" \
    GOOS=android GOARCH=386 CGO_ENABLED=1 \
    ${GOROOT}/bin/go build -v -x -buildmode=c-shared -ldflags="-s -w" -o=jni/src/x86/libexample.so github.com/gen2brain/go-sdl2-android-example/example

    ;;

    x86_64)

    if [ -z "$ANDROID_TOOLCHAIN_X86_64" ]; then
      echo "You must define ANDROID_TOOLCHAIN_ARM64 before starting. It should point to directory where you have installed x86 toolchain."
      exit 1
    fi

    export PATH=$ANDROID_TOOLCHAIN_X86_64/bin:${PATH}

    export CC=x86_64-linux-android-gcc
    export CXX=x86_64-linux-android-gcc
    export PKG_CONFIG_PATH=$ANDROID_TOOLCHAIN_X86_64/lib/pkgconfig
    export PKG_CONFIG_LIBDIR=$ANDROID_TOOLCHAIN_X86_64/lib/pkgconfig

    CGO_CFLAGS="-I$ANDROID_TOOLCHAIN_X86_64/include/SDL2" \
    CGO_LDFLAGS="-L$ANDROID_TOOLCHAIN_X86_64/lib -L$ANDROID_TOOLCHAIN_X86_64/sysroot/usr/lib" \
    GOOS=android GOARCH=amd64 CGO_ENABLED=1 \
    ${GOROOT}/bin/go build -v -x -buildmode=c-shared -ldflags="-s -w" -o=jni/src/x86_64/libexample.so github.com/gen2brain/go-sdl2-android-example/example

    ;;

esac