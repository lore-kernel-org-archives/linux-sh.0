From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 31 Jul 2013 19:02:33 +0000
Subject: [PATCH 09/13] ARM: shmobile: Use default ->init_time() on APE6EVM DT ref
Message-Id: <20130731190233.31796.29635.sendpatchset@w520>
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

 arch/arm/mach-shmobile/board-ape6evm-reference.c |    1 -
 1 file changed, 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/board-ape6evm-reference.c
+++ work/arch/arm/mach-shmobile/board-ape6evm-reference.c	2013-08-01 03:12:18.000000000 +0900
@@ -58,7 +58,6 @@ static const char *ape6evm_boards_compat
 
 DT_MACHINE_START(APE6EVM_DT, "ape6evm")
 	.init_early	= r8a73a4_init_delay,
-	.init_time	= shmobile_timer_init,
 	.init_machine	= ape6evm_add_standard_devices,
 	.dt_compat	= ape6evm_boards_compat_dt,
 MACHINE_END
