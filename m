From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Wed, 11 Mar 2009 10:39:02 +0000
Subject: [Proposal][PATCH] sh: PMB hibernation support
Message-Id: <49B794C6.8000806@st.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------030709090901050105030308"
List-Id: <linux-sh.vger.kernel.org>
To: linux-sh@vger.kernel.org

This is a multi-part message in MIME format.
--------------030709090901050105030308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Paul
>
> Feel free to post what you already have, even if it doesn't apply. This
> sort of stuff by nature tends to take several iterations before it's in
> any shape to merge anyways.
>
>   
In attach there is a proposal on how manage the PMB after a resume from 
hibernation.
My assumption in background is that "just because the kernel runs.. the 
"core" PMB (main memory) are already ok"
In our kernel I'm doing something very similar.
I can say: it compiles but I have no way to really test this code as it is.

Regards
 Francesco

--------------030709090901050105030308
Content-Type: text/x-patch;
 name="0004-sh_mmu-Added-hibernation-support-in-the-PMB.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0004-sh_mmu-Added-hibernation-support-in-the-PMB.patch"

From f7ac0e9ecd48c8987a747968a79a94ac3f424adc Mon Sep 17 00:00:00 2001
From: Francesco Virlinzi <francesco.virlinzi@st.com>
Date: Wed, 11 Mar 2009 11:31:52 +0100
Subject: [PATCH] sh_mmu: Added hibernation support in the PMB


Signed-off-by: Francesco Virlinzi <francesco.virlinzi@st.com>
---
 arch/sh/mm/pmb.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/arch/sh/mm/pmb.c b/arch/sh/mm/pmb.c
index 8424167..b1a714a 100644
--- a/arch/sh/mm/pmb.c
+++ b/arch/sh/mm/pmb.c
@@ -15,6 +15,8 @@
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/sysdev.h>
+#include <linux/cpu.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/bitops.h>
@@ -402,3 +404,39 @@ static int __init pmb_debugfs_init(void)
 	return 0;
 }
 postcore_initcall(pmb_debugfs_init);
+
+#ifdef CONFIG_PM
+static int pmb_sysdev_suspend(struct sys_device *dev, pm_message_t state)
+{
+	static pm_message_t prev_state;
+
+	/* Restore the PMB after a resume from hibernation */
+	if (state.event == PM_EVENT_ON &&
+	    prev_state.event == PM_EVENT_FREEZE) {
+		struct pmb_entry *pmbe;
+		spin_lock_irq(&pmb_list_lock);
+		for (pmbe = pmb_list; pmbe; pmbe = pmbe->next)
+			set_pmb_entry(pmbe);
+		spin_unlock_irq(&pmb_list_lock);
+	}
+	prev_state = state;
+	return 0;
+}
+
+static int pmb_sysdev_resume(struct sys_device *dev)
+{
+	return pmb_sysdev_suspend(dev, PMSG_ON);
+}
+
+static struct sysdev_driver pmb_sysdev_driver = {
+	.suspend = pmb_sysdev_suspend,
+	.resume = pmb_sysdev_resume,
+};
+
+static int __init pmb_sysdev_init(void)
+{
+	return sysdev_driver_register(&cpu_sysdev_class, &pmb_sysdev_driver);
+}
+
+subsys_initcall(pmb_sysdev_init);
+#endif
-- 
1.5.6.6


--------------030709090901050105030308--
