From: Magnus Damm <magnus.damm@gmail.com>
Date: Sun, 23 Aug 2015 07:25:21 +0000
Subject: [PATCH v2 05/07] ARM: shmobile: Add function to prioritize DT SMP
Message-Id: <20150823072521.14156.35151.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20150823072427.14156.1960.sendpatchset@little-apple>
In-Reply-To: <20150823072427.14156.1960.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com, keita.kobayashi.ym@renesas.com, horms@verge.net.au, geert@linux-m68k.org, laurent.pinchart@ideasonboard.com, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm+renesas@opensource.se>

Add a function to check if other DT based method is available, and
if so return false to not hook up smp_ops from the machine vector.

This results in that DT-based SMP support has priority over older
C-based smp_ops code, and in case DT-based SMP support code does not
exist in the DTB then the old smp_ops code will still work as-is.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Changes since V1:
 - Reworked r8a7791-specific version to become reusable function.

 arch/arm/mach-shmobile/common.h  |    1 +
 arch/arm/mach-shmobile/platsmp.c |    7 +++++++
 2 files changed, 8 insertions(+)

--- 0001/arch/arm/mach-shmobile/common.h
+++ work/arch/arm/mach-shmobile/common.h	2015-08-23 15:26:18.722366518 +0900
@@ -11,6 +11,7 @@ extern void shmobile_smp_sleep(void);
 extern void shmobile_smp_hook(unsigned int cpu, unsigned long fn,
 			      unsigned long arg);
 extern bool shmobile_smp_cpu_can_disable(unsigned int cpu);
+extern bool shmobile_smp_init_fallback_ops(void);
 extern void shmobile_boot_scu(void);
 extern void shmobile_smp_scu_prepare_cpus(unsigned int max_cpus);
 extern void shmobile_smp_scu_cpu_die(unsigned int cpu);
--- 0001/arch/arm/mach-shmobile/platsmp.c
+++ work/arch/arm/mach-shmobile/platsmp.c	2015-08-23 15:26:13.692366518 +0900
@@ -36,3 +36,10 @@ bool shmobile_smp_cpu_can_disable(unsign
 	return true; /* Hotplug of any CPU is supported */
 }
 #endif
+
+bool __init shmobile_smp_init_fallback_ops(void)
+{
+	/* fallback on PSCI/smp_ops if no other DT based method is detected */
+	return platform_can_secondary_boot() ? true : false;
+}
+
