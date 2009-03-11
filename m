From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Wed, 11 Mar 2009 07:42:05 +0000
Subject: [PATCH] sh_clk: Added resume from hibernation support in the clk
Message-Id: <49B76B4D.60104@st.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------020105080602040504060503"
List-Id: <linux-sh.vger.kernel.org>
To: linux-sh@vger.kernel.org

This is a multi-part message in MIME format.
--------------020105080602040504060503
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit



--------------020105080602040504060503
Content-Type: text/x-patch;
 name="0003-sh_clk-Added-hibernation-support-in-the-clock-frame.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0003-sh_clk-Added-hibernation-support-in-the-clock-frame.pat";
 filename*1="ch"

From da85a159444a638aef1b1d83d9d786265febf8e2 Mon Sep 17 00:00:00 2001
From: Francesco Virlinzi <francesco.virlinzi@st.com>
Date: Wed, 11 Mar 2009 08:37:20 +0100
Subject: [PATCH] sh_clk: Added hibernation support in the clock framework

This patch adds the hibernation support in the clock framework

Signed-off-by: Francesco Virlinzi <francesco.virlinzi@st.com>
---
 arch/sh/kernel/cpu/clock.c |   65 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/cpu/clock.c b/arch/sh/kernel/cpu/clock.c
index 332a179..7ed0e45 100644
--- a/arch/sh/kernel/cpu/clock.c
+++ b/arch/sh/kernel/cpu/clock.c
@@ -20,6 +20,8 @@
 #include <linux/mutex.h>
 #include <linux/list.h>
 #include <linux/kref.h>
+#include <linux/kobject.h>
+#include <linux/sysdev.h>
 #include <linux/seq_file.h>
 #include <linux/err.h>
 #include <linux/platform_device.h>
@@ -358,6 +360,69 @@ static int show_clocks(char *buf, char **start, off_t off,
 	return p - buf;
 }
 
+#ifdef CONFIG_PM
+static int clks_sysdev_suspend(struct sys_device *dev, pm_message_t state)
+{
+	static pm_message_t prev_state;
+	struct clk *clkp;
+
+	switch (state.event) {
+	case PM_EVENT_ON:
+		/* Resumeing from hibernation */
+		if (prev_state.event == PM_EVENT_FREEZE) {
+			list_for_each_entry(clkp, &clock_list, node)
+				if (likely(clkp->ops)) {
+					if (likely(clkp->ops->set_parent))
+						clkp->ops->set_parent(clkp,
+							clkp->parent);
+					if (likely(clkp->ops->set_rate))
+						clkp->ops->set_rate(clkp,
+							clkp->rate, NO_CHANGE);
+					else if (likely(clkp->ops->recalc))
+						clkp->ops->recalc(clkp);
+					}
+		}
+		break;
+	case PM_EVENT_FREEZE:
+		break;
+	case PM_EVENT_SUSPEND:
+		break;
+	}
+
+	prev_state = state;
+	return 0;
+}
+
+static int clks_sysdev_resume(struct sys_device *dev)
+{
+	return clks_sysdev_suspend(dev, PMSG_ON);
+}
+
+static struct sysdev_class clks_sysdev_class = {
+	.name = "clks",
+};
+
+static struct sysdev_driver clks_sysdev_driver = {
+	.suspend = clks_sysdev_suspend,
+	.resume = clks_sysdev_resume,
+};
+
+static struct sys_device clks_sysdev_dev = {
+	.cls = &clks_sysdev_class,
+};
+
+static int __init clk_sysdev_init(void)
+{
+
+	sysdev_class_register(&clks_sysdev_class);
+	sysdev_driver_register(&clks_sysdev_class, &clks_sysdev_driver);
+	sysdev_register(&clks_sysdev_dev);
+	return 0;
+}
+
+subsys_initcall(clk_sysdev_init);
+#endif
+
 int __init clk_init(void)
 {
 	int i, ret = 0;
-- 
1.5.6.6


--------------020105080602040504060503--
