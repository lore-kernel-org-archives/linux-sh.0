From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 30 Jul 2014 23:32:33 +0000
Subject: [PATCH 03/09] ARM: shmobile: Fix shmobile_init_late() on r8a7779
Message-Id: <20140730233233.5969.90718.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Fix r8a7779 SoC machine vector to include shmobile_init_late()
so Suspend-to-RAM and CPUIdle are setup and platform devices
are omitted as expected.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/setup-r8a7779.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/setup-r8a7779.c
+++ work/arch/arm/mach-shmobile/setup-r8a7779.c	2014-07-31 07:46:10.000000000 +0900
@@ -767,7 +767,7 @@ DT_MACHINE_START(R8A7779_DT, "Generic R8
 	.init_early	= shmobile_init_delay,
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= r8a7779_init_irq_dt,
-	.init_late	= r8a7779_init_late,
+	.init_late	= shmobile_init_late,
 	.dt_compat	= r8a7779_compat_dt,
 MACHINE_END
 #endif /* CONFIG_USE_OF */
