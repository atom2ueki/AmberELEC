# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2020-present AmberELEC (https://github.com/AmberELEC)

PKG_NAME="vice"
PKG_VERSION="0bc7b589721998ac2c8bbe540e341257d943656c"
PKG_SHA256="bc97ee7e8780e6f35bc6fc58fddae10b149fdc3c4239e6dfafcb4760af8e70ab"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/vice-libretro"
PKG_URL="${PKG_SITE}/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Versatile Commodore 8-bit Emulator version 3.0"
PKG_TOOLCHAIN="make"

make_target() {
  if [ "${ARCH}" == "arm" ]; then
    CFLAGS="${CFLAGS} -DARM -DALIGN_DWORD -mstructure-size-boundary=32 -mthumb-interwork -falign-functions=16 -marm"
  fi
  if [ ! -d "built" ]
  then
    mkdir built
  fi
  for EMUTYPE in x128 x64sc x64dtv xscpu64 xplus4 xvic xcbm5x0 xcbm2 xpet x64
  do
    make clean
    make EMUTYPE=${EMUTYPE}
    mv vice_*_libretro.so built
  done
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp built/vice_x128_libretro.so ${INSTALL}/usr/lib/libretro/
  cp built/vice_x64_libretro.so ${INSTALL}/usr/lib/libretro/
  cp built/vice_xplus4_libretro.so ${INSTALL}/usr/lib/libretro/
  cp built/vice_xvic_libretro.so ${INSTALL}/usr/lib/libretro/
}
