From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 05 Jul 2013 15:26:42 +0000
Subject: [PATCH v2 0/4] ARM: shmobile: APE6EVM: add a reference DT implementation
Message-Id: <1373038006-19973-1-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch series adds a DT-based APE6EVM platform implementation. The 
first of them prepares auxiliary device handling functions for the r8a73a4 
SoC, and the second one adds a the actual platform support.

Developed and tested on top of Simon's renesas.git next snapshot of
05.07.2013 plus my today's patch-set:

ARM: shmobile: DMAC, MMCIF and SDHI for H2 and APE6

Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Guennadi Liakhovetski (4):
  ARM: shmobile: r8a73a4: move cpufreq-cpu0 device registration into a
    function
  ARM: shmobile: APE6EVM: add DT reference
  ARM: shmobile: ape6evm-reference: add CPUFreq support
  ARM: shmobile: APE6EVM-reference: add ethernet support

 arch/arm/boot/dts/Makefile                       |    1 +
 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts  |   76 +++++++++++++++++++++
 arch/arm/mach-shmobile/Kconfig                   |   11 +++
 arch/arm/mach-shmobile/Makefile                  |    1 +
 arch/arm/mach-shmobile/Makefile.boot             |    1 +
 arch/arm/mach-shmobile/board-ape6evm-reference.c |   78 ++++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/r8a73a4.h    |    5 ++
 arch/arm/mach-shmobile/setup-r8a73a4.c           |   16 ++++-
 8 files changed, 186 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
 create mode 100644 arch/arm/mach-shmobile/board-ape6evm-reference.c

-- 
1.7.2.5

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
