From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 13 Aug 2014 11:56:57 +0000
Subject: [PATCH 2/4] ARM: shmobile: sh73a0: Remove unneeded nr_irqs initialization
Message-Id: <1407931019-11409-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

As per arch_probe_nr_irqs(), the default value is NR_IRQS, which maps to
NR_IRQS_LEGACY if CONFIG_SPARSE_IRQ=y.

Since SPARSE_IRQ is selected by both ARCH_MULTIPLATFORM and
ARCH_SHMOBILE_LEGACY, it's always enabled on shmobile.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/setup-sh73a0.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index 002291881eb3..e7a0296b81b1 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -797,7 +797,6 @@ DT_MACHINE_START(SH73A0_DT, "Generic SH73A0 (Flattened Device Tree)")
 	.smp		= smp_ops(sh73a0_smp_ops),
 	.map_io		= sh73a0_map_io,
 	.init_early	= sh73a0_init_delay,
-	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_machine	= sh73a0_add_standard_devices_dt,
 	.init_late	= shmobile_init_late,
 	.dt_compat	= sh73a0_boards_compat_dt,
-- 
1.9.1

