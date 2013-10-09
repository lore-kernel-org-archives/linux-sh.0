From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 09 Oct 2013 06:51:04 +0000
Subject: [PATCH 12/14] ARM: shmobile: Use SMP on Koelsch
Message-Id: <b6d5a1b1c3476225e897a2f706c0e7eca7b05984.1381299817.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1381299817.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1381299817.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Enable r8a7791 SMP support code on the Koelsch board.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-koelsch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/board-koelsch.c b/arch/arm/mach-shmobile/board-koelsch.c
index ea5846e..ace1711 100644
--- a/arch/arm/mach-shmobile/board-koelsch.c
+++ b/arch/arm/mach-shmobile/board-koelsch.c
@@ -39,6 +39,7 @@ static const char * const koelsch_boards_compat_dt[] __initconst = {
 };
 
 DT_MACHINE_START(KOELSCH_DT, "koelsch")
+	.smp		= smp_ops(r8a7791_smp_ops),
 	.init_early	= r8a7791_init_early,
 	.init_machine	= koelsch_add_standard_devices,
 	.init_time	= rcar_gen2_timer_init,
-- 
1.8.4

