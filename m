From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Wed, 18 Mar 2009 08:35:58 +0000
Subject: [Proposal][PATCH] Fixed the irq interrupt line after a resume from
Message-Id: <49C0B26E.7040201@st.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------070404030302080508060404"
List-Id: <linux-sh.vger.kernel.org>
To: linux-sh@vger.kernel.org

This is a multi-part message in MIME format.
--------------070404030302080508060404
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi all

Ad I said in a previous email the current hibernation suppont has a 
problem with
 every interrupt line enabled in the previous session by modules.

This kind of irq line after a resume will remain not initialized in the 
interrupt controller.

The attached patch is a hack to close the issue ( and it works).
I know it isn't a wonderful solution and it has to be taken as a 
momentary solution.
The right thing should be add sysdev device to the intc but it requires 
more work in the intc design.

Let me know.
Regards
 Francesco

--------------070404030302080508060404
Content-Type: text/x-patch;
 name="0002-sh_irq-Added-setup-irq-line-support-on-hibernation.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0002-sh_irq-Added-setup-irq-line-support-on-hibernation.patc";
 filename*1="h"

From 8dd0655b55843957a06f6d2297e07322570b647d Mon Sep 17 00:00:00 2001
From: Francesco Virlinzi <francesco.virlinzi@st.com>
Date: Wed, 18 Mar 2009 09:25:37 +0100
Subject: [PATCH] sh_irq: Added setup irq line support on hibernation

This patch fixes the irq line status after a resume from
hibernation. This is required for all the irq line required
from every module loaded during the runtime of previous session and
not initialized during the system boots.

Signed-off-by: Francesco Virlinzi <francesco.virlinzi@st.com>
---
 arch/sh/kernel/swsusp.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/swsusp.c b/arch/sh/kernel/swsusp.c
index 12b64a0..3f383a2 100644
--- a/arch/sh/kernel/swsusp.c
+++ b/arch/sh/kernel/swsusp.c
@@ -11,6 +11,8 @@
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/suspend.h>
+#include <linux/irqflags.h>
+#include <linux/irq.h>
 #include <asm/suspend.h>
 #include <asm/sections.h>
 #include <asm/tlbflush.h>
@@ -34,5 +36,28 @@ void save_processor_state(void)
 
 void restore_processor_state(void)
 {
+	int i;
+	unsigned long flags;
+	struct irq_desc *desc;
+	void (*irq_func)(unsigned int irq);
+
+	/* now restore the hw irq setting */
+	local_irq_save(flags);
+	for (i = 0; i < NR_IRQS; ++i) {
+		desc = &irq_desc[i];
+		if (desc->chip != &no_irq_chip && desc->action) {
+			irq_func = (desc->status & IRQ_DISABLED) ?
+				desc->chip->disable : desc->chip->enable;
+			spin_lock(&desc->lock);
+			desc->chip->startup(i);
+			irq_func(i);
+			if (desc->chip->set_wake)
+				desc->chip->set_wake(i,
+					((desc->status & IRQ_WAKEUP) ? 1 : 0));
+			spin_unlock(&desc->lock);
+		}       /* if.. */
+	}               /* for... */
+	local_irq_restore(flags);
+
 	local_flush_tlb_all();
 }
-- 
1.5.6.6


--------------070404030302080508060404--
