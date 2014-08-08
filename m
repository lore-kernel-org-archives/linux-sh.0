From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 08 Aug 2014 11:49:13 +0000
Subject: [PATCH 02/02] ARM: shmobile: marzen: Remove NR_IRQS_LEGACY
Message-Id: <20140808114913.14647.10399.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Remove NR_IRQS_LEGACY from the Marzen Reference code.
The Marzen Reference machine vector requires use of
Multiplatform, and in such case SPARSE_IRQ is enabled
by default. This in turns means that the default value
of .nr_irqs equals NR_IRQS and NR_IRQS_LEGACY. Because
of this we can simply remove NR_IRQS_LEGACY and move one
step closer to a cruft-free environment.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Built on top of renesas-devel-v3.16-20140808.
 Completely untested.

 arch/arm/mach-shmobile/board-marzen-reference.c |    1 -
 1 file changed, 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/board-marzen-reference.c
+++ work/arch/arm/mach-shmobile/board-marzen-reference.c	2014-08-07 16:08:05.000000000 +0900
@@ -54,7 +54,6 @@ DT_MACHINE_START(MARZEN, "marzen")
 	.map_io		= r8a7779_map_io,
 	.init_early	= shmobile_init_delay,
 	.init_time	= marzen_init_timer,
-	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= r8a7779_init_irq_dt,
 	.init_machine	= marzen_init,
 	.init_late	= shmobile_init_late,
