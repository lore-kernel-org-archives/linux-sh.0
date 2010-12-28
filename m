From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 28 Dec 2010 08:26:43 +0000
Subject: [PATCH 00/04] ARM: mach-shmobile: Add run-time IRQ handler support
Message-Id: <20101228082643.11806.88798.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: mach-shmobile: Add run-time IRQ handler support

[PATCH 01/04] ARM: mach-shmobile: Enable CONFIG_MULTI_IRQ_HANDLER
[PATCH 02/04] ARM: mach-shmobile: Run-time IRQ handler for INTCA
[PATCH 03/04] ARM: mach-shmobile: Run-time IRQ handler for GIC
[PATCH 04/04] ARM: mach-shmobile: Rely on run-time IRQ handlers

These patches add run-time IRQ handler support for R-Mobile and
SH-Mobile processors. Nothing out of the ordinary really, except
merge dependency fun. Built on top of rmobile-latest plus below.

Depends on:
"[PATCH 01/07] ARM: Introduce asm/hardware/entry-macro-gic.S"
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?idd75/1

"[PATCH] ARM: Allow machine to specify it's own IRQ handlers at run-time"
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?ide32/1

"[PATCH] ARM: Subarch IRQ handler macros V3"
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?ide38/1

"[PATCH] ARM: mach-shmobile: Use shared GIC entry macros"
https://patchwork.kernel.org/patch/426981/

Signed-off-by: Magnus Damm <damm@opensource.se>
---
 arch/arm/Kconfig                                       |    1 
 arch/arm/mach-shmobile/Makefile                        |    6 +
 arch/arm/mach-shmobile/board-ag5evm.c                  |    1 
 arch/arm/mach-shmobile/board-ap4evb.c                  |    1 
 arch/arm/mach-shmobile/board-g3evm.c                   |    1 
 arch/arm/mach-shmobile/board-g4evm.c                   |    1 
 arch/arm/mach-shmobile/board-mackerel.c                |    1 
 arch/arm/mach-shmobile/entry-gic.S                     |   20 +++++
 arch/arm/mach-shmobile/entry-intc.S                    |   57 ++++++++++++++
 arch/arm/mach-shmobile/include/mach/common.h           |    2 
 arch/arm/mach-shmobile/include/mach/entry-macro-gic.S  |   29 -------
 arch/arm/mach-shmobile/include/mach/entry-macro-intc.S |   61 ----------------
 arch/arm/mach-shmobile/include/mach/entry-macro.S      |   23 ++++--
 arch/arm/mach-shmobile/include/mach/hardware.h         |    3 
 14 files changed, 109 insertions(+), 98 deletions(-)
