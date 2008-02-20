From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 20 Feb 2008 11:03:36 +0000
Subject: [PATCH] sh: convert dreamcast irq code to ctrl_in/out
Message-Id: <20080220110336.7583.79505.sendpatchset@clockwork.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch converts the dreamcast irq code to ctrl_in/out operations. There
is no point in depending on the value of generic_io_base for code like this.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
Acked-by: Adrian McMenamin <adrian@mcmen.demon.co.uk>
---

 arch/sh/boards/dreamcast/irq.c |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

--- 0001/arch/sh/boards/dreamcast/irq.c
+++ work/arch/sh/boards/dreamcast/irq.c	2008-02-18 17:02:08.000000000 +0900
@@ -12,6 +12,7 @@
 #include <linux/irq.h>
 #include <asm/io.h>
 #include <asm/irq.h>
+#include <asm/addrspace.h>
 #include <asm/dreamcast/sysasic.h>
 
 /* Dreamcast System ASIC Hardware Events -
@@ -40,8 +41,8 @@
 
 */
 
-#define ESR_BASE 0x005f6900    /* Base event status register */
-#define EMR_BASE 0x005f6910    /* Base event mask register */
+#define ESR_BASE P2SEGADDR(0x005f6900)    /* Base event status register */
+#define EMR_BASE P2SEGADDR(0x005f6910)    /* Base event mask register */
 
 /* Helps us determine the EMR group that this event belongs to: 0 = 0x6910,
    1 = 0x6920, 2 = 0x6930; also determine the event offset */
@@ -59,9 +60,9 @@ static inline void disable_systemasic_ir
         __u32 emr = EMR_BASE + (LEVEL(irq) << 4) + (LEVEL(irq) << 2);
         __u32 mask;
 
-        mask = inl(emr);
+        mask = ctrl_inl(emr);
         mask &= ~(1 << EVENT_BIT(irq));
-        outl(mask, emr);
+        ctrl_outl(mask, emr);
 }
 
 /* Enable the hardware event by setting its bit in its EMR */
@@ -70,9 +71,9 @@ static inline void enable_systemasic_irq
         __u32 emr = EMR_BASE + (LEVEL(irq) << 4) + (LEVEL(irq) << 2);
         __u32 mask;
 
-        mask = inl(emr);
+        mask = ctrl_inl(emr);
         mask |= (1 << EVENT_BIT(irq));
-        outl(mask, emr);
+        ctrl_outl(mask, emr);
 }
 
 /* Acknowledge a hardware event by writing its bit back to its ESR */
@@ -80,7 +81,7 @@ static void ack_systemasic_irq(unsigned 
 {
         __u32 esr = ESR_BASE + (LEVEL(irq) << 2);
         disable_systemasic_irq(irq);
-        outl((1 << EVENT_BIT(irq)), esr);
+        ctrl_outl((1 << EVENT_BIT(irq)), esr);
 }
 
 /* After a IRQ has been ack'd and responded to, it needs to be renabled */
@@ -137,8 +138,8 @@ int systemasic_irq_demux(int irq)
         esr = ESR_BASE + (level << 2);
 
         /* Mask the ESR to filter any spurious, unwanted interrupts */
-        status = inl(esr);
-        status &= inl(emr);
+        status = ctrl_inl(esr);
+        status &= ctrl_inl(emr);
 
         /* Now scan and find the first set bit as the event to map */
         for (bit = 1, j = 0; j < 32; bit <<= 1, j++) {
