From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 11 Nov 2011 02:47:26 +0000
Subject: [PATCH 19/20] ARM: mach-shmobile: bonito: add FPGA irq demux
Message-Id: <87aa839xz8.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-bonito.c |   78 +++++++++++++++++++++++++++++++++
 1 files changed, 78 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bonito.c b/arch/arm/mach-shmobile/board-bonito.c
index 5b01476..fe749e3 100644
--- a/arch/arm/mach-shmobile/board-bonito.c
+++ b/arch/arm/mach-shmobile/board-bonito.c
@@ -26,6 +26,7 @@
 #include <linux/irq.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
+#include <linux/smsc911x.h>
 #include <mach/common.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -75,14 +76,25 @@
 /*
  * FPGA
  */
+#define IRQSR0		0x0020
+#define IRQSR1		0x0022
+#define IRQMR0		0x0030
+#define IRQMR1		0x0032
 #define BUSSWMR1	0x0070
 #define BUSSWMR2	0x0072
 #define BUSSWMR3	0x0074
 #define BUSSWMR4	0x0076
 
 #define LCDCR		0x10B4
+#define DEVRSTCR1	0x10D0
+#define DEVRSTCR2	0x10D2
 #define A1MDSR		0x10E0
 #define BVERR		0x1100
+
+/* FPGA IRQ */
+#define FPGA_IRQ_BASE		(512)
+#define FPGA_IRQ0		(FPGA_IRQ_BASE)
+#define FPGA_IRQ1		(FPGA_IRQ_BASE + 16)
 static u16 bonito_fpga_read(u32 offset)
 {
 	return __raw_readw(0xf0003000 + offset);
@@ -93,6 +105,71 @@ static void bonito_fpga_write(u32 offset, u16 val)
 	__raw_writew(val, 0xf0003000 + offset);
 }
 
+static void bonito_fpga_irq_disable(struct irq_data *data)
+{
+	unsigned int irq = data->irq;
+	u32 addr = (irq < 1016) ? IRQMR0 : IRQMR1;
+	int shift = irq % 16;
+
+	bonito_fpga_write(addr, bonito_fpga_read(addr) | (1 << shift));
+}
+
+static void bonito_fpga_irq_enable(struct irq_data *data)
+{
+	unsigned int irq = data->irq;
+	u32 addr = (irq < 1016) ? IRQMR0 : IRQMR1;
+	int shift = irq % 16;
+
+	bonito_fpga_write(addr, bonito_fpga_read(addr) & ~(1 << shift));
+}
+
+static struct irq_chip bonito_fpga_irq_chip __read_mostly = {
+	.name		= "bonito FPGA",
+	.irq_mask	= bonito_fpga_irq_disable,
+	.irq_unmask	= bonito_fpga_irq_enable,
+};
+
+static void bonito_fpga_irq_demux(unsigned int irq, struct irq_desc *desc)
+{
+	u32 val =  bonito_fpga_read(IRQSR1) << 16 |
+		   bonito_fpga_read(IRQSR0);
+	u32 mask = bonito_fpga_read(IRQMR1) << 16 |
+		   bonito_fpga_read(IRQMR0);
+
+	int i;
+
+	val &= ~mask;
+
+	for (i = 0; i < 32; i++) {
+		if (!(val & (1 << i)))
+			continue;
+
+		generic_handle_irq(FPGA_IRQ_BASE + i);
+	}
+}
+
+static void bonito_fpga_init(void)
+{
+	int i;
+
+	bonito_fpga_write(IRQMR0, 0xffff); /* mask all */
+	bonito_fpga_write(IRQMR1, 0xffff); /* mask all */
+
+	/* Device reset */
+	bonito_fpga_write(DEVRSTCR1,
+		   (1 << 2));	/* Eth */
+
+	/* FPGA irq require special handling */
+	for (i = FPGA_IRQ_BASE; i < FPGA_IRQ_BASE + 32; i++) {
+		irq_set_chip_and_handler_name(i, &bonito_fpga_irq_chip,
+					      handle_level_irq, "level");
+		set_irq_flags(i, IRQF_VALID); /* yuck */
+	}
+
+	irq_set_chained_handler(evt2irq(0x0340), bonito_fpga_irq_demux);
+	irq_set_irq_type(evt2irq(0x0340), IRQ_TYPE_LEVEL_LOW);
+}
+
 /*
 * PMIC settings
 *
@@ -274,6 +351,7 @@ static void __init bonito_init(void)
 	u16 val;
 
 	r8a7740_pinmux_init();
+	bonito_fpga_init();
 
 	pmic_settings = pmic_do_2A;
 
-- 
1.7.5.4

