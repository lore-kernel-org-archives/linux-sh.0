From: Matt Fleming <mjf@gentoo.org>
Date: Sun, 14 Dec 2008 12:02:26 +0000
Subject: [PATCH 3/5] sh: Convert Dreamcast support from hw_interrupt_type to irq_chip
Message-Id: <b9f8004cbf167b96cdd6f6e368e2ca2bf2f9965b.1229255348.git.mjf@gentoo.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Switch the dreamcast IRQ code over to the irq_chip way of doing things,
so that we can set GENERIC_HARDIRQS_NO__DO_IRQ for all SuperH boards.

Also, whilst I'm here change some things to make checkpatch.pl happy:
	- Indent with tabs, not with spaces
	- Include <linux/io.h>, not <asm/io.h>
	- Fix the multi-line comment style
	- Fix some typos in the comments

Tested-by: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Signed-off-by: Matt Fleming <mjf@gentoo.org>
---
 arch/sh/boards/mach-dreamcast/irq.c   |  192 +++++++++++++++------------------
 arch/sh/boards/mach-dreamcast/setup.c |    5 +-
 2 files changed, 91 insertions(+), 106 deletions(-)

diff --git a/arch/sh/boards/mach-dreamcast/irq.c b/arch/sh/boards/mach-dreamcast/irq.c
index 67bdc33..f55fc8e 100644
--- a/arch/sh/boards/mach-dreamcast/irq.c
+++ b/arch/sh/boards/mach-dreamcast/irq.c
@@ -10,106 +10,90 @@
  */
 
 #include <linux/irq.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <asm/irq.h>
 #include <mach/sysasic.h>
 
-/* Dreamcast System ASIC Hardware Events -
-
-   The Dreamcast's System ASIC (a.k.a. Holly) is responsible for receiving
-   hardware events from system peripherals and triggering an SH7750 IRQ.
-   Hardware events can trigger IRQs 13, 11, or 9 depending on which bits are
-   set in the Event Mask Registers (EMRs).  When a hardware event is
-   triggered, it's corresponding bit in the Event Status Registers (ESRs)
-   is set, and that bit should be rewritten to the ESR to acknowledge that
-   event.
-
-   There are three 32-bit ESRs located at 0xa05f8900 - 0xa05f6908.  Event
-   types can be found in include/asm-sh/dreamcast/sysasic.h. There are three
-   groups of EMRs that parallel the ESRs.  Each EMR group corresponds to an
-   IRQ, so 0xa05f6910 - 0xa05f6918 triggers IRQ 13, 0xa05f6920 - 0xa05f6928
-   triggers IRQ 11, and 0xa05f6930 - 0xa05f6938 triggers IRQ 9.
-
-   In the kernel, these events are mapped to virtual IRQs so that drivers can
-   respond to them as they would a normal interrupt.  In order to keep this
-   mapping simple, the events are mapped as:
-
-   6900/6910 - Events  0-31, IRQ 13
-   6904/6924 - Events 32-63, IRQ 11
-   6908/6938 - Events 64-95, IRQ  9
-
-*/
+/*
+ * Dreamcast System ASIC Hardware Events -
+ *
+ * The Dreamcast's System ASIC (a.k.a. Holly) is responsible for receiving
+ * hardware events from system peripherals and triggering an SH7750 IRQ.
+ * Hardware events can trigger IRQs 13, 11, or 9 depending on which bits are
+ * set in the Event Mask Registers (EMRs).  When a hardware event is
+ * triggered, its corresponding bit in the Event Status Registers (ESRs)
+ * is set, and that bit should be rewritten to the ESR to acknowledge that
+ * event.
+ *
+ * There are three 32-bit ESRs located at 0xa05f6900 - 0xa05f6908.  Event
+ * types can be found in arch/sh/include/mach-dreamcast/mach/sysasic.h.
+ * There are three groups of EMRs that parallel the ESRs.  Each EMR group
+ * corresponds to an IRQ, so 0xa05f6910 - 0xa05f6918 triggers IRQ 13,
+ * 0xa05f6920 - 0xa05f6928 triggers IRQ 11, and 0xa05f6930 - 0xa05f6938
+ * triggers IRQ 9.
+ *
+ * In the kernel, these events are mapped to virtual IRQs so that drivers can
+ * respond to them as they would a normal interrupt.  In order to keep this
+ * mapping simple, the events are mapped as:
+ *
+ * 6900/6910 - Events  0-31, IRQ 13
+ * 6904/6924 - Events 32-63, IRQ 11
+ * 6908/6938 - Events 64-95, IRQ  9
+ *
+ */
 
 #define ESR_BASE 0x005f6900    /* Base event status register */
 #define EMR_BASE 0x005f6910    /* Base event mask register */
 
-/* Helps us determine the EMR group that this event belongs to: 0 = 0x6910,
-   1 = 0x6920, 2 = 0x6930; also determine the event offset */
+/*
+ * Helps us determine the EMR group that this event belongs to: 0 = 0x6910,
+ * 1 = 0x6920, 2 = 0x6930; also determine the event offset.
+ */
 #define LEVEL(event) (((event) - HW_EVENT_IRQ_BASE) / 32)
 
 /* Return the hardware event's bit positon within the EMR/ESR */
 #define EVENT_BIT(event) (((event) - HW_EVENT_IRQ_BASE) & 31)
 
-/* For each of these *_irq routines, the IRQ passed in is the virtual IRQ
-   (logically mapped to the corresponding bit for the hardware event). */
+/*
+ * For each of these *_irq routines, the IRQ passed in is the virtual IRQ
+ * (logically mapped to the corresponding bit for the hardware event).
+ */
 
 /* Disable the hardware event by masking its bit in its EMR */
 static inline void disable_systemasic_irq(unsigned int irq)
 {
-        __u32 emr = EMR_BASE + (LEVEL(irq) << 4) + (LEVEL(irq) << 2);
-        __u32 mask;
+	__u32 emr = EMR_BASE + (LEVEL(irq) << 4) + (LEVEL(irq) << 2);
+	__u32 mask;
 
-        mask = inl(emr);
-        mask &= ~(1 << EVENT_BIT(irq));
-        outl(mask, emr);
+	mask = inl(emr);
+	mask &= ~(1 << EVENT_BIT(irq));
+	outl(mask, emr);
 }
 
 /* Enable the hardware event by setting its bit in its EMR */
 static inline void enable_systemasic_irq(unsigned int irq)
 {
-        __u32 emr = EMR_BASE + (LEVEL(irq) << 4) + (LEVEL(irq) << 2);
-        __u32 mask;
+	__u32 emr = EMR_BASE + (LEVEL(irq) << 4) + (LEVEL(irq) << 2);
+	__u32 mask;
 
-        mask = inl(emr);
-        mask |= (1 << EVENT_BIT(irq));
-        outl(mask, emr);
+	mask = inl(emr);
+	mask |= (1 << EVENT_BIT(irq));
+	outl(mask, emr);
 }
 
 /* Acknowledge a hardware event by writing its bit back to its ESR */
-static void ack_systemasic_irq(unsigned int irq)
-{
-        __u32 esr = ESR_BASE + (LEVEL(irq) << 2);
-        disable_systemasic_irq(irq);
-        outl((1 << EVENT_BIT(irq)), esr);
-}
-
-/* After a IRQ has been ack'd and responded to, it needs to be renabled */
-static void end_systemasic_irq(unsigned int irq)
-{
-        if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
-                enable_systemasic_irq(irq);
-}
-
-static unsigned int startup_systemasic_irq(unsigned int irq)
-{
-        enable_systemasic_irq(irq);
-
-        return 0;
-}
-
-static void shutdown_systemasic_irq(unsigned int irq)
+static void mask_ack_systemasic_irq(unsigned int irq)
 {
-        disable_systemasic_irq(irq);
+	__u32 esr = ESR_BASE + (LEVEL(irq) << 2);
+	disable_systemasic_irq(irq);
+	outl((1 << EVENT_BIT(irq)), esr);
 }
 
-struct hw_interrupt_type systemasic_int = {
-        .typename       = "System ASIC",
-        .startup        = startup_systemasic_irq,
-        .shutdown       = shutdown_systemasic_irq,
-        .enable         = enable_systemasic_irq,
-        .disable        = disable_systemasic_irq,
-        .ack            = ack_systemasic_irq,
-        .end            = end_systemasic_irq,
+struct irq_chip systemasic_int = {
+	.name		= "System ASIC",
+	.mask		= disable_systemasic_irq,
+	.mask_ack	= mask_ack_systemasic_irq,
+	.unmask		= enable_systemasic_irq,
 };
 
 /*
@@ -117,37 +101,37 @@ struct hw_interrupt_type systemasic_int = {
  */
 int systemasic_irq_demux(int irq)
 {
-        __u32 emr, esr, status, level;
-        __u32 j, bit;
-
-        switch (irq) {
-                case 13:
-                        level = 0;
-                        break;
-                case 11:
-                        level = 1;
-                        break;
-                case  9:
-                        level = 2;
-                        break;
-                default:
-                        return irq;
-        }
-        emr = EMR_BASE + (level << 4) + (level << 2);
-        esr = ESR_BASE + (level << 2);
-
-        /* Mask the ESR to filter any spurious, unwanted interrupts */
-        status = inl(esr);
-        status &= inl(emr);
-
-        /* Now scan and find the first set bit as the event to map */
-        for (bit = 1, j = 0; j < 32; bit <<= 1, j++) {
-                if (status & bit) {
-                        irq = HW_EVENT_IRQ_BASE + j + (level << 5);
-                        return irq;
-                }
-        }
-
-        /* Not reached */
-        return irq;
+	__u32 emr, esr, status, level;
+	__u32 j, bit;
+
+	switch (irq) {
+	case 13:
+		level = 0;
+		break;
+	case 11:
+		level = 1;
+		break;
+	case  9:
+		level = 2;
+		break;
+	default:
+		return irq;
+	}
+	emr = EMR_BASE + (level << 4) + (level << 2);
+	esr = ESR_BASE + (level << 2);
+
+	/* Mask the ESR to filter any spurious, unwanted interrupts */
+	status = inl(esr);
+	status &= inl(emr);
+
+	/* Now scan and find the first set bit as the event to map */
+	for (bit = 1, j = 0; j < 32; bit <<= 1, j++) {
+		if (status & bit) {
+			irq = HW_EVENT_IRQ_BASE + j + (level << 5);
+			return irq;
+		}
+	}
+
+	/* Not reached */
+	return irq;
 }
diff --git a/arch/sh/boards/mach-dreamcast/setup.c b/arch/sh/boards/mach-dreamcast/setup.c
index 7d944fc..d1bee48 100644
--- a/arch/sh/boards/mach-dreamcast/setup.c
+++ b/arch/sh/boards/mach-dreamcast/setup.c
@@ -28,7 +28,7 @@
 #include <asm/machvec.h>
 #include <mach/sysasic.h>
 
-extern struct hw_interrupt_type systemasic_int;
+extern struct irq_chip systemasic_int;
 extern void aica_time_init(void);
 extern int gapspci_init(void);
 extern int systemasic_irq_demux(int);
@@ -47,7 +47,8 @@ static void __init dreamcast_setup(char **cmdline_p)
 
 	/* Assign all virtual IRQs to the System ASIC int. handler */
 	for (i = HW_EVENT_IRQ_BASE; i < HW_EVENT_IRQ_MAX; i++)
-		irq_desc[i].chip = &systemasic_int;
+		set_irq_chip_and_handler(i, &systemasic_int,
+					 handle_level_irq);
 
 	board_time_init = aica_time_init;
 
-- 
1.5.6.4

