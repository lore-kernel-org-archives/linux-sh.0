From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Tue, 10 Mar 2009 13:19:50 +0000
Subject: Re: [PATCH] sh: hibernation support
Message-Id: <49B668F6.3020405@st.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------040908000903060404060300"
List-Id: <linux-sh.vger.kernel.org>
References: <20090306064156.27281.35572.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090306064156.27281.35572.sendpatchset@rx1.opensource.se>
To: linux-sh@vger.kernel.org

This is a multi-part message in MIME format.
--------------040908000903060404060300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Magnus
In the clock framework I would propose the attached solution
Regards
 Francesco
Magnus Damm ha scritto:
> On Mon, Mar 9, 2009 at 7:03 PM, Francesco VIRLINZI
> <francesco.virlinzi@st.com> wrote:
>   
>> I'm sorry if I'm stressing you but you will have similar problem also with
>> the clock framework.
>> A simple
>> -  clk_get_rate(...)
>> could return a wrong value if in the previous session someone changed the
>> clock rate (from init value) and
>> you don't force again in the hw the resumed "clk->rate".
>>     
>
> Yeah, the clock framework needs more work. =)
>
> / magnus
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>   


--------------040908000903060404060300
Content-Type: text/x-patch;
 name="0003-sh_clk-Added-clks-sysdevice-to-support-hibernation.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0003-sh_clk-Added-clks-sysdevice-to-support-hibernation.patc";
 filename*1="h"

From 7d2249e98d304181b3deaa806ee475873e822328 Mon Sep 17 00:00:00 2001
From: Francesco Virlinzi <francesco.virlinzi@st.com>
Date: Tue, 10 Mar 2009 10:23:23 +0100
Subject: [PATCH] sh_clk: Added clks sysdevice to support hibernation

This patch adds the clk_sysdev device to restore the right clocks
 setting after a resume from hibernation.

Signed-off-by: Francesco Virlinzi <francesco.virlinzi@st.com>
---
 arch/sh/kernel/cpu/clock.c |   62 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 62 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/cpu/clock.c b/arch/sh/kernel/cpu/clock.c
index dc53def..06fcbf0 100644
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
@@ -382,6 +384,56 @@ static int show_clocks(char *buf, char **start, off_t off,
 	return p - buf;
 }
 
+static int clks_suspend(struct sys_device *dev, pm_message_t state)
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
+					if (likely(clkp->ops->recalc))
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
+static int clks_resume(struct sys_device *dev)
+{
+	return clks_suspend(dev, PMSG_ON);
+}
+
+static struct sysdev_class clks_class = {
+	.kset.kobj.name = "clks",
+};
+
+static struct sysdev_driver clks_driver = {
+	.suspend = clks_suspend,
+	.resume = clks_resume,
+};
+
+static struct sys_device clks_dev = {
+	.cls = &clks_class,
+};
+
 int __init clk_init(void)
 {
 	int i, ret = 0;
@@ -404,6 +456,16 @@ int __init clk_init(void)
 	return ret;
 }
 
+static int __init clk_sysdev_init(void)
+{
+
+	sysdev_class_register(&clks_class);
+	sysdev_driver_register(&clks_class, &clks_driver);
+	sysdev_register(&clks_dev);
+	return 0;
+}
+subsys_initcall(clk_sysdev_init);
+
 static int __init clk_proc_init(void)
 {
 	struct proc_dir_entry *p;
-- 
1.5.6.6


--------------040908000903060404060300--
