From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 07 Aug 2013 22:13:30 +0000
Subject: [PATCH 01/05] ARM: shmobile: Introduce shmobile_smp_cpu_disable()
Message-Id: <20130807221330.22251.32764.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20130807221321.22251.22774.sendpatchset@w520>
In-Reply-To: <20130807221321.22251.22774.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Introduce the shared CPU Hotplug function shmobile_smp_cpu_disable()
for mach-shmobile. It is useful for the case when all CPUs may be
hotplugged, including CPU 0.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/include/mach/common.h |    1 +
 arch/arm/mach-shmobile/platsmp.c             |    7 +++++++
 2 files changed, 8 insertions(+)

--- 0009/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2013-07-29 22:19:44.000000000 +0900
@@ -17,6 +17,7 @@ extern unsigned long shmobile_smp_arg[];
 extern unsigned long shmobile_smp_mpidr[];
 extern void shmobile_smp_hook(unsigned int cpu, unsigned long fn,
 			      unsigned long arg);
+extern int shmobile_smp_cpu_disable(unsigned int cpu);
 extern void shmobile_boot_scu(void);
 extern void shmobile_smp_scu_prepare_cpus(unsigned int max_cpus);
 extern int shmobile_smp_scu_boot_secondary(unsigned int cpu,
--- 0009/arch/arm/mach-shmobile/platsmp.c
+++ work/arch/arm/mach-shmobile/platsmp.c	2013-07-29 22:19:29.000000000 +0900
@@ -40,3 +40,10 @@ void shmobile_smp_hook(unsigned int cpu,
 	shmobile_smp_arg[cpu] = arg;
 	flush_cache_all();
 }
+
+#ifdef CONFIG_HOTPLUG_CPU
+int shmobile_smp_cpu_disable(unsigned int cpu)
+{
+	return 0; /* Hotplug of any CPU is supported */
+}
+#endif
