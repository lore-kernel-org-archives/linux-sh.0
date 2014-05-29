From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Date: Thu, 29 May 2014 07:48:27 +0000
Subject: [PATCH 0/7] ARM: shmobile: Enable CPU FREQ support
Message-Id: <5386E64B.7060202@bp.renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch series is initial support for CPU FREQ.

Based on : renesas-devel-v3.15-rc7-20140528

Support :
 [CPU]
 - Coretex A15( Z clock) : Supported
 - Coretex A7 (Z2 clock) : Not supported
 [HW]
 - R-CAR H2 : Supported
 - R-CAR M2 : Supported
 - Other HW : Not supported
 [DVFS feature]
 - DFS : Supported
 - DVS : Not supported

Benoit Cousson (2):
  ARM: dts: r8a7790-lager: Add DVFS parameters into cpu0 node for
    r8a7790
  ARM: shmobile: Make r8a77900 CPUFreq capable

Gaku Inami (5):
  ARM: shmobile: Disable DVS support for r8a7790
  ARM: shmobile: add cpufreq-cpu0 driver for common SH-Mobile
  ARM: dts: r8a7791-koelsch: Add DVFS parameters into cpu0 node for
    r8a7791
  ARM: shmobile: Make r8a7791 CPUFreq capable
  ARM: shmobile: Enable CPUFREQ configuration

 arch/arm/boot/dts/r8a7790.dtsi               |   11 +++++++++++
 arch/arm/boot/dts/r8a7791.dtsi               |   11 +++++++++++
 arch/arm/configs/shmobile_defconfig          |   12 ++++++++++++
 arch/arm/mach-shmobile/Kconfig               |    4 ++++
 arch/arm/mach-shmobile/Makefile              |    1 +
 arch/arm/mach-shmobile/cpufreq.c             |   21 +++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/common.h |    7 +++++++
 7 files changed, 67 insertions(+)
 create mode 100644 arch/arm/mach-shmobile/cpufreq.c

-- 
1.7.9.5

