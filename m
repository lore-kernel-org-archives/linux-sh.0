From: ahaslam@baylibre.com
Date: Mon, 12 Oct 2015 17:41:11 +0000
Subject: [RFC/RFT 3/6] ARM: shmobile: check if cpu is allowed on power on
Message-Id: <1444671674-19275-4-git-send-email-ahaslam@baylibre.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Axel Haslam <ahaslam@baylibre.com>

To decide if we can boot cpus that are not part of the boot cluster,
we should check if cci and mcpm were correctly enabled and probed.
But, mcpm_init is called with an early_init call which is
later than apmu_parse_cfg.

So, check if a cpu should be allowed to boot direcly from the
the power_on function as this will happen after early_init and allow
us to check if mcpm and cci are enabled.

We use the fact that the boot cpu will always be logical cpu0 to compare
each cpus physical cluster and decide if can be turned on or not.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 arch/arm/mach-shmobile/platsmp-apmu.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index d2ff5af..b88d97c 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -28,6 +28,8 @@
 static struct {
 	void __iomem *iomem;
 	int bit;
+	unsigned int pcpu;
+	unsigned int pcluster;
 } apmu_cpus[NR_CPUS];
 
 #define WUPCR_OFFS 0x10
@@ -37,11 +39,17 @@ static struct {
 int __maybe_unused apmu_power_on(unsigned int cpu)
 {
 	void __iomem *p = apmu_cpus[cpu].iomem;
+	unsigned int pcluster = apmu_cpus[cpu].pcluster;
+	unsigned int boot_pcluster = apmu_cpus[0].pcluster;
 	int bit =  apmu_cpus[cpu].bit;
 
 	if (!p)
 		return -EINVAL;
 
+	if (pcluster != boot_pcluster) {
+		pr_err("Requested to boot cpu %d on non-boot cluster!\n", cpu);
+		return -EINVAL;
+	}
 	/* request power on */
 	writel_relaxed(BIT(bit), p + WUPCR_OFFS);
 
@@ -101,27 +109,19 @@ static void apmu_parse_cfg(void (*fn)(struct resource *res, int cpu, int bit),
 	u32 id;
 	int k;
 	int bit, index;
-	bool is_allowed;
 
 	for (k = 0; k < num; k++) {
-		/* only enable the cluster that includes the boot CPU */
-		is_allowed = false;
-		for (bit = 0; bit < ARRAY_SIZE(apmu_config[k].cpus); bit++) {
-			id = apmu_config[k].cpus[bit];
-			if (id >= 0) {
-				if (id = cpu_logical_map(0))
-					is_allowed = true;
-			}
-		}
-		if (!is_allowed)
-			continue;
-
 		for (bit = 0; bit < ARRAY_SIZE(apmu_config[k].cpus); bit++) {
 			id = apmu_config[k].cpus[bit];
 			if (id >= 0) {
 				index = get_logical_index(id);
-				if (index >= 0)
+				if (index >= 0) {
 					fn(&apmu_config[k].iomem, index, bit);
+					apmu_cpus[index].pcpu +						MPIDR_AFFINITY_LEVEL(id, 0);
+					apmu_cpus[index].pcluster +						MPIDR_AFFINITY_LEVEL(id, 1);
+				}
 			}
 		}
 	}
-- 
2.4.5

