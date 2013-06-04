From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 04 Jun 2013 05:06:04 +0000
Subject: [PATCH 0/6 v4] ARM: shmobile: r8a7778/bockw: add I2C/HSPI/MMC support
Message-Id: <87a9n65uti.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

> 1) - 2) are not SH patch but needed
> 3) - 5) are pfc patches
> 6) - 8) are r8a7778 patches
> 9) - b) are bockw patches
> c) - e) are defconfig patches
> f) - h) are tidyup cleanup patches

These patches are part of 6) - 8) v4 I2C/HSPI/MMC support for r8a7778.
I separated these into "clock support" and "driver support" patches.

These patches are based on renesas-next-20130528 tag

1) - 3) are clock support patches
4) - 6) are driver support patches

Kuninori Morimoto (6):
      1) ARM: shmobile: r8a7778: add support I2C clock
      2) ARM: shmobile: r8a7778: add support HSPI clock
      3) ARM: shmobile: r8a7778: add support MMC clock
      4) ARM: shmobile: r8a7778: add support I2C driver
      5) ARM: shmobile: r8a7778: add support HSPI driver
      6) ARM: shmobile: r8a7778: add support MMC driver

 arch/arm/mach-shmobile/clock-r8a7778.c        |   23 +++++++++-
 arch/arm/mach-shmobile/include/mach/r8a7778.h |    5 ++
 arch/arm/mach-shmobile/setup-r8a7778.c        |   61 +++++++++++++++++++++++++
 3 files changed, 88 insertions(+), 1 deletion(-)
