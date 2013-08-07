From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 07 Aug 2013 04:38:33 +0000
Subject: [GIT PULL 16/26] ARM: shmobile: Use default ->init_time() on KZM9G DT ref
Message-Id: <f6110210347fea5599223fba6ecce14f1683f510.1375840527.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1375840527.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1375840527.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Leave ->init_time() set to NULL to use the default ARM behaviour.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-kzm9g-reference.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
index 41092bb..4cf6bab 100644
--- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
+++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
@@ -99,6 +99,5 @@ DT_MACHINE_START(KZM9G_DT, "kzm9g-reference")
 	.init_early	= sh73a0_init_delay,
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_machine	= kzm_init,
-	.init_time	= shmobile_timer_init,
 	.dt_compat	= kzm9g_boards_compat_dt,
 MACHINE_END
-- 
1.8.3.2

