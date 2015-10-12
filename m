From: ahaslam@baylibre.com
Date: Mon, 12 Oct 2015 17:41:08 +0000
Subject: [RFC/RFT 0/6] Add basic mcpm support for shmobile
Message-Id: <1444671674-19275-1-git-send-email-ahaslam@baylibre.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Axel Haslam <ahaslam@baylibre.com>

This patch series enables CCI support and implements the basic mcpm
backend to allow for multi-cluster boot on renesas platforms.
To enable 8 core boot on r8a7790 the CONFIG_MCPM option should be enabled.

Additionally, the last patch adds the option to use the generic
big little cpuidle driver for r8a7790. 

These patches were inspired by the mcpm implementations in:
arch/arm/mach-exynos/mcpm-exynos.c
arch/arm/mach-vexpress/tc2_pm.c

The baseline for these patches was: Linux 4.3-rc4
and was tested using a lager board (r8a7790)

Unfortunately, when cpuidle is enabled and programed to hit core standby
mode, i am experiencing CPU stalls. This happens with all 8 cores, but
also only with a single core on the A15 cluster.

Initially i thought it might be something missing on the mcpm implementation,
but then i tested the "single-cluster" cpudile patches posted by
Kobayashi-San[1] and i also get cpu stalls even with a *single* A15 cpu (maxcpus=1).
It seems that after some idle time, the cpu cores are not woken up by
interrupts anymore(APMU?). 

The stress test i run to reproduce the issue:
"while true; do cat /proc/cpuinfo; done"
 
To avoid the issue all is needed is to comment out programing the
APMU for corestandby. (apmu_power_off(cpu);)

I would really appreciate any suggestions and would be glad to implement or try
out any ideas on to how to avoid or start investigating the reason why cpus
may be stalling!

1. https://www.marc.info/?l=linux-pm&m2918169627459&w=1

Axel Haslam (6):
  ARM: shmobile: r8a7790: configure arch timer at boot
  ARM: shmobile: export apmu_power_* functions
  ARM: shmobile: check if cpu is allowed on power on
  ARM: dts: add CCI node for r8a7790
  ARM: shmobile: Add MCPM back end functions
  cpuidle: big.LITTLE: Add ARCH_SHMOBILE and r8a7790

 arch/arm/boot/dts/r8a7790.dtsi         |  30 ++++++-
 arch/arm/mach-shmobile/Kconfig         |   9 ++
 arch/arm/mach-shmobile/Makefile        |   1 +
 arch/arm/mach-shmobile/common.h        |   6 ++
 arch/arm/mach-shmobile/mcpm-shmobile.c | 155 +++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/platsmp-apmu.c  |  64 ++++++++------
 arch/arm/mach-shmobile/platsmp-apmu.h  |   4 +-
 drivers/cpuidle/Kconfig.arm            |   2 +-
 drivers/cpuidle/cpuidle-big_little.c   |   1 +
 9 files changed, 242 insertions(+), 30 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/mcpm-shmobile.c

-- 
2.4.5

