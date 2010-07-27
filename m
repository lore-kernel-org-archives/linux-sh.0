From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 27 Jul 2010 08:14:35 +0000
Subject: [PATCH] ARM: mach-shmobile: Runtime PM V3
Message-Id: <20100727081435.24558.96566.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This is the SH-Mobile ARM Runtime PM implementation V3.
Only clocks are managed at this point. If Runtime PM
is disabled then the clocks will be enabled before
->probe() and disabled after ->remove().

Signed-off-by: Magnus Damm <damm@opensource.se>
---
 Depends on "Driver core: Add BUS_NOTIFY_BIND_DRIVER"
 https://patchwork.kernel.org/patch/113865/

 Changes since V2:
 - make use of BUS_NOTIFY_BIND_DRIVER
 - clean up runtime-pm-disabled using BUS_NOTIFY_UNBOUND_DRIVER

 Changes since V1:
 - use devres for per-device data
 - support case of runtime pm disabled

 arch/arm/mach-shmobile/Makefile       |    2 
 arch/arm/mach-shmobile/clock-sh7372.c |    2 
 arch/arm/mach-shmobile/pm_runtime.c   |  169 +++++++++++++++++++++++++++++++++
 3 files changed, 171 insertions(+), 2 deletions(-)

--- 0001/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2010-07-27 16:15:37.000000000 +0900
@@ -3,7 +3,7 @@
 #
 
 # Common objects
-obj-y				:= timer.o console.o clock.o
+obj-y				:= timer.o console.o clock.o pm_runtime.o
 
 # CPU objects
 obj-$(CONFIG_ARCH_SH7367)	+= setup-sh7367.o clock-sh7367.o intc-sh7367.o
--- 0001/arch/arm/mach-shmobile/clock-sh7372.c
+++ work/arch/arm/mach-shmobile/clock-sh7372.c	2010-07-27 16:15:37.000000000 +0900
@@ -274,7 +274,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP201] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 1, 0), /* SCIFA3 */
 	[MSTP200] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 0, 0), /* SCIFA4 */
 	[MSTP329] = MSTP(&r_clk, SMSTPCR3, 29, 0), /* CMT10 */
-	[MSTP328] = MSTP(&div6_clks[DIV6_SPU], SMSTPCR3, 28, CLK_ENABLE_ON_INIT), /* FSIA */
+	[MSTP328] = MSTP(&div6_clks[DIV6_SPU], SMSTPCR3, 28, 0), /* FSIA */
 	[MSTP323] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR3, 23, 0), /* IIC1 */
 	[MSTP322] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR3, 22, 0), /* USB0 */
 	[MSTP314] = MSTP(&div4_clks[DIV4_HP], SMSTPCR3, 14, 0), /* SDHI0 */
--- /dev/null
+++ work/arch/arm/mach-shmobile/pm_runtime.c	2010-07-27 16:50:22.000000000 +0900
@@ -0,0 +1,169 @@
+/*
+ * arch/arm/mach-shmobile/pm_runtime.c
+ *
+ * Runtime PM support code for SuperH Mobile ARM
+ *
+ *  Copyright (C) 2009-2010 Magnus Damm
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/pm_runtime.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/sh_clk.h>
+#include <linux/bitmap.h>
+
+#ifdef CONFIG_PM_RUNTIME
+#define BIT_ONCE 0
+#define BIT_ACTIVE 1
+#define BIT_CLK_ENABLED 2
+
+struct pm_runtime_data {
+	unsigned long flags;
+	struct clk *clk;
+};
+
+static void __devres_release(struct device *dev, void *res)
+{
+	struct pm_runtime_data *prd = res;
+
+	dev_dbg(dev, "__devres_release()\n");
+
+	if (test_bit(BIT_CLK_ENABLED, &prd->flags))
+		clk_disable(prd->clk);
+
+	if (test_bit(BIT_ACTIVE, &prd->flags))
+		clk_put(prd->clk);
+}
+
+static struct pm_runtime_data *__to_prd(struct device *dev)
+{
+	return devres_find(dev, __devres_release, NULL, NULL);
+}
+
+static void platform_pm_runtime_init(struct device *dev,
+				     struct pm_runtime_data *prd)
+{
+	if (prd && !test_and_set_bit(BIT_ONCE, &prd->flags)) {
+		prd->clk = clk_get(dev, NULL);
+		if (!IS_ERR(prd->clk)) {
+			set_bit(BIT_ACTIVE, &prd->flags);
+			dev_info(dev, "clocks managed by runtime pm\n");
+		}
+	}
+}
+
+static void platform_pm_runtime_bug(struct device *dev,
+				    struct pm_runtime_data *prd)
+{
+	if (prd && !test_and_set_bit(BIT_ONCE, &prd->flags))
+		dev_err(dev, "runtime pm suspend before resume\n");
+}
+
+int platform_pm_runtime_suspend(struct device *dev)
+{
+	struct pm_runtime_data *prd = __to_prd(dev);
+
+	dev_dbg(dev, "platform_pm_runtime_suspend()\n");
+
+	platform_pm_runtime_bug(dev, prd);
+
+	if (prd && test_bit(BIT_ACTIVE, &prd->flags)) {
+		clk_disable(prd->clk);
+		clear_bit(BIT_CLK_ENABLED, &prd->flags);
+	}
+
+	return 0;
+}
+
+int platform_pm_runtime_resume(struct device *dev)
+{
+	struct pm_runtime_data *prd = __to_prd(dev);
+
+	dev_dbg(dev, "platform_pm_runtime_resume()\n");
+
+	platform_pm_runtime_init(dev, prd);
+
+	if (prd && test_bit(BIT_ACTIVE, &prd->flags)) {
+		clk_enable(prd->clk);
+		set_bit(BIT_CLK_ENABLED, &prd->flags);
+	}
+
+	return 0;
+}
+
+int platform_pm_runtime_idle(struct device *dev)
+{
+	/* suspend synchronously to disable clocks immediately */
+	return pm_runtime_suspend(dev);
+}
+
+static int platform_bus_notify(struct notifier_block *nb,
+			       unsigned long action, void *data)
+{
+	struct device *dev = data;
+	struct pm_runtime_data *prd;
+
+	dev_dbg(dev, "platform_bus_notify() %ld !\n", action);
+
+	if (action = BUS_NOTIFY_BIND_DRIVER) {
+		prd = devres_alloc(__devres_release, sizeof(*prd), GFP_KERNEL);
+		if (prd)
+			devres_add(dev, prd);
+		else
+			dev_err(dev, "unable to alloc memory for runtime pm\n");
+	}
+
+	return 0;
+}
+
+#else /* CONFIG_PM_RUNTIME */
+
+static int platform_bus_notify(struct notifier_block *nb,
+			       unsigned long action, void *data)
+{
+	struct device *dev = data;
+	struct clk *clk;
+
+	dev_dbg(dev, "platform_bus_notify() %ld !\n", action);
+
+	switch (action) {
+	case BUS_NOTIFY_BIND_DRIVER:
+		clk = clk_get(dev, NULL);
+		if (!IS_ERR(clk)) {
+			clk_enable(clk);
+			clk_put(clk);
+			dev_info(dev, "runtime pm disabled, clock forced on\n");
+		}
+		break;
+	case BUS_NOTIFY_UNBOUND_DRIVER:
+		clk = clk_get(dev, NULL);
+		if (!IS_ERR(clk)) {
+			clk_disable(clk);
+			clk_put(clk);
+			dev_info(dev, "runtime pm disabled, clock forced off\n");
+		}
+		break;
+	}
+
+	return 0;
+}
+
+#endif /* CONFIG_PM_RUNTIME */
+
+static struct notifier_block platform_bus_notifier = {
+	.notifier_call = platform_bus_notify
+};
+
+static int __init sh_pm_runtime_init(void)
+{
+	bus_register_notifier(&platform_bus_type, &platform_bus_notifier);
+	return 0;
+}
+core_initcall(sh_pm_runtime_init);
