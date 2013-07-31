From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 31 Jul 2013 19:02:14 +0000
Subject: [PATCH 07/13] ARM: shmobile: Use default ->init_time() on Armadillo DT ref
Message-Id: <20130731190214.31796.97852.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20130731190110.31796.96552.sendpatchset@w520>
In-Reply-To: <20130731190110.31796.96552.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Leave ->init_time() set to NULL to use the default ARM behaviour.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-armadillo800eva-reference.c |    1 -
 1 file changed, 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
+++ work/arch/arm/mach-shmobile/board-armadillo800eva-reference.c	2013-08-01 03:09:22.000000000 +0900
@@ -190,7 +190,6 @@ DT_MACHINE_START(ARMADILLO800EVA_DT, "ar
 	.init_early	= r8a7740_init_delay,
 	.init_irq	= r8a7740_init_irq_of,
 	.init_machine	= eva_init,
-	.init_time	= shmobile_timer_init,
 	.init_late	= shmobile_init_late,
 	.dt_compat	= eva_boards_compat_dt,
 	.restart	= eva_restart,
