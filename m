From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 31 Jul 2013 19:01:37 +0000
Subject: [PATCH 03/13] ARM: shmobile: Use default ->init_time() on r8a7778
Message-Id: <20130731190137.31796.78683.sendpatchset@w520>
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

 arch/arm/mach-shmobile/setup-r8a7778.c |    1 -
 1 file changed, 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/setup-r8a7778.c
+++ work/arch/arm/mach-shmobile/setup-r8a7778.c	2013-08-01 03:02:21.000000000 +0900
@@ -406,7 +406,6 @@ static const char *r8a7778_compat_dt[] _
 DT_MACHINE_START(R8A7778_DT, "Generic R8A7778 (Flattened Device Tree)")
 	.init_early	= r8a7778_init_delay,
 	.init_irq	= r8a7778_init_irq_dt,
-	.init_time	= shmobile_timer_init,
 	.dt_compat	= r8a7778_compat_dt,
 	.init_late      = r8a7778_init_late,
 MACHINE_END
