From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Mon, 06 Apr 2009 07:17:04 +0000
Subject: [PATCH] Added resume from hibernation support to the intc
Message-Id: <49D9AC70.3040001@st.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------020300010608060502080403"
List-Id: <linux-sh.vger.kernel.org>
To: linux-sh@vger.kernel.org

This is a multi-part message in MIME format.
--------------020300010608060502080403
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit



--------------020300010608060502080403
Content-Type: text/x-patch;
 name="0001-sh_intc-Added-resume-from-hibernation-support-to-th.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-sh_intc-Added-resume-from-hibernation-support-to-th.pat";
 filename*1="ch"

From 9d6047a32ebd72af6abae5ae2d6e7ea5e2447c25 Mon Sep 17 00:00:00 2001
From: Francesco Virlinzi <francesco.virlinzi@st.com>
Date: Mon, 6 Apr 2009 09:09:39 +0200
Subject: [PATCH] sh_intc: Added resume from hibernation support to the intc

It's required for all modules loaded in the previous runtime
session because not initilized duing the kernel start-up.

Signed-off-by: Francesco Virlinzi <francesco.virlinzi@st.com>
---
 drivers/sh/intc.c |   35 +++++++++++++++++++++++++++++++----
 1 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/sh/intc.c b/drivers/sh/intc.c
index 7fb9b5c..12d13d9 100644
--- a/drivers/sh/intc.c
+++ b/drivers/sh/intc.c
@@ -44,6 +44,7 @@ struct intc_handle_int {
 struct intc_desc_int {
 	struct list_head list;
 	struct sys_device sysdev;
+	pm_message_t state;
 	unsigned long *reg;
 #ifdef CONFIG_SMP
 	unsigned long *smp;
@@ -786,18 +787,44 @@ static int intc_suspend(struct sys_device *dev, pm_message_t state)
 	/* get intc controller associated with this sysdev */
 	d = container_of(dev, struct intc_desc_int, sysdev);
 
-	/* enable wakeup irqs belonging to this intc controller */
-	for_each_irq_desc(irq, desc) {
-		if ((desc->status & IRQ_WAKEUP) && (desc->chip == &d->chip))
-			intc_enable(irq);
+	switch (state.event) {
+	case PM_EVENT_ON:
+		if (d->state.event != PM_EVENT_FREEZE)
+			break;
+		for_each_irq_desc(irq, desc) {
+			if (desc->chip != &d->chip)
+				continue;
+			if (desc->status & IRQ_DISABLED)
+				intc_disable(irq);
+			else
+				intc_enable(irq);
+		}
+		break;
+	case PM_EVENT_FREEZE:
+		/* nothing has to be done */
+		break;
+	case PM_EVENT_SUSPEND:
+		/* enable wakeup irqs belonging to this intc controller */
+		for_each_irq_desc(irq, desc) {
+			if ((desc->status & IRQ_WAKEUP) && (desc->chip == &d->chip))
+				intc_enable(irq);
+		}
+		break;
 	}
+	d->state = state;
 
 	return 0;
 }
 
+static int intc_resume(struct sys_device *dev)
+{
+	return intc_suspend(dev, PMSG_ON);
+}
+
 static struct sysdev_class intc_sysdev_class = {
 	.name = "intc",
 	.suspend = intc_suspend,
+	.resume = intc_resume,
 };
 
 /* register this intc as sysdev to allow suspend/resume */
-- 
1.6.0.6


--------------020300010608060502080403--
