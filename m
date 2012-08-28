From: kuninori.morimoto.gx@renesas.com
Date: Tue, 28 Aug 2012 01:58:21 +0000
Subject: [PATCH 0/8] ARM: shmobile: r8a7779/marzen/kzm9g patches for v3.7
Message-Id: <87mx1fdbgl.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon, Magnus, Paul, Rafael

These are r8a7779/marzen/kzm9g new feature patches for v3.7 (not v3.6-rcX).
These patches need subsystem branch merge.

Kuninori Morimoto (8):
      1) ARM: shmobile: r8a7779: PFC rename PENCx -> USB_PENCx
      2) ARM: shmobile: r8a7779: add USB common phy initializer
      3) ARM: shmobile: r8a7779: add USB EHCI clock support
      4) ARM: shmobile: r8a7779: add USB OHCI clock support
      5) ARM: shmobile: marzen: add USB EHCI driver support
      6) ARM: shmobile: marzen: add USB OHCI driver support
      7) ARM: shmobile: marzen: enable thermal sensor
      8) ARM: shmobile: kzm9g: use gpio-keys instead of gpio-keys-polled

 arch/arm/configs/marzen_defconfig             |   13 ++-
 arch/arm/mach-shmobile/Kconfig                |    2 +
 arch/arm/mach-shmobile/board-marzen.c         |  161 +++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-r8a7779.c        |    7 +
 arch/arm/mach-shmobile/include/mach/common.h  |    1 +
 arch/arm/mach-shmobile/include/mach/r8a7779.h |    2 +-
 arch/arm/mach-shmobile/pfc-r8a7779.c          |   16 ++--
 arch/arm/mach-shmobile/setup-r8a7779.c        |   93 ++++++++++++++
 8 files changed, 284 insertions(+), 11 deletions(-)

1) - 6) add EHCI/OHCI USB support to r8a7779/marzen board,
but these depend on this branch
   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git - usb-next

7) adds thermal support for marzen,
but it depends on this branch
    git://git.linaro.org/people/amitdanielk/linux.git - exynos_v6_thermal_tree

8) switch to use gpio-keys instead of gpio-keys-polled,
but it depends on this branch
    git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git - for-next

These are based on linus/master + above each branch + "Simon's defconfig patch"
