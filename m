From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 19 Feb 2013 02:47:42 +0000
Subject: [PATCH v2 8/8] ARM: shmobile: kzm9g: Trim reference DT_MACHINE_START
Message-Id: <1361242062-6957-9-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1361242062-6957-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1361242062-6957-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Remove .init_late and .restart from DT_MACHINE_START
for kzm9g reference as these are not necessary to
bring the board up which is the main aim of kzm9g reference.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-kzm9g-reference.c |    9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
index b741649..f278381 100644
--- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
+++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
@@ -87,13 +87,6 @@ static void __init kzm_init(void)
 #endif
 }
 
-static void kzm9g_restart(char mode, const char *cmd)
-{
-#define RESCNT2 IOMEM(0xe6188020)
-	/* Do soft power on reset */
-	writel((1 << 31), RESCNT2);
-}
-
 static const char *kzm9g_boards_compat_dt[] __initdata = {
 	"renesas,kzm9g-reference",
 	NULL,
@@ -106,8 +99,6 @@ DT_MACHINE_START(KZM9G_DT, "kzm9g-reference")
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= irqchip_init,
 	.init_machine	= kzm_init,
-	.init_late	= shmobile_init_late,
 	.init_time	= shmobile_timer_init,
-	.restart	= kzm9g_restart,
 	.dt_compat	= kzm9g_boards_compat_dt,
 MACHINE_END
-- 
1.7.10.4

