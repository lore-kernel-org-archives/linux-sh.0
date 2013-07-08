From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 08 Jul 2013 16:04:56 +0000
Subject: [PATCH v3 0/2] ARM: shmobile: APE6EVM: add a reference DT implementation
Message-Id: <1373299498-10044-1-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch series adds a DT-based APE6EVM platform implementation.

v3: dropped patches 1 and 4 from the previous version.

Developed and tested on top of Simon's renesas.git next snapshot of
08.07.2013 plus my today's v3 of the patch-set:

ARM: shmobile: DMAC, MMCIF and SDHI for H2 and APE6

Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Guennadi Liakhovetski (2):
  ARM: shmobile: ape6evm: add DT reference
  ARM: shmobile: ape6evm-reference: add CPUFreq support

 arch/arm/boot/dts/Makefile                       |    1 +
 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts  |   55 ++++++++++++++++
 arch/arm/mach-shmobile/Kconfig                   |   11 +++
 arch/arm/mach-shmobile/Makefile                  |    1 +
 arch/arm/mach-shmobile/Makefile.boot             |    1 +
 arch/arm/mach-shmobile/board-ape6evm-reference.c |   73 ++++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/r8a73a4.h    |    1 +
 arch/arm/mach-shmobile/setup-r8a73a4.c           |    9 ++-
 8 files changed, 150 insertions(+), 2 deletions(-)
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
