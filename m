From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 31 Jul 2013 19:01:28 +0000
Subject: [PATCH 02/13] ARM: shmobile: Use default ->init_time() on r8a7740
Message-Id: <20130731190128.31796.59440.sendpatchset@w520>
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

 arch/arm/mach-shmobile/setup-r8a7740.c |    1 -
 1 file changed, 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/setup-r8a7740.c
+++ work/arch/arm/mach-shmobile/setup-r8a7740.c	2013-08-01 03:00:48.000000000 +0900
@@ -1035,7 +1035,6 @@ DT_MACHINE_START(R8A7740_DT, "Generic R8
 	.init_early	= r8a7740_init_delay,
 	.init_irq	= r8a7740_init_irq_of,
 	.init_machine	= r8a7740_generic_init,
-	.init_time	= shmobile_timer_init,
 	.dt_compat	= r8a7740_boards_compat_dt,
 MACHINE_END
 
