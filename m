From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 21 Jun 2012 05:41:34 +0000
Subject: [PATCH 2/2] ARM: shmobile: kzm9d: use late init machine hook
Message-Id: <87fw9p8bn8.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Since commit 21cc1b7ede3cf456cf1d51f8a906093261f7c111 ("ARM: shmobile:
use machine specific hook for late init") suspend and CPU idle are not
initialized automatically anymore. Set shmobile_init_late() as the
machine late init hook to initialize them.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-kzm9d.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9d.c b/arch/arm/mach-shmobile/board-kzm9d.c
index 7bc5e7d..6a33cf3 100644
--- a/arch/arm/mach-shmobile/board-kzm9d.c
+++ b/arch/arm/mach-shmobile/board-kzm9d.c
@@ -80,6 +80,7 @@ DT_MACHINE_START(KZM9D_DT, "kzm9d")
 	.init_irq	= emev2_init_irq,
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= kzm9d_add_standard_devices,
+	.init_late	= shmobile_init_late,
 	.timer		= &shmobile_timer,
 	.dt_compat	= kzm9d_boards_compat_dt,
 MACHINE_END
-- 
1.7.5.4

