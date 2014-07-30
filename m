From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 30 Jul 2014 23:32:59 +0000
Subject: [PATCH 06/09] ARM: shmobile: Add shmobile_init_late() to Bock-W
Message-Id: <20140730233259.5969.20542.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Extend board specific Bock-W DT reference machine vector to include
shmobile_init_late() so Suspend-to-RAM and CPUIdle are setup as expected.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/board-bockw-reference.c |    1 +
 1 file changed, 1 insertion(+)

--- 0001/arch/arm/mach-shmobile/board-bockw-reference.c
+++ work/arch/arm/mach-shmobile/board-bockw-reference.c	2014-07-31 07:49:26.000000000 +0900
@@ -83,5 +83,6 @@ DT_MACHINE_START(BOCKW_DT, "bockw")
 	.init_early	= r8a7778_init_delay,
 	.init_irq	= r8a7778_init_irq_dt,
 	.init_machine	= bockw_init,
+	.init_late	= shmobile_init_late,
 	.dt_compat	= bockw_boards_compat_dt,
 MACHINE_END
