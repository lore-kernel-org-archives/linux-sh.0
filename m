From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 08 Apr 2014 12:48:07 +0000
Subject: [PATCH 01/02] ARM: shmobile: Multicluster APMU prototype support
Message-Id: <20140408124807.9773.97405.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Allow APMU multicluster operation when enabled via
the kernel command line. Default is still single
cluster operation. Use together with appropriate
scheduler modifcations or static CPU affinity.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Applies on top of renesas-devel-v3.14-20140408

 arch/arm/mach-shmobile/platsmp-apmu.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

--- 0001/arch/arm/mach-shmobile/platsmp-apmu.c
+++ work/arch/arm/mach-shmobile/platsmp-apmu.c	2014-04-08 19:01:55.000000000 +0900
@@ -18,6 +18,19 @@
 #include <asm/smp_plat.h>
 #include <mach/common.h>
 
+/* only enable the cluster that includes the boot CPU by default */
+static bool enable_multicluster = false;
+
+static __init int apmu_setup(char *opt)
+{
+	if (!opt)
+		return -EINVAL;
+	if (!strncmp(opt, "multicluster", 12))
+		enable_multicluster = true;
+	return 0;
+}
+early_param("apmu", apmu_setup);
+
 static struct {
 	void __iomem *iomem;
 	int bit;
@@ -100,8 +113,7 @@ static void apmu_parse_cfg(void (*fn)(st
 	bool is_allowed;
 
 	for (k = 0; k < ARRAY_SIZE(apmu_config); k++) {
-		/* only enable the cluster that includes the boot CPU */
-		is_allowed = false;
+		is_allowed = enable_multicluster;
 		for (bit = 0; bit < ARRAY_SIZE(apmu_config[k].cpus); bit++) {
 			id = apmu_config[k].cpus[bit];
 			if (id >= 0) {
