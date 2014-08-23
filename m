From: Simon Horman <horms+renesas@verge.net.au>
Date: Sat, 23 Aug 2014 01:43:31 +0000
Subject: [PATCH 2/8] ARM: shmobile: marzen: Add shmobile_init_late()
Message-Id: <b9c9281339376521d0feb78c9051fedfbb3cf111.1408671094.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1408671094.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1408671094.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Extend board specific Marzen DT reference machine vector to include
shmobile_init_late() so Suspend-to-RAM and CPUIdle are setup as expected.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-marzen-reference.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/board-marzen-reference.c b/arch/arm/mach-shmobile/board-marzen-reference.c
index 21b3e1c..9194bce 100644
--- a/arch/arm/mach-shmobile/board-marzen-reference.c
+++ b/arch/arm/mach-shmobile/board-marzen-reference.c
@@ -67,5 +67,6 @@ DT_MACHINE_START(MARZEN, "marzen")
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= r8a7779_init_irq_dt,
 	.init_machine	= marzen_init,
+	.init_late	= shmobile_init_late,
 	.dt_compat	= marzen_boards_compat_dt,
 MACHINE_END
-- 
2.0.1

