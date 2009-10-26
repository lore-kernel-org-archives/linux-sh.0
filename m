From: Matt Fleming <matt@console-pimps.org>
Date: Mon, 26 Oct 2009 22:19:49 +0000
Subject: [PATCH] sh: Annotate irq functions with "notrace"
Message-Id: <1256595589-15800-1-git-send-email-matt@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Now that SH's irqflags functions are out of line it becomes necessary to
mark them as "notrace" so that we don't try to trace them.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/sh/kernel/irq_32.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/kernel/irq_32.c b/arch/sh/kernel/irq_32.c
index b98a694..e33ab15 100644
--- a/arch/sh/kernel/irq_32.c
+++ b/arch/sh/kernel/irq_32.c
@@ -10,7 +10,7 @@
 #include <linux/irqflags.h>
 #include <linux/module.h>
 
-void raw_local_irq_restore(unsigned long flags)
+void notrace raw_local_irq_restore(unsigned long flags)
 {
 	unsigned long __dummy0, __dummy1;
 
@@ -40,7 +40,7 @@ void raw_local_irq_restore(unsigned long flags)
 }
 EXPORT_SYMBOL(raw_local_irq_restore);
 
-unsigned long __raw_local_save_flags(void)
+unsigned long notrace __raw_local_save_flags(void)
 {
 	unsigned long flags;
 
-- 
1.6.2.5

