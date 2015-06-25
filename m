From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 25 Jun 2015 08:57:16 +0000
Subject: [PATCH v2 00/06] ARM: shmobile: r8a7779 IRQ update and Marzen cleanup V2
Message-Id: <20150625085716.24543.84444.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: shmobile: r8a7779 IRQ update and Marzen cleanup V2

[PATCH v2 01/06] ARM: shmobile: r8a7779: Configure IRLM mode via DT
[PATCH v2 02/06] ARM: shmobile: r8a7779: Generic CCF and timer support
[PATCH v2 03/06] ARM: shmobile: r8a7779: Generic SMP ops
[PATCH v2 04/06] ARM: shmobile: marzen-reference: Remove C board code
[PATCH v2 05/06] ARM: shmobile: Remove Marzen from shmobile_defconfig
[PATCH v2 06/06] ARM: shmobile: r8a7779: Cleanup header file

Now when "irqchip: renesas-intc-irqpin: r8a7779 IRLM setup support" is
merged we can continue to cleanup r8a7779 and Marzen.

With these patches applied the r8a7779 SoC gets DT-only multiplatform
support and old C board code for multiplatform gets removed.

The legacy r8a7779 Marzen code is not touched by this series, but
with these patches applied basic r8a7779 multiplatform SoC support
is done and only a few I/O devices are legacy-only.

Only minor changes since V1, fixed build issues for the legacy case.
Boot tested with shmobile_defconfig on real hardware. Built using
marzen_defconfig as well but no testing in such case.

We probably want to figure out a way how to handle kernel configuration
of regulators...

Thanks for earlier review by Geert!

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Built on top of renesas-devel-20150624-v4.1
 No special dependencies

 arch/arm/boot/dts/r8a7779.dtsi                  |    5 +-
 arch/arm/configs/shmobile_defconfig             |    1 
 arch/arm/mach-shmobile/Kconfig                  |    7 --
 arch/arm/mach-shmobile/Makefile                 |    4 -
 arch/arm/mach-shmobile/board-marzen-reference.c |   56 -----------------------
 arch/arm/mach-shmobile/clock-r8a7779.c          |    2 
 arch/arm/mach-shmobile/r8a7779.h                |    2 
 arch/arm/mach-shmobile/setup-r8a7779.c          |   15 +++++-
 8 files changed, 19 insertions(+), 73 deletions(-)
