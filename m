From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Wed, 11 Jul 2012 21:38:36 +0000
Subject: ARM / mach-shmobile v3.6 pull requests preparation
Message-Id: <201207112338.36939.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi all,

The window for sending me new material targeted at v3.6, except for fixes,
is now over.  All new non-fix patches sent to me from now on will be queued up
for v3.7, although they won't appear anywhere in the tree until the v3.6 merge
window is over.

The material prepared for v3.6 pull requests in located in the 'soc' and
'board' branches of the renesas.git tree.  The 'next' branch of that tree
contains the final merge result (which in fact is equivalent to the 'board'
branch).  Please double check if those branches don't introduce bugs.

Appended is a summary of the changes in the 'next' (or 'board') branch.

Thanks,
Rafael


---
 arch/arm/boot/dts/r8a7740.dtsi                     |  21 +
 arch/arm/boot/dts/sh7377.dtsi                      |  21 +
 arch/arm/configs/armadillo800eva_defconfig         |  25 +-
 arch/arm/configs/kzm9d_defconfig                   |  89 ++++
 arch/arm/configs/kzm9g_defconfig                   |   8 +-
 arch/arm/mach-shmobile/Kconfig                     |  13 +
 arch/arm/mach-shmobile/Makefile                    |   2 +
 arch/arm/mach-shmobile/board-ag5evm.c              |  82 +++-
 arch/arm/mach-shmobile/board-ap4evb.c              |  62 +--
 arch/arm/mach-shmobile/board-armadillo800eva.c     | 455 ++++++++++++++++++++-
 arch/arm/mach-shmobile/board-bonito.c              |  10 +
 arch/arm/mach-shmobile/board-g4evm.c               |  52 ++-
 arch/arm/mach-shmobile/board-kota2.c               |  30 ++
 arch/arm/mach-shmobile/board-kzm9d.c               |  10 +
 arch/arm/mach-shmobile/board-kzm9g.c               | 320 +++++++++++++++
 arch/arm/mach-shmobile/board-mackerel.c            |  83 ++--
 arch/arm/mach-shmobile/board-marzen.c              |  10 +
 arch/arm/mach-shmobile/clock-r8a7740.c             | 150 ++++++-
 arch/arm/mach-shmobile/clock-r8a7779.c             |   2 +-
 arch/arm/mach-shmobile/clock-sh7367.c              |   2 +-
 arch/arm/mach-shmobile/clock-sh7372.c              |   2 +-
 arch/arm/mach-shmobile/clock-sh7377.c              |   2 +-
 arch/arm/mach-shmobile/clock-sh73a0.c              |  12 +-
 arch/arm/mach-shmobile/include/mach/common.h       |   1 +
 arch/arm/mach-shmobile/include/mach/dma-register.h |  84 ++++
 arch/arm/mach-shmobile/include/mach/gpio.h         |  32 ++
 arch/arm/mach-shmobile/include/mach/pm-rmobile.h   |  44 ++
 arch/arm/mach-shmobile/include/mach/r8a7740.h      |  33 +-
 arch/arm/mach-shmobile/include/mach/sh7372.h       |  45 +-
 arch/arm/mach-shmobile/include/mach/sh73a0.h       |   7 +
 arch/arm/mach-shmobile/intc-r8a7740.c              |  13 +-
 arch/arm/mach-shmobile/pfc-r8a7740.c               |  24 +-
 arch/arm/mach-shmobile/pm-r8a7740.c                |  54 +++
 arch/arm/mach-shmobile/pm-rmobile.c                | 167 ++++++++
 arch/arm/mach-shmobile/pm-sh7372.c                 | 297 ++++----------
 arch/arm/mach-shmobile/setup-r8a7740.c             | 360 ++++++++++++++++
 arch/arm/mach-shmobile/setup-sh7372.c              | 209 ++++------
 arch/arm/mach-shmobile/setup-sh7377.c              |  47 +++
 arch/arm/mach-shmobile/setup-sh73a0.c              | 152 +++++--
 drivers/regulator/fixed-helper.c                   |  19 +-
 include/linux/regulator/fixed.h                    |  11 +-
 41 files changed, 2517 insertions(+), 545 deletions(-)

---------------

Guennadi Liakhovetski (14):
      regulator: support multiple dummy fixed regulators
      regulator: extend the fixed dummy voltage regulator to accept voltage
      ARM: mach-shmobile: add 3.3V and 1.8V fixed regulators to mackerel
      ARM: mach-shmobile: add fixed voltage regulators to ag5evm
      ARM: mach-shmobile: add fixed voltage regulators to ap4evb
      ARM: mach-shmobile: add fixed voltage regulators to armadillo800eva
      ARM: mach-shmobile: add fixed voltage regulators to bonito
      ARM: mach-shmobile: add fixed voltage regulators to g4evm
      ARM: mach-shmobile: add fixed voltage regulators to kota2
      ARM: mach-shmobile: add fixed voltage regulators to kzm9d
      ARM: mach-shmobile: add fixed voltage regulators to kzm9g
      ARM: mach-shmobile: add fixed voltage regulators to marzen
      ARM: mach-shmobile: add SDHI2 to the 2.8V fixed regulator consumers on kzm9g
      ARM: mach-shmobile: select the fixed regulator driver on several boards

Kuninori Morimoto (47):
      ARM: shmobile: r8a7740: add HDMI interrupt support
      ARM: shmobile: r8a7740: add HDMI clock support
      ARM: shmobile: r8a7740: add HDMI GPIO support
      ARM: shmobile: r8a7740: add MERAM work-around
      ARM: shmobile: r8a7740: add CEU clock support
      ARM: shmobile: r8a7740: add FSI parent clock support
      ARM: shmobile: r8a7740: add FSI-B (for HDMI) GPIO support
      ARM: shmobile: armadillo800eva: enable HDMI
      ARM: shmobile: sh73a0: add FSI clock
      ARM: shmobile: kzm9g: enable FSI-AK4648
      ARM: shmobile: armadillo800eva: enable camera
      ARM: shmobile: sh7372: remove unused sh7372_a3sp_init() on !CONFIG_PM
      ARM: shmobile: add common extra gpio functions
      ARM: shmobile: add common DMAEngine definitions
      ARM: shmobile: r8a7740: add DMAEngine support for FSI
      ARM: shmobile: r8a7740: add DMAEngine support for SDHI
      ARM: shmobile: r8a7740: add DMAEngine support for USB
      ARM: shmobile: use common DMAEngine definitions on r8a7740
      ARM: shmobile: sh73a0: add USB clock support
      ARM: shmobile: sh73a0: add DMAEngine support for MPDMAC
      ARM: shmobile: use common DMAEngine definitions on sh73a0
      ARM: shmobile: use common DMAEngine definitions on sh7372
      ARM: shmobile: armadillo800eva: enable FSI-WM8978 sound
      ARM: shmobile: armadillo800eva: enable FSI-HDMI sound
      ARM: shmobile: armadillo800eva: enable DMAEngine on FSI
      ARM: shmobile: armadillo800eva: enable DMAEngine on SDHI
      ARM: shmobile: armadillo800eva: enable DMAEngine on USB
      ARM: shmobile: use common extra gpio functions on armadillo800eva
      ARM: shmobile: kzm9g: enable USB function
      ARM: shmobile: kzm9g: enable MicroSD
      ARM: shmobile: kzm9g: enable DMAEngine on FSI
      ARM: shmobile: kzm9g: enable DMAEngine on MMCIF
      ARM: shmobile: use common extra gpio functions on Mackerel
      ARM: shmobile: use common extra gpio functions on ap4evb
      ARM: shmobile: use common extra gpio functions on g4evm
      ARM: shmobile: soc-core: add R-mobile PM domain common APIs
      ARM: shmobile: r8a7740: fixup: MSEL1CR 7bit control
      ARM: shmobile: r8a7740: add A4S pm domain support
      ARM: shmobile: r8a7740: add A3SP pm domain support
      ARM: shmobile: r8a7740: add A4LC pm domain support
      ARM: shmobile: armadillo800eva: USB Func enables external IRQ mode
      ARM: shmobile: armadillo800eva: A4LC domain includes LCDC
      ARM: shmobile: armadillo800eva: A3SP domain includes USB
      ARM: shmobile: sh7372: add pm-rmobile domain support
      ARM: shmobile: mackerel: switch to using pm-rmobile API
      ARM: shmobile: ap4evb: switch to using pm-rmobile API
      ARM: shmobile: sh7372: completely switch over to using pm-rmobile API

Magnus Damm (6):
      ARM: shmobile: Use INTCA with sh7372 A3SM power domain
      ARM: shmobile: sh7372 A3SM CPUIdle support
      ARM: mach-shmobile: kzm9d: Add defconfig
      ARM: mach-shmobile: r8a7740 generic board support via DT
      ARM: mach-shmobile: sh7377 generic board support via DT
      ARM: shmobile: Take cpuidle dependencies into account correctly

Nobuhiro Iwamatsu (1):
      ARM: mach-shmobile: Convert sh_clk_mstp32_register to sh_clk_mstp_register

Rafael J. Wysocki (1):
      ARM: shmobile: Fix build problem in pm-sh7372.c for unusual .config

Simon Horman (2):
      ARM: mach-shmobile: armadillo800eva: defconfig Allow use of armhf userspace
      ARM: shmobile: kzm9g: defconfig enable INOTIFY_USER

Tetsuyuki Kobayashi (1):
      ARM: shmobile: kzm9g: Support Real Time Clock

