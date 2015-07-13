From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 13 Jul 2015 06:14:50 +0000
Subject: [PATCH v3 00/04] ARM: shmobile: r8a7779 Marzen multiplatform cleanup V3
Message-Id: <20150713061450.25534.96315.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: shmobile: r8a7779 Marzen multiplatform cleanup V3

[PATCH v3 01/04] ARM: shmobile: r8a7779: Generic SMP ops
[PATCH v3 02/04] ARM: shmobile: marzen-reference: Remove C board code
[PATCH v3 03/04] ARM: shmobile: Remove Marzen from shmobile_defconfig
[PATCH v3 04/04] ARM: shmobile: r8a7779: Cleanup header file

This series is simply resending the remaining r8a7779 multiplatform
cleanup patches. The code has not changed since V2:

[PATCH v2 00/06] ARM: shmobile: r8a7779 IRQ update and Marzen cleanup V2

With these patches applied the r8a7779 SoC gets DT-only multiplatform
support and old C board code for multiplatform gets removed.

The legacy r8a7779 Marzen code is not touched by this series, but
with these patches applied basic r8a7779 multiplatform SoC support
is done and only a few I/O devices are legacy-only.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Built on top of renesas-devel-20150706-v4.2-rc1
 No special dependencies

 arch/arm/configs/shmobile_defconfig             |    1 
 arch/arm/mach-shmobile/Kconfig                  |    7 --
 arch/arm/mach-shmobile/Makefile                 |    4 -
 arch/arm/mach-shmobile/board-marzen-reference.c |   56 -----------------------
 arch/arm/mach-shmobile/clock-r8a7779.c          |    2 
 arch/arm/mach-shmobile/r8a7779.h                |    2 
 arch/arm/mach-shmobile/setup-r8a7779.c          |    3 -
 7 files changed, 4 insertions(+), 71 deletions(-)
