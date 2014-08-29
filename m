From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Fri, 29 Aug 2014 18:15:04 +0000
Subject: [PATCH v2 0/6] Initial r8a7794/Alt support
Message-Id: <1409336110-32734-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

Here's the E2 support again, with all the suggestions worked in. See below
for details.

CU
Uli


Changes since v1:
- removed loadaddr
- added init_late method to DT_MACHINE_START
- removed board file
- renamed serial10 to serial0 because we're not popular enough to be
  different
- reordered patches according to dependencies


Ulrich Hecht (6):
  ARM: shmobile: support Cortex-A7 in shmobile_init_delay()
  ARM: shmobile: Initial r8a7794 SoC support
  ARM: shmobile: Initial r8a7794 and Alt device tree
  ARM: shmobile: r8a7794: document MSTP clock support
  ARM: shmobile: r8a7794: document SCIF clock support
  ARM: shmobile: r8a7794: document CPG clock support

 .../bindings/clock/renesas,cpg-mstp-clocks.txt     |   1 +
 .../clock/renesas,rcar-gen2-cpg-clocks.txt         |   1 +
 .../bindings/serial/renesas,sci-serial.txt         |   4 +
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/r8a7794-alt.dts                  |  47 ++
 arch/arm/boot/dts/r8a7794.dtsi                     | 531 +++++++++++++++++++++
 arch/arm/mach-shmobile/Kconfig                     |   4 +
 arch/arm/mach-shmobile/Makefile                    |   1 +
 arch/arm/mach-shmobile/setup-r8a7794.c             |  35 ++
 arch/arm/mach-shmobile/timer.c                     |   9 +-
 include/dt-bindings/clock/r8a7794-clock.h          |  82 ++++
 11 files changed, 713 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/boot/dts/r8a7794-alt.dts
 create mode 100644 arch/arm/boot/dts/r8a7794.dtsi
 create mode 100644 arch/arm/mach-shmobile/setup-r8a7794.c
 create mode 100644 include/dt-bindings/clock/r8a7794-clock.h

-- 
1.8.4.5

