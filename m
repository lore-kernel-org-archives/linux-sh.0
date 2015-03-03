From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Date: Tue, 03 Mar 2015 01:19:28 +0000
Subject: [PATCH 0/5] ARM: shmobile: SMP support for r8a7794.
Message-Id: <54F50C20.8070608@bp.renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch series is initial SMP support for r8a7794.

Based on : renesas-devel-20150301-v4.0-rc1

Note that these patches do not support HYP mode. As workaround of
uninitialized CNTVOFF, fourth patch modifies to use physical arch
timer. This modification does not care HYP mode. Please find more
information following commit.

 commit : 65b5732d241b8b39e07653794eefffd0d8028cbb

Test results with these patches are below.
- secondary boot : OK
- cpu-hotplug    : OK

Gaku Inami (5):
  ARM: shmobile: r8a7794 SYSC setup code
  ARM: shmobile: Add r8a7794 reset code for SMP
  ARM: shmobile: r8a7794 dtsi: Add "timer" label to the timer node
  ARM: shmobile: alt dts: Add arm,cpu-registers-not-fw-configured
  ARM: shmobile: r8a7794 SMP support

 arch/arm/boot/dts/r8a7794-alt.dts      |    4 ++
 arch/arm/boot/dts/r8a7794.dtsi         |    2 +-
 arch/arm/mach-shmobile/Makefile        |    3 +-
 arch/arm/mach-shmobile/pm-r8a7794.c    |   70 ++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/r8a7794.h       |    8 ++++
 arch/arm/mach-shmobile/setup-r8a7794.c |    2 +
 arch/arm/mach-shmobile/smp-r8a7794.c   |   49 ++++++++++++++++++++++
 7 files changed, 136 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/pm-r8a7794.c
 create mode 100644 arch/arm/mach-shmobile/r8a7794.h
 create mode 100644 arch/arm/mach-shmobile/smp-r8a7794.c

-- 
1.7.9.5

