From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 08 Feb 2013 18:38:29 +0000
Subject: [PATCH v2 5/8] ARM: shmobile: add sh73a0-specific timer initialisation to kzm9g-reference
Message-Id: <1360348712-29255-6-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch fixes failing boot of the kzm9g-reference kernel.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Also a fix.

 arch/arm/mach-shmobile/board-kzm9g-reference.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
index 534eee6..9f5cab757 100644
--- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
+++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
@@ -112,7 +112,7 @@ DT_MACHINE_START(KZM9G_DT, "kzm9g-reference")
 	.init_irq	= sh73a0_init_irq_dt,
 	.init_machine	= kzm_init,
 	.init_late	= shmobile_init_late,
-	.init_time	= shmobile_timer_init,
+	.init_time	= sh73a0_earlytimer_init,
 	.restart	= kzm9g_restart,
 	.dt_compat	= kzm9g_boards_compat_dt,
 MACHINE_END
-- 
1.7.2.5

