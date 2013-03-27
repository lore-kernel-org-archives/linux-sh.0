From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 27 Mar 2013 15:49:25 +0000
Subject: [PATCH 00/04 v2] ARM: shmobile: r8a7790 SoC
Message-Id: <20130327154925.10876.40575.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

ARM: shmobile: r8a7790 SoC (V2)

[PATCH 01/04] ARM: shmobile: Initial r8a7790 SoC support
[PATCH 02/04] ARM: shmobile: r8a7790 SCIF support
[PATCH 03/04] ARM: shmobile: r8a7790 IRQC support
[PATCH 04/04] ARM: shmobile: r8a7790 PFC support

This series is V2 of initial support for the r8a7790 SoC. The SoC
is known as r8a7790 which is built around Cortex-A15 and makes use
of SCIF for serial and IRQC interrupt controller for external IRQs.

Changes in V2:
- Added PFC platform device

Future r8a7790 PFC and Lager board series will depend on this one.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written on top of renesas-next-20130327

 arch/arm/boot/dts/r8a7790.dtsi                |   63 +++++++++++
 arch/arm/mach-shmobile/Kconfig                |    9 +
 arch/arm/mach-shmobile/Makefile               |    1 
 arch/arm/mach-shmobile/clock-r8a7790.c        |   95 +++++++++++++++++
 arch/arm/mach-shmobile/include/mach/r8a7790.h |    8 +
 arch/arm/mach-shmobile/setup-r8a7790.c        |  137 +++++++++++++++++++++++++
 6 files changed, 312 insertions(+), 1 deletion(-)
