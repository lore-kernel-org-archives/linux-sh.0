From: Magnus Damm <magnus.damm@gmail.com>
Date: Sun, 23 Aug 2015 07:24:49 +0000
Subject: [PATCH v2 02/07] ARM: shmobile: Add APMU DT support via Enable method
Message-Id: <20150823072449.14156.40934.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20150823072427.14156.1960.sendpatchset@little-apple>
In-Reply-To: <20150823072427.14156.1960.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com, keita.kobayashi.ym@renesas.com, horms@verge.net.au, geert@linux-m68k.org, laurent.pinchart@ideasonboard.com, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm+renesas@opensource.se>

Allow DT configuration of the APMU hardware in the case when the APMU is
pointed out in the DTB via the enable-method. The ability to configure
the APMU via C code is still kept intact to prevent DTB breakage for older
SoCs that do not rely on the enable-method for SMP support.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Changes since V1:
 - Adjusted to use .cpu_can_disable instead of .cpu_disable

 arch/arm/mach-shmobile/platsmp-apmu.c |   89 +++++++++++++++++++++++++++++++--
 1 file changed, 85 insertions(+), 4 deletions(-)

--- 0001/arch/arm/mach-shmobile/platsmp-apmu.c
+++ work/arch/arm/mach-shmobile/platsmp-apmu.c	2015-08-23 15:33:57.742366518 +0900
@@ -24,6 +24,7 @@
 #include <asm/suspend.h>
 #include "common.h"
 #include "platsmp-apmu.h"
+#include "rcar-gen2.h"
 
 static struct {
 	void __iomem *iomem;
@@ -117,15 +118,64 @@ static void apmu_parse_cfg(void (*fn)(st
 	}
 }
 
-void __init shmobile_smp_apmu_prepare_cpus(unsigned int max_cpus,
-					   struct rcar_apmu_config *apmu_config,
-					   int num)
+static const struct of_device_id apmu_ids[] = {
+	{ .compatible = "renesas,apmu" },
+	{ /*sentinel*/ }
+};
+
+static void apmu_parse_dt(void (*fn)(struct resource *res, int cpu, int bit))
+{
+	struct device_node *np_apmu, *np_cpu;
+	struct resource res;
+	u32 id;
+	int bit, index;
+	bool is_allowed;
+
+	for_each_matching_node(np_apmu, apmu_ids) {
+		/* only enable the cluster that includes the boot CPU */
+		is_allowed = false;
+		for (bit = 0; bit < CONFIG_NR_CPUS; bit++) {
+			np_cpu = of_parse_phandle(np_apmu, "cpus", bit);
+			if (np_cpu) {
+				if (!of_property_read_u32(np_cpu, "reg", &id)) {
+					if (id = cpu_logical_map(0))
+						is_allowed = true;
+				}
+				of_node_put(np_cpu);
+			}
+		}
+		if (!is_allowed)
+			continue;
+
+		for (bit = 0; bit < CONFIG_NR_CPUS; bit++) {
+			np_cpu = of_parse_phandle(np_apmu, "cpus", bit);
+			if (np_cpu) {
+				if (!of_property_read_u32(np_cpu, "reg", &id)) {
+					index = get_logical_index(id);
+					if ((index >= 0) &&
+					    !of_address_to_resource(np_apmu,
+								    0, &res))
+						fn(&res, index, bit);
+				}
+				of_node_put(np_cpu);
+			}
+		}
+		of_node_put(np_apmu);
+	}
+}
+
+static void __init shmobile_smp_apmu_setup_boot(void)
 {
 	/* install boot code shared by all CPUs */
 	shmobile_boot_fn = virt_to_phys(shmobile_smp_boot);
 	shmobile_boot_arg = MPIDR_HWID_BITMASK;
+}
 
-	/* perform per-cpu setup */
+void __init shmobile_smp_apmu_prepare_cpus(unsigned int max_cpus,
+					   struct rcar_apmu_config *apmu_config,
+					   int num)
+{
+	shmobile_smp_apmu_setup_boot();
 	apmu_parse_cfg(apmu_init_cpu, apmu_config, num);
 }
 
@@ -236,3 +286,34 @@ void __init shmobile_smp_apmu_suspend_in
 	shmobile_suspend_ops.enter = shmobile_smp_apmu_enter_suspend;
 }
 #endif
+
+static void __init shmobile_smp_apmu_prepare_cpus_dt(unsigned int max_cpus)
+{
+	shmobile_smp_apmu_setup_boot();
+	apmu_parse_dt(apmu_init_cpu);
+	rcar_gen2_pm_init();
+}
+
+static int shmobile_smp_apmu_boot_secondary_md21(unsigned int cpu,
+						 struct task_struct *idle)
+{
+	/* Error out when hardware debug mode is enabled */
+	if (rcar_gen2_read_mode_pins() & BIT(21)) {
+		pr_warn("Unable to boot CPU%u when MD21 is set\n", cpu);
+		return -ENOTSUPP;
+	}
+
+	return shmobile_smp_apmu_boot_secondary(cpu, idle);
+}
+
+static struct smp_operations apmu_smp_ops __initdata = {
+	.smp_prepare_cpus	= shmobile_smp_apmu_prepare_cpus_dt,
+	.smp_boot_secondary	= shmobile_smp_apmu_boot_secondary_md21,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_can_disable	= shmobile_smp_cpu_can_disable,
+	.cpu_die		= shmobile_smp_apmu_cpu_die,
+	.cpu_kill		= shmobile_smp_apmu_cpu_kill,
+#endif
+};
+
+CPU_METHOD_OF_DECLARE(shmobile_smp_apmu, "renesas,apmu", &apmu_smp_ops);
