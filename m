From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 30 Jul 2014 23:32:24 +0000
Subject: [PATCH 02/09] ARM: shmobile: Add shmobile_init_late() to KZM9G
Message-Id: <20140730233224.5969.39070.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Extend board specific KZM9D DT reference machine vector to include
shmobile_init_late() so Suspend-to-RAM and CPUIdle are setup as expected.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/board-kzm9g-reference.c |    1 +
 1 file changed, 1 insertion(+)

--- 0001/arch/arm/mach-shmobile/board-kzm9g-reference.c
+++ work/arch/arm/mach-shmobile/board-kzm9g-reference.c	2014-07-31 07:41:03.000000000 +0900
@@ -54,5 +54,6 @@ DT_MACHINE_START(KZM9G_DT, "kzm9g-refere
 	.init_early	= sh73a0_init_delay,
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_machine	= kzm_init,
+	.init_late	= shmobile_init_late,
 	.dt_compat	= kzm9g_boards_compat_dt,
 MACHINE_END
