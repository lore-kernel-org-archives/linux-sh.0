From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 21 May 2015 01:22:21 +0000
Subject: [PATCH 04/04] ARM: shmobile: Remove r8a7791 non-DT APMU override
Message-Id: <20150521012221.25972.69124.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20150521012138.25972.91336.sendpatchset@little-apple>
In-Reply-To: <20150521012138.25972.91336.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com, keita.kobayashi.ym@renesas.com, horms@verge.net.au, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm+renesas@opensource.se>

Adjust the r8a7791 SoC support code to not configure any non-DT SMP code
in case the DT-based enable-method has been installed already.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/r8a7791.h       |    2 +-
 arch/arm/mach-shmobile/setup-r8a7791.c |    2 +-
 arch/arm/mach-shmobile/smp-r8a7791.c   |   11 ++++++++++-
 3 files changed, 12 insertions(+), 3 deletions(-)

--- 0001/arch/arm/mach-shmobile/r8a7791.h
+++ work/arch/arm/mach-shmobile/r8a7791.h	2015-05-20 22:52:00.602366518 +0900
@@ -1,6 +1,6 @@
 #ifndef __ASM_R8A7791_H__
 #define __ASM_R8A7791_H__
 
-extern struct smp_operations r8a7791_smp_ops;
+bool r8a7791_smp_init(void);
 
 #endif /* __ASM_R8A7791_H__ */
--- 0001/arch/arm/mach-shmobile/setup-r8a7791.c
+++ work/arch/arm/mach-shmobile/setup-r8a7791.c	2015-05-20 22:55:48.172366518 +0900
@@ -29,7 +29,7 @@ static const char *r8a7791_boards_compat
 };
 
 DT_MACHINE_START(R8A7791_DT, "Generic R8A7791 (Flattened Device Tree)")
-	.smp		= smp_ops(r8a7791_smp_ops),
+	.smp_init	= r8a7791_smp_init,
 	.init_early	= shmobile_init_delay,
 	.init_time	= rcar_gen2_timer_init,
 	.init_late	= shmobile_init_late,
--- 0001/arch/arm/mach-shmobile/smp-r8a7791.c
+++ work/arch/arm/mach-shmobile/smp-r8a7791.c	2015-05-20 22:57:53.502366518 +0900
@@ -54,7 +54,7 @@ static int r8a7791_smp_boot_secondary(un
 	return shmobile_smp_apmu_boot_secondary(cpu, idle);
 }
 
-struct smp_operations r8a7791_smp_ops __initdata = {
+static struct smp_operations r8a7791_smp_ops __initdata = {
 	.smp_prepare_cpus	= r8a7791_smp_prepare_cpus,
 	.smp_boot_secondary	= r8a7791_smp_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
@@ -63,3 +63,12 @@ struct smp_operations r8a7791_smp_ops __
 	.cpu_kill		= shmobile_smp_apmu_cpu_kill,
 #endif
 };
+
+bool __init r8a7791_smp_init(void)
+{
+	/* only setup when no other DT based method is detected */
+	if (!platform_can_secondary_boot())
+		smp_set_ops(&r8a7791_smp_ops);
+
+	return true;
+}
