From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Wed, 04 Mar 2009 00:55:45 +0000
Subject: [PATCH v2] Add OHCI USB support for SH7786
Message-Id: <uzlg2yu02.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
v1 -> v2

o use DMA_BIT_MASK
o add document
o use __raw_write/read
o use MACRO for mask, bit definition
o use cpu_relax while waiting
o sh7786_devices_setup call sh7786_usb_setup


 arch/sh/kernel/cpu/sh4a/setup-sh7786.c |   75 ++++++++++++++++++++++++++++++++
 drivers/usb/Kconfig                    |    1 +
 drivers/usb/host/ohci-hcd.c            |    3 +-
 3 files changed, 78 insertions(+), 1 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
index ca5d987..557de0e 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
@@ -18,6 +18,7 @@
 #include <linux/serial_sci.h>
 #include <linux/io.h>
 #include <linux/mm.h>
+#include <linux/dma-mapping.h>
 #include <asm/mmzone.h>
 
 static struct plat_sci_port sci_platform_data[] = {
@@ -68,12 +69,86 @@ static struct platform_device sci_device = {
 	},
 };
 
+static struct resource usb_ohci_resources[] = {
+	[0] = {
+		.start	= 0xffe70400,
+		.end	= 0xffe704ff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 77,
+		.end	= 77,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static u64 usb_ohci_dma_mask = DMA_BIT_MASK(32);
+static struct platform_device usb_ohci_device = {
+	.name		= "sh_ohci",
+	.id		= -1,
+	.dev = {
+		.dma_mask		= &usb_ohci_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+	.num_resources	= ARRAY_SIZE(usb_ohci_resources),
+	.resource	= usb_ohci_resources,
+};
+
 static struct platform_device *sh7786_devices[] __initdata = {
 	&sci_device,
+	&usb_ohci_device,
 };
 
+
+/*
+ * Please call this function if your platform board
+ * use external clock for USB
+ * */
+#define USBCTL0		0xffe70858
+#define CLOCK_MODE_MASK 0xffffff7f
+#define EXT_CLOCK_MODE  0x00000080
+void __init sh7786_usb_use_exclock(void)
+{
+	u32 val = __raw_readl(USBCTL0) & CLOCK_MODE_MASK;
+	__raw_writel(val | EXT_CLOCK_MODE, USBCTL0);
+}
+
+#define USBPCTL1	0xffe70804
+#define USBST		0xffe70808
+#define PHY_ENB		0x00000001
+#define PLL_ENB		0x00000002
+#define PHY_RST		0x00000004
+#define ACT_PLL_STATUS	0xc0000000
+static void __init sh7786_usb_setup(void)
+{
+	int i = 1000000;
+
+	/*
+	 * USB initial settings
+	 *
+	 * The following settings are necessary
+	 * for using the USB modules.
+	 */
+	__raw_writel(0x00ff0040, 0xffe70094);
+	__raw_writel(0x00000001, 0xffe7009c);
+
+	/*
+	 * Set the PHY and PLL enable bit
+	 */
+	__raw_writel(PHY_ENB | PLL_ENB, USBPCTL1);
+	while (i-- &&
+	       ((__raw_readl(USBST) & ACT_PLL_STATUS) != ACT_PLL_STATUS))
+		cpu_relax();
+
+	/* Set the PHY RST bit */
+	__raw_writel(PHY_ENB | PLL_ENB | PHY_RST, USBPCTL1);
+
+	printk(KERN_INFO "sh7786 usb setup done\n");
+}
+
 static int __init sh7786_devices_setup(void)
 {
+	sh7786_usb_setup();
 	return platform_add_devices(sh7786_devices,
 				    ARRAY_SIZE(sh7786_devices));
 }
diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 83babb0..c6c816b 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -47,6 +47,7 @@ config USB_ARCH_HAS_OHCI
 	default y if CPU_SUBTYPE_SH7720
 	default y if CPU_SUBTYPE_SH7721
 	default y if CPU_SUBTYPE_SH7763
+	default y if CPU_SUBTYPE_SH7786
 	# more:
 	default PCI
 
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 5cf5f1e..7658589 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1049,7 +1049,8 @@ MODULE_LICENSE ("GPL");
 
 #if defined(CONFIG_CPU_SUBTYPE_SH7720) || \
     defined(CONFIG_CPU_SUBTYPE_SH7721) || \
-    defined(CONFIG_CPU_SUBTYPE_SH7763)
+    defined(CONFIG_CPU_SUBTYPE_SH7763) || \
+    defined(CONFIG_CPU_SUBTYPE_SH7786)
 #include "ohci-sh.c"
 #define PLATFORM_DRIVER		ohci_hcd_sh_driver
 #endif
-- 
1.5.6.3

