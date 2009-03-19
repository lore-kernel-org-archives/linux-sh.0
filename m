From: Steve Glendinning <steve.glendinning@smsc.com>
Date: Thu, 19 Mar 2009 10:42:41 +0000
Subject: [PATCH 1/2] sh: add support for SMSC Polaris platform
Message-Id: <1237459362-5204-1-git-send-email-steve.glendinning@smsc.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Polaris is an SMSC reference platform with a SH7709S CPU and LAN9118
ethernet controller.  This patch adds support for it.

Signed-off-by: Steve Glendinning <steve.glendinning@smsc.com>
---
 arch/sh/boards/Kconfig         |    7 ++
 arch/sh/boards/Makefile        |    1 +
 arch/sh/boards/board-polaris.c |  160 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 168 insertions(+), 0 deletions(-)
 create mode 100644 arch/sh/boards/board-polaris.c

diff --git a/arch/sh/boards/Kconfig b/arch/sh/boards/Kconfig
index 48c043b..dcc1af8 100644
--- a/arch/sh/boards/Kconfig
+++ b/arch/sh/boards/Kconfig
@@ -261,6 +261,13 @@ config SH_CAYMAN
 	depends on CPU_SUBTYPE_SH5_101 || CPU_SUBTYPE_SH5_103
 	select SYS_SUPPORTS_PCI
 
+config SH_POLARIS
+	bool "SMSC Polaris"
+	select CPU_HAS_IPR_IRQ
+	depends on CPU_SUBTYPE_SH7709
+	help
+	  Select if configuring for an SMSC Polaris development board
+
 endmenu
 
 source "arch/sh/boards/mach-r2d/Kconfig"
diff --git a/arch/sh/boards/Makefile b/arch/sh/boards/Makefile
index d0daebc..7baa210 100644
--- a/arch/sh/boards/Makefile
+++ b/arch/sh/boards/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_SH_URQUELL)	+= board-urquell.o
 obj-$(CONFIG_SH_SHMIN)		+= board-shmin.o
 obj-$(CONFIG_SH_EDOSK7760)	+= board-edosk7760.o
 obj-$(CONFIG_SH_ESPT)		+= board-espt.o
+obj-$(CONFIG_SH_POLARIS)	+= board-polaris.o
diff --git a/arch/sh/boards/board-polaris.c b/arch/sh/boards/board-polaris.c
new file mode 100644
index 0000000..b944b8b
--- /dev/null
+++ b/arch/sh/boards/board-polaris.c
@@ -0,0 +1,160 @@
+/*
+ * linux/arch/sh/boards/se/770x/polaris.c
+ *
+ * June 2006 steve.glendinning@smsc.com
+ *
+ * Polaris-specific resource declaration
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/platform_device.h>
+#include <linux/smsc911x.h>
+#include <asm/irq.h>
+#include <asm/io.h>
+#include <asm/machvec.h>
+#include <asm/heartbeat.h>
+#include <cpu/gpio.h>
+#include <mach-se/mach/se.h>
+
+#define BCR2		(0xFFFFFF62)
+#define WCR2		(0xFFFFFF66)
+#define AREA5_WAIT_CTRL	(0x1C00)
+#define WAIT_STATES_10	(0x7)
+
+static struct resource smsc911x_resources[] = {
+	[0] = {
+		.name		= "smsc911x-memory",
+		.start		= PA_EXT5,
+		.end		= PA_EXT5 + 0x1fff,
+		.flags		= IORESOURCE_MEM,
+	},	[1] = {
+		.name		= "smsc911x-irq",
+		.start		= IRQ0_IRQ,
+		.end		= IRQ0_IRQ,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct smsc911x_platform_config smsc911x_config = {
+        .irq_polarity = SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
+        .irq_type = SMSC911X_IRQ_TYPE_OPEN_DRAIN,
+	.flags = SMSC911X_USE_32BIT,
+	.phy_interface = PHY_INTERFACE_MODE_MII,
+};
+
+static struct platform_device smsc911x_device = {
+	.name		= "smsc911x",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(smsc911x_resources),
+	.resource	= smsc911x_resources,
+	.dev = {
+		.platform_data = &smsc911x_config,
+	},
+};
+
+static unsigned char heartbeat_bit_pos[] = { 0, 1, 2, 3 };
+
+static struct heartbeat_data heartbeat_data = {
+	.bit_pos	= heartbeat_bit_pos,
+	.nr_bits	= ARRAY_SIZE(heartbeat_bit_pos),
+	.regsize	= 8,
+};
+
+static struct resource heartbeat_resources[] = {
+	[0] = {
+		.start	= PORT_PCDR,
+		.end	= PORT_PCDR,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device heartbeat_device = {
+	.name		= "heartbeat",
+	.id		= -1,
+	.dev	= {
+		.platform_data	= &heartbeat_data,
+	},
+	.num_resources	= ARRAY_SIZE(heartbeat_resources),
+	.resource	= heartbeat_resources,
+};
+
+static struct platform_device *polaris_devices[] __initdata = {
+	&smsc911x_device,
+	&heartbeat_device,
+};
+
+static int __init polaris_initialise(void)
+{
+	u16 wcr, bcr_mask;
+
+	printk(KERN_INFO "Configuring Polaris external bus\n");
+
+	/* Configure area 5 with 2 wait states */
+	wcr = ctrl_inw(WCR2);
+	wcr &= (~AREA5_WAIT_CTRL);
+	wcr |= (WAIT_STATES_10 << 10);
+	ctrl_outw(wcr, WCR2);
+
+	bcr_mask = ctrl_inw(BCR2);
+
+	/* The polaris platform has a DIP switch fitted, whose setting defines
+	 * whether the LAN9118 is to be used in 32-bit mode.  We should detect
+	 * its value here and set this accordingly, but for now assume 32-bit */
+#if 0
+	/* Configure area 5 for 16-bit access */
+	bcr_mask &= ~(1 << 10);
+#else
+	/* Configure area 5 for 32-bit access */
+	bcr_mask |= 1 << 10;
+#endif
+
+	ctrl_outw(bcr_mask, BCR2);
+
+	return platform_add_devices(polaris_devices,
+				    ARRAY_SIZE(polaris_devices));
+}
+arch_initcall(polaris_initialise);
+
+static struct ipr_data ipr_irq_table[] = {
+	/* External IRQs */
+	{ IRQ0_IRQ, 0,  0,  1, },	/* IRQ0 */
+	{ IRQ1_IRQ, 0,  4,  1, },	/* IRQ1 */
+};
+
+static unsigned long ipr_offsets[] = {
+	INTC_IPRC
+};
+
+static struct ipr_desc ipr_irq_desc = {
+	.ipr_offsets	= ipr_offsets,
+	.nr_offsets	= ARRAY_SIZE(ipr_offsets),
+
+	.ipr_data	= ipr_irq_table,
+	.nr_irqs	= ARRAY_SIZE(ipr_irq_table),
+	.chip = {
+		.name	= "sh7709-ext",
+	},
+};
+
+static void __init init_polaris_irq(void)
+{
+	/* Disable all interrupts */
+	ctrl_outw(0, BCR_ILCRA);
+	ctrl_outw(0, BCR_ILCRB);
+	ctrl_outw(0, BCR_ILCRC);
+	ctrl_outw(0, BCR_ILCRD);
+	ctrl_outw(0, BCR_ILCRE);
+	ctrl_outw(0, BCR_ILCRF);
+	ctrl_outw(0, BCR_ILCRG);
+
+	register_ipr_controller(&ipr_irq_desc);
+}
+
+static struct sh_machine_vector mv_polaris __initmv = {
+	.mv_name		= "Polaris",
+	.mv_nr_irqs		= 61,
+	.mv_init_irq		= init_polaris_irq,
+};
-- 
1.6.0.6

