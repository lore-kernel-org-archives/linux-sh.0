From: Magnus Damm <magnus.damm@gmail.com>
Date: Sat, 14 Sep 2013 15:29:07 +0000
Subject: [PATCH 02/03] ARM: shmobile: Extend APMU code to allow single cluster only
Message-Id: <20130914152907.12327.14175.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Extend the APMU code with a check to only allow boot
of CPU cores that sit in the same cluster as CPU0.

This makes it possible for people to use the r8a790
CA7 boot mode with CA7-cores only. The default CA15
boot mode will enable CA15 cores only. This is an
intentional software limitation to cope with lacking
scheduler support.

By removing this patch it is possible to run all 8 cores
in parallel, but this is not recommended without out of tree
scheduler modfications or custom user space code to control
the CPU affinitiy.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/platsmp-apmu.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- 0001/arch/arm/mach-shmobile/platsmp-apmu.c
+++ work/arch/arm/mach-shmobile/platsmp-apmu.c	2013-09-15 00:11:23.000000000 +0900
@@ -94,8 +94,21 @@ static void apmu_parse_cfg(void (*fn)(st
 	u32 id;
 	int k;
 	int bit, index;
+	bool is_allowed;
 
 	for (k = 0; k < ARRAY_SIZE(apmu_config); k++) {
+		/* only enable the cluster that includes the boot CPU */
+		is_allowed = false;
+		for (bit = 0; bit < ARRAY_SIZE(apmu_config[k].cpus); bit++) {
+			id = apmu_config[k].cpus[bit];
+			if (id >= 0) {
+				if (id = cpu_logical_map(0))
+					is_allowed = true;
+			}
+		}
+		if (!is_allowed)
+			continue;
+
 		for (bit = 0; bit < ARRAY_SIZE(apmu_config[k].cpus); bit++) {
 			id = apmu_config[k].cpus[bit];
 			if (id >= 0) {
