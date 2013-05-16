From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 16 May 2013 07:05:15 +0000
Subject: ARM: shmobile: r8a7778/bockw: add I2C/HSPI/MMC support
Message-Id: <87li7fwgk8.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

These patches add I2C/HSPI/MMC support to r8a7778/BockW/defconfig
I know Sergei is posting I2C patch for r8a7778, but it seems depend on USB patch,
and it still isn't applied on Simon's tree.
This I2C doesn't depend on USB.

These patches are based on renesas-next-20130513 tag

MMC patch needs Guennadi's
[PATCH] mmc: mmcif: don't clear masked interrupts

I sent SPI fixup patch to SPI ML several month ago,
but I didn't get result about it.
So, I added it on top of these patch set

MTD needs new ID setting on driver.
It was posted to LinuxML too.

1) - 2) are no SH patch
3) - 5) are pfc patches
6) - 8) are r8a7778 patches
9) - b) are bockw patches
c) - e) are defconfig patches

Kuninori Morimoto (14):
      1) spi: hspi: fixup long delay time
      2) mtd: m25p80: add support for the Spansion s25fl008k chip
      3) sh-pfc: r8a7778: add I2C pin groups
      4) sh-pfc: r8a7778: add HSPI pin groups
      5) sh-pfc: r8a7778: add MMCIF pin groups
      6) ARM: shmobile: r8a7778: add I2C support
      7) ARM: shmobile: r8a7778: add HSPI support
      8) ARM: shmobile: r8a7778: add MMCIF support
      9) ARM: shmobile: bockw: add I2C device support
      a) ARM: shmobile: bockw: add SPI FLASH support
      b) ARM: shmobile: bockw: add MMCIF support
      c) ARM: shmobile: bockw defconfig: add RTC RX8581 support
      d) ARM: shmobile: bockw defconfig: add M25P80 support
      e) ARM: shmobile: bockw defconfig: add MMCIF support

 arch/arm/configs/bockw_defconfig              |   11 ++
 arch/arm/mach-shmobile/board-bockw.c          |   80 +++++++++++++
 arch/arm/mach-shmobile/clock-r8a7778.c        |   23 +++-
 arch/arm/mach-shmobile/include/mach/r8a7778.h |    5 +
 arch/arm/mach-shmobile/setup-r8a7778.c        |   61 ++++++++++
 drivers/mtd/devices/m25p80.c                  |    1 +
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c          |  154 +++++++++++++++++++++++++
 drivers/spi/spi-sh-hspi.c                     |    2 +-
 8 files changed, 335 insertions(+), 2 deletions(-)


Best regards
---
Kuninori Morimoto
