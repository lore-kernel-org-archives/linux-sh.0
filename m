From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 25 Apr 2014 16:58:44 +0000
Subject: [PATCH] [RFC] ARM: shmobile: Enable shmobile Runtime PM from MSTP clock driver
Message-Id: <1398445124-16828-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On shmobile multi-platform using the Common Clock Framework, enable
shmobile Runtime PM from the MSTP clock driver, to make sure the bus clocks
are enabled for all devices.

On ARCH_SHMOBILE_LEGACY, this is done unconditionally, from the shmobile
Runtime PM code itself.
On ARCH_SHMOBILE_MULTI, this was missing, leading to disabled clocks,
depending on implicit reset state or on the bootloader.

The external declaration of sh_pm_runtime_enable() in clk-mstp.c is
needed because arch/arm/mach-shmobile/include/mach/common.h can't be
included from driver code.

More calls to sh_pm_runtime_enable() will have to be added to other gate
clock drivers, when the corresponding SoC platform code is converted to
multi-platform and CCF.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This applies on top of patches 4-7 (1-3 have been applied by Simon) of
series "[PATCH v2 00/17] ARM: shmobile: Enable drivers/sh/pm_runtime.c on
multi-platform]".

 drivers/clk/shmobile/clk-mstp.c |    3 +++
 drivers/sh/pm_runtime.c         |   20 ++++++++++++--------
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/shmobile/clk-mstp.c b/drivers/clk/shmobile/clk-mstp.c
index 2e3c08fff173..da2e6dcf8fed 100644
--- a/drivers/clk/shmobile/clk-mstp.c
+++ b/drivers/clk/shmobile/clk-mstp.c
@@ -161,6 +161,9 @@ static void __init cpg_mstp_clocks_init(struct device_node *np)
 	struct mstp_clock_group *group;
 	struct clk **clks;
 	unsigned int i;
+	extern void sh_pm_runtime_enable(void);
+
+	sh_pm_runtime_enable();
 
 	group = kzalloc(sizeof(*group), GFP_KERNEL);
 	clks = kmalloc(MSTP_MAX_CLOCKS * sizeof(*clks), GFP_KERNEL);
diff --git a/drivers/sh/pm_runtime.c b/drivers/sh/pm_runtime.c
index 3ec047ac1ff4..59d8b5fd558e 100644
--- a/drivers/sh/pm_runtime.c
+++ b/drivers/sh/pm_runtime.c
@@ -75,20 +75,24 @@ static struct pm_clk_notifier_block platform_bus_notifier = {
 	.con_ids = { NULL, },
 };
 
-static bool default_pm_on;
+#if defined(CONFIG_SUPERH) || defined(CONFIG_ARCH_SHMOBILE_LEGACY)
+bool default_pm_on = true;
+#else
+bool default_pm_on;
+#endif
 
-int __init sh_pm_runtime_init(void)
+void __init sh_pm_runtime_enable(void)
 {
-	if (default_pm_on)
-		return 0;
-
 	default_pm_on = true;
-	pm_clk_add_notifier(&platform_bus_type, &platform_bus_notifier);
+}
+
+static int __init sh_pm_runtime_init(void)
+{
+	if (default_pm_on)
+		pm_clk_add_notifier(&platform_bus_type, &platform_bus_notifier);
 	return 0;
 }
-#if defined(CONFIG_SUPERH) || defined(CONFIG_ARCH_SHMOBILE_LEGACY)
 core_initcall(sh_pm_runtime_init);
-#endif
 
 static int __init sh_pm_runtime_late_init(void)
 {
-- 
1.7.9.5

