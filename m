From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Thu, 04 Sep 2014 14:02:26 +0000
Subject: [PATCH v3 0/4] Initial r8a7794/Alt support
Message-Id: <1409839350-1245-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

This is a rebased version of v2 requested by Magnus with the parts that are
supposed to go through Simon's tree.  It also splits board and SoC DT into
two patches.

CU
Uli


Changes since v2:
- dropped bindings stuff
- split SoC and board DT into two patches

Changes since v1:
- removed loadaddr
- added init_late method to DT_MACHINE_START
- removed board file
- renamed serial10 to serial0 because we're not popular enough to be
  different
- reordered patches according to dependencies


Ulrich Hecht (4):
  ARM: shmobile: support Cortex-A7 in shmobile_init_delay()
  ARM: shmobile: Initial r8a7794 SoC support
  ARM: shmobile: Initial r8a7794 SoC device tree
  ARM: shmobile: Initial Alt board device tree

 arch/arm/boot/dts/Makefile                |   3 +-
 arch/arm/boot/dts/r8a7794-alt.dts         |  47 +++
 arch/arm/boot/dts/r8a7794.dtsi            | 531 ++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/Kconfig            |   4 +
 arch/arm/mach-shmobile/Makefile           |   1 +
 arch/arm/mach-shmobile/setup-r8a7794.c    |  35 ++
 arch/arm/mach-shmobile/timer.c            |   9 +-
 include/dt-bindings/clock/r8a7794-clock.h |  82 +++++
 8 files changed, 707 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/boot/dts/r8a7794-alt.dts
 create mode 100644 arch/arm/boot/dts/r8a7794.dtsi
 create mode 100644 arch/arm/mach-shmobile/setup-r8a7794.c
 create mode 100644 include/dt-bindings/clock/r8a7794-clock.h

-- 
1.8.4.5

