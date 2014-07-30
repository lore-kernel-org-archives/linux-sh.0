From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 30 Jul 2014 23:32:41 +0000
Subject: [PATCH 04/09] ARM: shmobile: Add shmobile_init_late() to Marzen
Message-Id: <20140730233241.5969.59510.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Extend board specific Marzen DT reference machine vector to include
shmobile_init_late() so Suspend-to-RAM and CPUIdle are setup as expected.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/board-marzen-reference.c |    1 +
 1 file changed, 1 insertion(+)

--- 0001/arch/arm/mach-shmobile/board-marzen-reference.c
+++ work/arch/arm/mach-shmobile/board-marzen-reference.c	2014-07-31 07:45:06.000000000 +0900
@@ -57,5 +57,6 @@ DT_MACHINE_START(MARZEN, "marzen")
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= r8a7779_init_irq_dt,
 	.init_machine	= marzen_init,
+	.init_late	= shmobile_init_late,
 	.dt_compat	= marzen_boards_compat_dt,
 MACHINE_END
