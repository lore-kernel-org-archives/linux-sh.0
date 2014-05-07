From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 07 May 2014 23:32:47 +0000
Subject: [PATCH 03/04] ARM: shmobile: Use r8a7740 DT CPU Frequency for Armadillo DT Ref
Message-Id: <20140507233247.29712.21368.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20140507233219.29712.9253.sendpatchset@w520>
In-Reply-To: <20140507233219.29712.9253.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Convert the Armadillo r8a7740 DT reference board support
to use shmobile_init_delay() to be able to migrate away
from per-SoC delay setup functions.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/board-armadillo800eva-reference.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
+++ work/arch/arm/mach-shmobile/board-armadillo800eva-reference.c	2014-04-24 17:59:55.000000000 +0900
@@ -187,7 +187,7 @@ static const char *eva_boards_compat_dt[
 
 DT_MACHINE_START(ARMADILLO800EVA_DT, "armadillo800eva-reference")
 	.map_io		= r8a7740_map_io,
-	.init_early	= r8a7740_init_delay,
+	.init_early	= shmobile_init_delay,
 	.init_irq	= r8a7740_init_irq_of,
 	.init_machine	= eva_init,
 	.init_late	= shmobile_init_late,
