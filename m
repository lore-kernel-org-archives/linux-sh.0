From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 07 Aug 2013 04:38:28 +0000
Subject: [GIT PULL 11/26] ARM: shmobile: Use default ->init_time() on Bockw DT ref
Message-Id: <3bdbd1c9dbff686e375696543577c8a7ad6ef801.1375840527.git.horms+renesas@verge.net.au>
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
 arch/arm/mach-shmobile/board-bockw-reference.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-bockw-reference.c b/arch/arm/mach-shmobile/board-bockw-reference.c
index 24db8de..1a7c893 100644
--- a/arch/arm/mach-shmobile/board-bockw-reference.c
+++ b/arch/arm/mach-shmobile/board-bockw-reference.c
@@ -57,6 +57,5 @@ DT_MACHINE_START(BOCKW_DT, "bockw")
 	.init_early	= r8a7778_init_delay,
 	.init_irq	= r8a7778_init_irq_dt,
 	.init_machine	= bockw_init,
-	.init_time	= shmobile_timer_init,
 	.dt_compat	= bockw_boards_compat_dt,
 MACHINE_END
-- 
1.8.3.2

