From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 31 Jul 2013 19:02:05 +0000
Subject: [PATCH 06/13] ARM: shmobile: Use default ->init_time() on Bockw DT ref
Message-Id: <20130731190205.31796.84731.sendpatchset@w520>
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

 arch/arm/mach-shmobile/board-bockw-reference.c |    1 -
 1 file changed, 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/board-bockw-reference.c
+++ work/arch/arm/mach-shmobile/board-bockw-reference.c	2013-08-01 03:07:13.000000000 +0900
@@ -57,6 +57,5 @@ DT_MACHINE_START(BOCKW_DT, "bockw")
 	.init_early	= r8a7778_init_delay,
 	.init_irq	= r8a7778_init_irq_dt,
 	.init_machine	= bockw_init,
-	.init_time	= shmobile_timer_init,
 	.dt_compat	= bockw_boards_compat_dt,
 MACHINE_END
