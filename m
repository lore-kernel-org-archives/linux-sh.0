From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 31 Jul 2013 19:01:19 +0000
Subject: [PATCH 01/13] ARM: shmobile: Use default ->init_time() on r8a73a4
Message-Id: <20130731190119.31796.56612.sendpatchset@w520>
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

 arch/arm/mach-shmobile/setup-r8a73a4.c |    1 -
 1 file changed, 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ work/arch/arm/mach-shmobile/setup-r8a73a4.c	2013-08-01 02:58:37.000000000 +0900
@@ -223,7 +223,6 @@ static const char *r8a73a4_boards_compat
 
 DT_MACHINE_START(R8A73A4_DT, "Generic R8A73A4 (Flattened Device Tree)")
 	.init_early	= r8a73a4_init_delay,
-	.init_time	= shmobile_timer_init,
 	.dt_compat	= r8a73a4_boards_compat_dt,
 MACHINE_END
 #endif /* CONFIG_USE_OF */
