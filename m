From: Simon Horman <horms+renesas@verge.net.au>
Date: Sat, 23 Aug 2014 01:43:35 +0000
Subject: [PATCH 6/8] ARM: shmobile: marzen: Remove NR_IRQS_LEGACY
Message-Id: <322163c437b200b70ecb87ab102dfedce0ba0e91.1408671094.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1408671094.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1408671094.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Remove NR_IRQS_LEGACY from the Marzen Reference code.
The Marzen Reference machine vector requires use of
Multiplatform, and in such case SPARSE_IRQ is enabled
by default. This in turns means that the default value
of .nr_irqs equals NR_IRQS and NR_IRQS_LEGACY. Because
of this we can simply remove NR_IRQS_LEGACY and move one
step closer to a cruft-free environment.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-marzen-reference.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-marzen-reference.c b/arch/arm/mach-shmobile/board-marzen-reference.c
index 9194bce..c3dfa6c 100644
--- a/arch/arm/mach-shmobile/board-marzen-reference.c
+++ b/arch/arm/mach-shmobile/board-marzen-reference.c
@@ -64,7 +64,6 @@ DT_MACHINE_START(MARZEN, "marzen")
 	.map_io		= r8a7779_map_io,
 	.init_early	= shmobile_init_delay,
 	.init_time	= marzen_init_timer,
-	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= r8a7779_init_irq_dt,
 	.init_machine	= marzen_init,
 	.init_late	= shmobile_init_late,
-- 
2.0.1

