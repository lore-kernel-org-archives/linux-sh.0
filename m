From: Matt Fleming <mjf@gentoo.org>
Date: Sun, 14 Dec 2008 12:02:25 +0000
Subject: [PATCH 2/5] sh: Convert SystemH board support from hw_interrupt_type to irq_chip
Message-Id: <8430243118097441919b3260ee9b0bfe34877ed1.1229255348.git.mjf@gentoo.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

... as part of the hw_interrupt_type to irq_chip crusade.

Signed-off-by: Matt Fleming <mjf@gentoo.org>
---
 arch/sh/boards/mach-systemh/irq.c |   37 ++++++-------------------------------
 1 files changed, 6 insertions(+), 31 deletions(-)

diff --git a/arch/sh/boards/mach-systemh/irq.c b/arch/sh/boards/mach-systemh/irq.c
index 5384068..986a0e7 100644
--- a/arch/sh/boards/mach-systemh/irq.c
+++ b/arch/sh/boards/mach-systemh/irq.c
@@ -12,8 +12,8 @@
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 
-#include <asm/io.h>
 #include <mach/systemh7751.h>
 #include <asm/smc37c93x.h>
 
@@ -24,35 +24,17 @@ static unsigned long *systemh_irq_mask_register = (unsigned long *)0xB3F10004;
 static unsigned long *systemh_irq_request_register = (unsigned long *)0xB3F10000;
 
 /* forward declaration */
-static unsigned int startup_systemh_irq(unsigned int irq);
-static void shutdown_systemh_irq(unsigned int irq);
 static void enable_systemh_irq(unsigned int irq);
 static void disable_systemh_irq(unsigned int irq);
 static void mask_and_ack_systemh(unsigned int);
-static void end_systemh_irq(unsigned int irq);
 
-/* hw_interrupt_type */
-static struct hw_interrupt_type systemh_irq_type = {
-	.typename = " SystemH Register",
-	.startup = startup_systemh_irq,
-	.shutdown = shutdown_systemh_irq,
-	.enable = enable_systemh_irq,
-	.disable = disable_systemh_irq,
+static struct irq_chip systemh_irq_type = {
+	.name = " SystemH Register",
+	.unmask = enable_systemh_irq,
+	.mask = disable_systemh_irq,
 	.ack = mask_and_ack_systemh,
-	.end = end_systemh_irq
 };
 
-static unsigned int startup_systemh_irq(unsigned int irq)
-{
-	enable_systemh_irq(irq);
-	return 0; /* never anything pending */
-}
-
-static void shutdown_systemh_irq(unsigned int irq)
-{
-	disable_systemh_irq(irq);
-}
-
 static void disable_systemh_irq(unsigned int irq)
 {
 	if (systemh_irq_mask_register) {
@@ -86,16 +68,9 @@ static void mask_and_ack_systemh(unsigned int irq)
 	disable_systemh_irq(irq);
 }
 
-static void end_systemh_irq(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
-		enable_systemh_irq(irq);
-}
-
 void make_systemh_irq(unsigned int irq)
 {
 	disable_irq_nosync(irq);
-	irq_desc[irq].chip = &systemh_irq_type;
+	set_irq_chip_and_handler(irq, &systemh_irq_type, handle_level_irq);
 	disable_systemh_irq(irq);
 }
-
-- 
1.5.6.4

