From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 15 May 2013 02:57:29 +0000
Subject: [PATCH v2 3/4] ARM: shmobile: marzen-reference: Initialise irqpin
Message-Id: <1368586650-26263-4-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1368586650-26263-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1368586650-26263-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Empirically it appears to be necessary to call r8a7779_init_irq_extpin(1)
in order to initialise irqpin for use with IRQ1. This is already done in
the marzen board code. This adds the call to the marzen-reference board
code.

The motivation for this is to allow use of SMSC LAN, which uses IRQ1, with
marzen-reference.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-marzen-reference.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-marzen-reference.c b/arch/arm/mach-shmobile/board-marzen-reference.c
index 5332e89..f83b6d1 100644
--- a/arch/arm/mach-shmobile/board-marzen-reference.c
+++ b/arch/arm/mach-shmobile/board-marzen-reference.c
@@ -63,12 +63,18 @@ static const char *marzen_boards_compat_dt[] __initdata = {
 	NULL,
 };
 
+void __init marzen_init_irq(void)
+{
+	r8a7779_init_irq_extpin(1); /* IRQ1 as individual interrupt */
+	r8a7779_init_irq_dt();
+}
+
 DT_MACHINE_START(MARZEN, "marzen")
 	.smp		= smp_ops(r8a7779_smp_ops),
 	.map_io		= r8a7779_map_io,
 	.init_early	= r8a7779_init_delay,
 	.nr_irqs	= NR_IRQS_LEGACY,
-	.init_irq	= r8a7779_init_irq_dt,
+	.init_irq	= marzen_init_irq,
 	.init_machine	= marzen_init,
 	.init_time	= shmobile_timer_init,
 	.dt_compat	= marzen_boards_compat_dt,
-- 
1.8.2.1

