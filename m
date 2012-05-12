From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sat, 12 May 2012 21:23:14 +0000
Subject: [GIT PULL] Renesas ARM-based platforms: new boards support for v3.5
Message-Id: <201205122323.14967.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201205122307.20590.rjw@sisk.pl>
In-Reply-To: <201205122307.20590.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

Please pull changes since commit d48b97b403d23f6df0b990cee652bdf9a52337a3

    Linux 3.4-rc6

with top-most commit a515be1ca7df947db0f6018a174f49507affcdbc

    Merge branch 'renesas-kzm9g' into renesas-board-new

from the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/renesas.git board-new

to receive updates of the Renesas ARM-based boards support code for v3.5.
Included are:

 * Support for the KZM-A9-GT board from Kuninori Morimoto.

 * Support for the armadillo800eva board from Kuninori Morimoto.

This is based on the Renesas core SoC code updates I've sent a separate pull
request for.

Thanks!


 arch/arm/configs/armadillo800eva_defconfig     |  142 +++++
 arch/arm/configs/kzm9g_defconfig               |  139 +++++
 arch/arm/mach-shmobile/Kconfig                 |   16 +-
 arch/arm/mach-shmobile/Makefile                |    2 +
 arch/arm/mach-shmobile/board-armadillo800eva.c |  778 ++++++++++++++++++++++++
 arch/arm/mach-shmobile/board-kzm9g.c           |  454 ++++++++++++++
 arch/arm/mach-shmobile/clock-r8a7740.c         |    3 +
 arch/arm/mach-shmobile/include/mach/sh73a0.h   |    3 +
 arch/arm/mach-shmobile/pfc-sh73a0.c            |    4 +-
 arch/arm/mach-shmobile/platsmp.c               |    2 +-
 arch/arm/mach-shmobile/setup-r8a7740.c         |    7 +
 11 files changed, 1545 insertions(+), 5 deletions(-)

---------------

Kuninori Morimoto (27):
      ARM: mach-shmobile: add armadillo800eva board support.
      ARM: mach-shmobile: armadillo800eva: add defconfig
      ARM: mach-shmobile: armadillo800eva: add support LCDC0
      ARM: mach-shmobile: armadillo800eva: add support gpio_key
      ARM: mach-shmobile: armadillo800eva: add support sh_eth
      ARM: mach-shmobile: armadillo800eva: add support ST1232
      ARM: mach-shmobile: armadillo800eva: add USB function support
      ARM: mach-shmobile: armadillo800eva: add SDHI0 support
      ARM: mach-shmobile: armadillo800eva: add SDHI1 support
      ARM: mach-shmobile: armadillo800eva: add MMCIF support
      ARM: mach-shmobile: r8a7740: reserve DMA memory for the frame buffer
      ARM: mach-shmobile: clock-r8a7740: add sh-eth clock
      ARM: mach-shmobile: armadillo800eva: defconfig update
      ARM: mach-shmobile: add KZM-A9-GT board support
      ARM: mach-shmobile: kzm9g: add defconfig
      ARM: mach-shmobile: kzm9g: add SMSC 9221 support
      ARM: mach-shmobile: kzm9g: add external USB Host support
      ARM: mach-shmobile: kzm9g: add LCDC support
      ARM: mach-shmobile: kzm9g: add ST1232 Touchscreen support
      ARM: mach-shmobile: pfc-sh73a0: fixup MSEL2CR MSEL18 for I2C-3
      ARM: mach-shmobile: sh73a0.h: add GPIO_NR
      ARM: mach-shmobile: kzm9g: correct screen direction
      ARM: mach-shmobile: kzm9g: add MMCIF support
      ARM: mach-shmobile: kzm9g: add SDHI support
      ARM: mach-shmobile: kzm9g: add PCF8757 gpio-key
      ARM: mach-shmobile: kzm9g: defconfig update
      ARM: mach-shmobile: kzm9g: enable SMP boot


