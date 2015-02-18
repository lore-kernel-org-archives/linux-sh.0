From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 18 Feb 2015 02:38:12 +0000
Subject: [PATCH 00/05] ARM: shmobile: r8a7779 IRQ update and Marzen cleanup
Message-Id: <20150218023812.12588.9023.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: shmobile: r8a7779 IRQ update and Marzen cleanup

[PATCH 01/05] ARM: shmobile: r8a7779: Configure IRLM mode via DT
[PATCH 02/05] ARM: shmobile: r8a7779: Generic SoC CCF and timer support
[PATCH 03/05] ARM: shmobile: r8a7779: Generic SoC SMP support
[PATCH 04/05] ARM: shmobile: marzen-reference: Remove C board code
[PATCH 05/05] ARM: shmobile: r8a7779: Remove unused functions

Now when "irqchip: renesas-intc-irqpin: r8a7779 IRLM setup support" is
merged in v3.20-rc we can continue to cleanup r8a7779 and Marzen.

With these patches applied the r8a7779 SoC gets DT-only multiplatform
support and old C board code for multiplatform gets removed.

The legacy r8a7779 Marzen code is not touched by this series, but
with these patches applied basic r8a7779 multiplatform SoC support
is done and only a few I/O devices are legacy-only.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Built on top of renesas-devel-20150215-v3.19, but wants to be
 merged on top of v3.20-rc due to irqchip dependency.

 arch/arm/boot/dts/r8a7779.dtsi                  |    5 +-
 arch/arm/mach-shmobile/Kconfig                  |    7 --
 arch/arm/mach-shmobile/Makefile                 |    2 
 arch/arm/mach-shmobile/board-marzen-reference.c |   56 -----------------------
 arch/arm/mach-shmobile/r8a7779.h                |    2 
 arch/arm/mach-shmobile/setup-r8a7779.c          |   18 ++++---
 6 files changed, 15 insertions(+), 75 deletions(-)
