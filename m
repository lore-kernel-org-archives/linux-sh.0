From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 20 Jun 2012 08:01:30 +0000
Subject: [PATCH 01/11] ARM: mach-shmobile: add a temporary macro to define fixed voltage regulators
Message-Id: <1340179300-16452-2-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Providing fixed voltage permanently "on" regulators with different voltages
shares a lot of identical code. It will be eliminated, once the
regulator_register_fixed_volt() function becomes available. Until then we
introduce a macro to define such regulators. This helps reduce the amount
of added code in each platform file and keeps copy-paste errors to the
minumum.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/include/mach/regulator.h |   34 +++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/include/mach/regulator.h

diff --git a/arch/arm/mach-shmobile/include/mach/regulator.h b/arch/arm/mach-shmobile/include/mach/regulator.h
new file mode 100644
index 0000000..fe74995
--- /dev/null
+++ b/arch/arm/mach-shmobile/include/mach/regulator.h
@@ -0,0 +1,34 @@
+/*
+ * Temporary header until regulator_register_fixed_volt() is available.
+ * Licensed under GPLv2, see COPYING for details.
+ */
+
+#ifndef ASM_REGULATOR_H
+#define ASM_REGULATOR_H
+
+#include <linux/regulator/driver.h>
+#include <linux/regulator/fixed.h>
+#include <linux/regulator/machine.h>
+
+#define REGULATOR_FIXED(s, rid, v)					\
+static struct regulator_init_data fixed_power_init_data_ ## rid = {	\
+	.num_consumer_supplies  = ARRAY_SIZE(s),			\
+	.consumer_supplies      = (s),					\
+	.constraints.always_on	= 1,					\
+};									\
+static struct fixed_voltage_config fixed_power_info_ ## rid = {		\
+	.supply_name = "Fixed #" # rid,					\
+	.microvolts = (v),						\
+	.gpio = -EINVAL,						\
+	.init_data = &fixed_power_init_data_ ## rid,			\
+	.enabled_at_boot = 1,						\
+};									\
+static struct platform_device fixed_power_ ## rid = {			\
+	.name = "reg-fixed-voltage",					\
+	.id   = (rid),							\
+	.dev  = {							\
+		.platform_data = &fixed_power_info_ ## rid,		\
+	},								\
+}
+
+#endif
-- 
1.7.2.5

