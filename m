From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 30 Jul 2014 23:32:15 +0000
Subject: [PATCH 01/09] ARM: shmobile: Add shmobile_init_late() to sh73a0
Message-Id: <20140730233215.5969.94994.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Extend sh73a0 SoC machine vector to include shmobile_init_late()
so Suspend-to-RAM and CPUIdle are setup as expected.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/setup-sh73a0.c |    1 +
 1 file changed, 1 insertion(+)

--- 0001/arch/arm/mach-shmobile/setup-sh73a0.c
+++ work/arch/arm/mach-shmobile/setup-sh73a0.c	2014-07-31 07:43:47.000000000 +0900
@@ -799,6 +799,7 @@ DT_MACHINE_START(SH73A0_DT, "Generic SH7
 	.init_early	= sh73a0_init_delay,
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_machine	= sh73a0_add_standard_devices_dt,
+	.init_late	= shmobile_init_late,
 	.dt_compat	= sh73a0_boards_compat_dt,
 MACHINE_END
 #endif /* CONFIG_USE_OF */
