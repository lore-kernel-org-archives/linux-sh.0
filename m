From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Fri, 08 Jun 2012 06:05:00 +0000
Subject: [PATCH 2/5] sh: SH7734: Add support USB Host controller
Message-Id: <1339135503-1997-2-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

SH7734 has USB2.0 and USB1.1 Host controller. This supports both.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7734.c |   96 ++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7734.c b/arch/sh/kernel/cpu/sh4a/setup-sh7734.c
index 6ad884c..6d168f4 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7734.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7734.c
@@ -18,6 +18,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/serial_sci.h>
 #include <linux/sh_timer.h>
+#include <linux/platform_data/ehci-sh.h>
 #include <linux/io.h>
 #include <asm/clock.h>
 #include <asm/irq.h>
@@ -421,6 +422,92 @@ static struct platform_device tmu8_device = {
 	.num_resources	= ARRAY_SIZE(tmu8_resources),
 };
 
+/* USB */
+#define USBPCTRL1	(0xFFE70804)
+#define USBST		(0xFFE70808)
+#define USBEH0		(0xFFE7080C)
+#define USBOH0		(0xFFE7081C)
+#define USBCTL0		(0xFFE70858)
+
+#define USBPCTRL1_RST		(1 << 31)
+#define USBPCTRL1_PHYENB	(1 << 0)
+#define USBPCTRL1_PLLENB	(1 << 1)
+#define USBPCTRL1_PHYRST	(1 << 2)
+#define USBST_ACT			(1 << 31)
+#define USBST_PPL			(1 << 30)
+
+static void usb_ehci_phy_init(void)
+{
+	/* Init check */
+	if (__raw_readl(USBPCTRL1) & USBPCTRL1_PHYRST)
+		return;
+
+	__raw_writel(USBPCTRL1_RST, USBPCTRL1);
+	__raw_writel(0, USBPCTRL1);
+	__raw_writel(USBPCTRL1_PHYENB, USBPCTRL1);
+	__raw_writel(__raw_readl(USBPCTRL1)|USBPCTRL1_PLLENB, USBPCTRL1);
+
+	while (__raw_readl(USBST) != (USBST_ACT|USBST_PPL))
+		cpu_relax();
+
+	__raw_writel(__raw_readl(USBPCTRL1) | USBPCTRL1_PHYRST, USBPCTRL1);
+}
+
+static struct ehci_sh_platdata usb_ehci_pdata = {
+	.phy_init = &usb_ehci_phy_init,
+};
+
+static struct resource usb_ehci_resources[] = {
+	[0] = {
+		.start	= 0xFFE70000,
+		.end	= 0xFFE70058 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= evt2irq(0x580),
+		.end	= evt2irq(0x580),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static u64 usb_ehci_dma_mask = 0xffffffffUL;
+static struct platform_device usb_ehci_device = {
+	.name	= "sh_ehci",
+	.id		= -1,
+	.dev = {
+		.dma_mask = &usb_ehci_dma_mask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+		.platform_data      = &usb_ehci_pdata,
+	},
+	.num_resources	= ARRAY_SIZE(usb_ehci_resources),
+	.resource	= usb_ehci_resources,
+};
+
+static struct resource usb_ohci_resources[] = {
+	[0] = {
+		.start	= 0xFFE70400,
+		.end	= 0xFFE7045C - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= evt2irq(0x580),
+		.end	= evt2irq(0x580),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static u64 usb_ohci_dma_mask = 0xffffffffUL;
+static struct platform_device usb_ohci_device = {
+	.name	= "sh_ohci",
+	.id		= -1,
+	.dev = {
+		.dma_mask = &usb_ohci_dma_mask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+	},
+	.num_resources	= ARRAY_SIZE(usb_ohci_resources),
+	.resource	= usb_ohci_resources,
+};
+
 static struct platform_device *sh7734_devices[] __initdata = {
 	&scif0_device,
 	&scif1_device,
@@ -438,10 +525,19 @@ static struct platform_device *sh7734_devices[] __initdata = {
 	&tmu7_device,
 	&tmu8_device,
 	&rtc_device,
+	&usb_ehci_device,
+	&usb_ohci_device,
 };
 
+#define USB_MAGIC_REG0	(0xFFE70094)
+#define USB_MAGIC_REG1	(0xFFE7009C)
 static int __init sh7734_devices_setup(void)
 {
+#ifdef CONFIG_USB
+	/* manual p.1537 */
+	__raw_writel(0x00FF0040, USB_MAGIC_REG0);
+	__raw_writel(0x00000001, USB_MAGIC_REG1);
+#endif
 	return platform_add_devices(sh7734_devices,
 		ARRAY_SIZE(sh7734_devices));
 }
-- 
1.7.10

