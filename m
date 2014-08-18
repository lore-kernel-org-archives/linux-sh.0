From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Mon, 18 Aug 2014 15:51:39 +0000
Subject: [PATCH 0/8] Initial r8a7794/Alt support
Message-Id: <1408377107-3822-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

This is a minimal-plus-bureaucracy set to get the Alt board running on one
cylinder, derived from the Renesas BSP.  I have left the serial port at 38k4
because I seem to be unable to switch u-boot to anything else; "setenv
baudrate ..." does not work as advertised.

Should the board actually be called "reference", there not being any legacy
board support?

CU
Uli


Hisashi Nakamura (1):
  clk: shmobile: Add r8a7794 support

Ulrich Hecht (7):
  ARM: shmobile: Initial r8a7794 SoC support
  ARM: shmobile: Initial r8a7794 Alt board support
  ARM: shmobile: Initial r8a7794 and Alt device tree
  ARM: shmobile: support Cortex-A7 in shmobile_init_delay()
  ARM: shmobile: r8a7794: document MSTP clock support
  ARM: shmobile: r8a7794: document SCIF clock support
  ARM: shmobile: r8a7794: document CPG clock support

 .../bindings/clock/renesas,cpg-mstp-clocks.txt     |   1 +
 .../clock/renesas,rcar-gen2-cpg-clocks.txt         |   1 +
 .../bindings/serial/renesas,sci-serial.txt         |   4 +
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/r8a7794-alt.dts                  |  47 ++
 arch/arm/boot/dts/r8a7794.dtsi                     | 531 +++++++++++++++++++++
 arch/arm/mach-shmobile/Kconfig                     |   9 +
 arch/arm/mach-shmobile/Makefile                    |   2 +
 arch/arm/mach-shmobile/Makefile.boot               |   1 +
 arch/arm/mach-shmobile/board-alt-reference.c       |  38 ++
 arch/arm/mach-shmobile/setup-r8a7794.c             |  34 ++
 arch/arm/mach-shmobile/timer.c                     |   9 +-
 drivers/clk/shmobile/Makefile                      |   1 +
 include/dt-bindings/clock/r8a7794-clock.h          |  82 ++++
 14 files changed, 758 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/boot/dts/r8a7794-alt.dts
 create mode 100644 arch/arm/boot/dts/r8a7794.dtsi
 create mode 100644 arch/arm/mach-shmobile/board-alt-reference.c
 create mode 100644 arch/arm/mach-shmobile/setup-r8a7794.c
 create mode 100644 include/dt-bindings/clock/r8a7794-clock.h

-- 
1.8.4.5

