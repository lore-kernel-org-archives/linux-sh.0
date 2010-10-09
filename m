From: Matt Fleming <matt@console-pimps.org>
Date: Sat, 09 Oct 2010 00:46:18 +0000
Subject: [PATCH 3/7] oprofile: Make op_name_from_perf_id() global
Message-Id: <7b803da1bb48b15e29c966ff925cfb21f9015e6c.1286584677.git.matt@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1286584677.git.matt@console-pimps.org>
In-Reply-To: <cover.1286584677.git.matt@console-pimps.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Robert Richter <robert.richter@amd.com>
Cc: linux-arch@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <fweisbec@gmail.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Paul Mundt <lethal@linux-sh.org>, Deng-Cheng Zhu <dengcheng.zhu@gmail.com>, Ingo Molnar <mingo@elte.hu>, linux-arm-kernel@lists.infradead.org

Make op_name_from_perf_id() global so that we have a way for each
architecture to construct an oprofile name for op->cpu_type. We need to
remove the argument from the function prototype so that we can hide all
implementation details inside the function.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/arm/oprofile/common.c |    6 ++++--
 include/linux/oprofile.h   |    4 ++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/oprofile/common.c b/arch/arm/oprofile/common.c
index 1e971a7..4f67cfa 100644
--- a/arch/arm/oprofile/common.c
+++ b/arch/arm/oprofile/common.c
@@ -155,8 +155,10 @@ static void op_perf_stop(void)
 }
 
 
-static char *op_name_from_perf_id(enum arm_perf_pmu_ids id)
+char *op_name_from_perf_id(void)
 {
+	enum arm_perf_pmu_ids id = armpmu_get_pmu_id();
+
 	switch (id) {
 	case ARM_PERF_PMU_ID_XSCALE1:
 		return "arm/xscale1";
@@ -391,7 +393,7 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
 	ops->start		= op_arm_start;
 	ops->stop		= op_arm_stop;
 	ops->shutdown		= op_arm_stop;
-	ops->cpu_type		= op_name_from_perf_id(armpmu_get_pmu_id());
+	ops->cpu_type		= op_name_from_perf_id();
 
 	if (!ops->cpu_type)
 		ret = -ENODEV;
diff --git a/include/linux/oprofile.h b/include/linux/oprofile.h
index 5171639..1574d4a 100644
--- a/include/linux/oprofile.h
+++ b/include/linux/oprofile.h
@@ -185,4 +185,8 @@ int oprofile_add_data(struct op_entry *entry, unsigned long val);
 int oprofile_add_data64(struct op_entry *entry, u64 val);
 int oprofile_write_commit(struct op_entry *entry);
 
+#ifdef CONFIG_PERF_EVENTS
+char *op_name_from_perf_id(void);
+#endif /* CONFIG_PERF_EVENTS */
+
 #endif /* OPROFILE_H */
-- 
1.7.1

