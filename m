From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Date: Tue, 03 Jun 2014 12:01:58 +0000
Subject: [PATCH v2 0/8] ARM: shmobile: Enable CPU FREQ support
Message-Id: <538DB936.9020003@bp.renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch series is initial support for CPU FREQ.

Based on : renesas-devel-v3.15-rc7-20140530

Support :
 [CPU]
 - Coretex A15( Z clock) : Supported
 - Coretex A7 (Z2 clock) : Not supported
 [HW]
 - R-CAR H2(ES1.0) : Not supported
 - R-CAR H2(ES2.0) : Supported
 - R-CAR M2(ES1.0) : Supported
 - R-CAR M2(ES2.0) : Supported
 - Other HW : Not supported
 [DVFS feature]
 - DFS : Supported
 - DVS : Not supported

Changes since version 1:
 - changed "Signed-off-by" and "From" correctly. 
 - added DA9210 regulator.
 - changed the setting of OPPs for R-CAR H2(ES2.0).
 - changed the method of checking the device tree.
 - changed the setting of Vmin for disabling DVS
 - fixed subject.
 - fixed typo.

Benoit Cousson (3):
  ARM: shmobile: lager: Add VDD MPU regulator for DVFS
  ARM: shmobile: r8a7790/lager dts: Add DVFS parameters into cpu0 node
    for r8a7790
  ARM: shmobile: Make r8a7790 CPUFreq capable

Gaku Inami (5):
  ARM: shmobile: add cpufreq-cpu0 driver for common SH-Mobile
  ARM: shmobile: koelsch dts: Add VDD MPU regulator for DVFS
  ARM: shmobile: r8a7791/koelsch dts: Add DVFS parameters into cpu0
    node for r8a7791
  ARM: shmobile: Make r8a7791 CPUFreq capable
  ARM: shmobile: Enable CPUFREQ configuration

 arch/arm/boot/dts/r8a7790-lager.dts          |   25 +++++++++++++++++++++
 arch/arm/boot/dts/r8a7790.dtsi               |   11 +++++++++
 arch/arm/boot/dts/r8a7791-koelsch.dts        |   25 +++++++++++++++++++++
 arch/arm/boot/dts/r8a7791.dtsi               |   11 +++++++++
 arch/arm/configs/shmobile_defconfig          |   13 +++++++++++
 arch/arm/mach-shmobile/Kconfig               |    4 ++++
 arch/arm/mach-shmobile/Makefile              |    1 +
 arch/arm/mach-shmobile/cpufreq.c             |   31 ++++++++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/common.h |    7 ++++++
 9 files changed, 128 insertions(+)
 create mode 100644 arch/arm/mach-shmobile/cpufreq.c

-- 
1.7.9.5

