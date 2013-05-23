From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 23 May 2013 03:13:27 +0000
Subject: Re: ARM: shmobile: r8a7778/bockw: add I2C/HSPI/MMC support
Message-Id: <87d2si4cdn.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87li7fwgk8.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87li7fwgk8.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

These patches are v2 of I2C/HSPI/MMC support for r8a7778/BockW/defconfig

These patches are based on renesas-next-20130523 tag

I sent SPI/MTD update patch to SPI/Linux ML before,
but I didn't get any result about it.
So, I added it on top of these patch set

1) - 2) are not SH patch but needed
3) - 5) are pfc patches
6) - 8) are r8a7778 patches
9) - b) are bockw patches
c) - e) are defconfig patches
f) - h) are tidyup cleanup patches

Kuninori Morimoto (17):
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
      f) ARM: shmobile: r8a7778: add __initdata on resource and device data
      g) ARM: shmobile: r8a7790: add __initdata on resource and device data
      h) ARM: shmobile: r8a7778: rename sdhi device additional function

 arch/arm/configs/bockw_defconfig              |   11 ++
 arch/arm/mach-shmobile/board-bockw.c          |   82 ++++++++++++-
 arch/arm/mach-shmobile/clock-r8a7778.c        |   23 +++-
 arch/arm/mach-shmobile/include/mach/r8a7778.h |    7 +-
 arch/arm/mach-shmobile/setup-r8a7778.c        |   85 ++++++++++++--
 arch/arm/mach-shmobile/setup-r8a7790.c        |   12 +-
 drivers/mtd/devices/m25p80.c                  |    1 +
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c          |  153 +++++++++++++++++++++++++
 drivers/spi/spi-sh-hspi.c                     |    2 +-
 9 files changed, 354 insertions(+), 22 deletions(-)
