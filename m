From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 20 Jun 2012 10:53:25 +0000
Subject: [PATCH] ARM: mach-shmobile: armadillo800eva: Use late init machine hook
Message-Id: <1340189605-22074-1-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Since commit 21cc1b7ede3cf456cf1d51f8a906093261f7c111 ("ARM: shmobile:
use machine specific hook for late init") suspend and CPU idle are not
initialized automatically anymore. Set shmobile_init_late() as the
machine late init hook to initialize them.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index c0ad535..a70993f 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -990,6 +990,7 @@ DT_MACHINE_START(ARMADILLO800EVA_DT, "armadillo800eva")
 	.init_irq	= r8a7740_init_irq,
 	.handle_irq	= shmobile_handle_irq_intc,
 	.init_machine	= eva_init,
+	.init_late	= shmobile_init_late,
 	.timer		= &shmobile_timer,
 	.dt_compat	= eva_boards_compat_dt,
 MACHINE_END
-- 
1.7.3.4

