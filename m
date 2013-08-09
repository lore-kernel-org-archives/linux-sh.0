From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 09 Aug 2013 09:49:05 +0000
Subject: [PATCH 07/14] ARM: shmobile: Remove r8a7779 ->nr_irqs
Message-Id: <20130809094905.6530.90685.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20130809094748.6530.16511.sendpatchset@w520>
In-Reply-To: <20130809094748.6530.16511.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove .nr_irqs for r8a7779 DT cases.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-marzen-reference.c |    1 -
 arch/arm/mach-shmobile/setup-r8a7779.c          |    1 -
 2 files changed, 2 deletions(-)

--- 0004/arch/arm/mach-shmobile/board-marzen-reference.c
+++ work/arch/arm/mach-shmobile/board-marzen-reference.c	2013-08-08 16:13:35.000000000 +0900
@@ -44,7 +44,6 @@ DT_MACHINE_START(MARZEN, "marzen")
 	.smp		= smp_ops(r8a7779_smp_ops),
 	.map_io		= r8a7779_map_io,
 	.init_early	= r8a7779_init_delay,
-	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= r8a7779_init_irq_dt,
 	.init_machine	= marzen_init,
 	.dt_compat	= marzen_boards_compat_dt,
--- 0004/arch/arm/mach-shmobile/setup-r8a7779.c
+++ work/arch/arm/mach-shmobile/setup-r8a7779.c	2013-08-08 16:13:15.000000000 +0900
@@ -739,7 +739,6 @@ static const char *r8a7779_compat_dt[] _
 DT_MACHINE_START(R8A7779_DT, "Generic R8A7779 (Flattened Device Tree)")
 	.map_io		= r8a7779_map_io,
 	.init_early	= r8a7779_init_delay,
-	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= r8a7779_init_irq_dt,
 	.init_late	= r8a7779_init_late,
 	.dt_compat	= r8a7779_compat_dt,
