From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 28 Mar 2012 06:40:42 +0000
Subject: [PATCH 03/06] ARM: mach-shmobile: Introduce INTC_IRQ_PINS_16H
Message-Id: <20120328064042.28557.17936.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add INTC_IRQ_PINS_16H to allow broken out support of the
the high 16 external interrupt pins. On SoCs with 32 external
interrupt pins the interrupt vectors for the low 16 and the
high 16 interrupt pins are sparesly populated. The low 16 are
at 0x0200 and high 16 are at 0x3200 which with current macros
results in a separation of 384 linux interrupts. This sparse
population makes it unsuitable with a single IRQ domain to
cover the full IRQ range, so this macro breaks out the 32 pins
into two separate 16 bit controllers to allow two independent
INTC instances with two separate IRQ domains.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/include/mach/intc.h |   44 ++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

--- 0001/arch/arm/mach-shmobile/include/mach/intc.h
+++ work/arch/arm/mach-shmobile/include/mach/intc.h	2012-03-27 17:23:22.000000000 +0900
@@ -142,6 +142,50 @@ static struct intc_desc p ## _desc __ini
 			     p ## _sense_registers, p ## _ack_registers) \
 }
 
+#define INTC_IRQ_PINS_16H(p, base, vect, str)				\
+									\
+static struct resource p ## _resources[] __initdata = {			\
+	[0] = {								\
+		.start	= base,						\
+		.end	= base + 0x64,					\
+		.flags	= IORESOURCE_MEM,				\
+	},								\
+};									\
+									\
+enum {									\
+	p ## _UNUSED = 0,						\
+	INTC_IRQ_PINS_ENUM_16H(p),					\
+};									\
+									\
+static struct intc_vect p ## _vectors[] __initdata = {			\
+	INTC_IRQ_PINS_VECT_16H(p, vect),				\
+};									\
+									\
+static struct intc_mask_reg p ## _mask_registers[] __initdata = {	\
+	INTC_IRQ_PINS_MASK_16H(p, base),				\
+};									\
+									\
+static struct intc_prio_reg p ## _prio_registers[] __initdata = {	\
+	INTC_IRQ_PINS_PRIO_16H(p, base),				\
+};									\
+									\
+static struct intc_sense_reg p ## _sense_registers[] __initdata = {	\
+	INTC_IRQ_PINS_SENSE_16H(p, base),				\
+};									\
+									\
+static struct intc_mask_reg p ## _ack_registers[] __initdata = {	\
+	INTC_IRQ_PINS_ACK_16H(p, base),					\
+};									\
+									\
+static struct intc_desc p ## _desc __initdata = {			\
+	.name = str,							\
+	.resource = p ## _resources,					\
+	.num_resources = ARRAY_SIZE(p ## _resources),			\
+	.hw = INTC_HW_DESC(p ## _vectors, NULL,				\
+			     p ## _mask_registers, p ## _prio_registers, \
+			     p ## _sense_registers, p ## _ack_registers) \
+}
+
 #define INTC_IRQ_PINS_32(p, base, vect, str)				\
 									\
 static struct resource p ## _resources[] __initdata = {			\
