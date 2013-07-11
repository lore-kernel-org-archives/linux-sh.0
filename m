From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 11 Jul 2013 08:24:03 +0000
Subject: [PATCH 0/11] ARM: shmobile: setup cleanup / r8a7778 update
Message-Id: <87oba9fqsg.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

These patches are
 1 - 6 : r8a7778 cleanup patches
 7 - 8 : r8a7779 cleanup patches
 9     : BockW DT reference
 A - B : BockW USB Func support

I talked with Magnus about current setup-r8a7778 code style
and ARM/shmobile future work.
Now, ARM/shmobile aims to support DT,
and the C code base board support will be removed in the future.

The current r8a7778 driver registration method which needs platform data
and which is not shared complicates codes,
and these will be removed if DT support was completed.
So, these drivers are registered on board code.

OTOH, driver which doesn't need platform data at the time of
registration can be registerd on SoC.

So, 1st 1 - 8 patches cleanup current r8a7778/r8a7779 code.
9 - B patches are based on these cleanup patches

Kuninori Morimoto (11):
      1) ARM: shmobile: r8a7778: cleanup registration of sh_eth
      2) ARM: shmobile: r8a7778: cleanup registration of mmcif
      3) ARM: shmobile: r8a7778: cleanup registration of usb phy
      4) ARM: shmobile: r8a7778: cleanup registration of sdhi
      5) ARM: shmobile: r8a7778: cleanup registration of i2c
      6) ARM: shmobile: r8a7778: cleanup registration of hspi
      7) ARM: shmobile: r8a7779: cleanup registration of usb phy
      8) ARM: shmobile: r8a7779: cleanup registration of sh_eth
      9) ARM: shmobile: bockw: add DT reference
      A) ARM: shmobile: r8a7778: add usb phy power control function
      B) ARM: shmobile: bockw: add USB Function support

 arch/arm/boot/dts/Makefile                     |    1 +
 arch/arm/boot/dts/r8a7778-bockw-reference.dts  |   32 ++++++
 arch/arm/mach-shmobile/Kconfig                 |   14 +++
 arch/arm/mach-shmobile/Makefile                |    1 +
 arch/arm/mach-shmobile/Makefile.boot           |    1 +
 arch/arm/mach-shmobile/board-bockw-reference.c |   62 +++++++++++
 arch/arm/mach-shmobile/board-bockw.c           |  136 ++++++++++++++++++++++--
 arch/arm/mach-shmobile/board-marzen.c          |   24 ++++-
 arch/arm/mach-shmobile/clock-r8a7778.c         |    1 +
 arch/arm/mach-shmobile/include/mach/r8a7778.h  |   14 +--
 arch/arm/mach-shmobile/include/mach/r8a7779.h  |    3 -
 arch/arm/mach-shmobile/setup-r8a7778.c         |  115 +++++++-------------
 arch/arm/mach-shmobile/setup-r8a7779.c         |   37 -------
 13 files changed, 302 insertions(+), 139 deletions(-)
