From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 30 Jul 2014 23:32:50 +0000
Subject: [PATCH 05/09] ARM: shmobile: Fix shmobile_init_late() on r8a7778
Message-Id: <20140730233250.5969.67116.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Fix r8a7778 SoC machine vector to include shmobile_init_late()
so Suspend-to-RAM and CPUIdle are setup and platform devices
are omitted as expected.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/setup-r8a7778.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/setup-r8a7778.c
+++ work/arch/arm/mach-shmobile/setup-r8a7778.c	2014-07-31 08:26:09.000000000 +0900
@@ -610,8 +610,8 @@ static const char *r8a7778_compat_dt[] _
 DT_MACHINE_START(R8A7778_DT, "Generic R8A7778 (Flattened Device Tree)")
 	.init_early	= r8a7778_init_delay,
 	.init_irq	= r8a7778_init_irq_dt,
+	.init_late	= shmobile_init_late,
 	.dt_compat	= r8a7778_compat_dt,
-	.init_late      = r8a7778_init_late,
 MACHINE_END
 
 #endif /* CONFIG_USE_OF */
