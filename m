From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 04 Jul 2013 20:40:36 +0000
Subject: [PATCH 0/2] ARM: shmobile: APE6EVM: add a reference DT implementation
Message-Id: <1372970438-21549-1-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch series adds a DT-based APE6EVM platform implementation. The 
first of them prepares auxiliary device handling functions for the r8a73a4 
SoC, and the second one adds a the actual platform support.

Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Guennadi Liakhovetski (2):
  ARM: shmobile: r8a73a4: reorganise device instantiation in DT case
  ARM: shmobile: APE6EVM: add DT reference

 arch/arm/boot/dts/Makefile                       |    1 +
 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts  |   76 +++++++++++++++++++++
 arch/arm/mach-shmobile/Kconfig                   |   11 +++
 arch/arm/mach-shmobile/Makefile                  |    1 +
 arch/arm/mach-shmobile/board-ape6evm-reference.c |   77 ++++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/r8a73a4.h    |    1 +
 arch/arm/mach-shmobile/setup-r8a73a4.c           |   17 ++++-
 7 files changed, 181 insertions(+), 3 deletions(-)
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
