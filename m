From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Mon, 02 Mar 2009 05:16:06 +0000
Subject: [PATCH] Add OHCI USB support for SH7786
Message-Id: <uy6vozecn.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7786.c |   60 ++++++++++++++++++++++++++++++++
 drivers/usb/Kconfig                    |    1 +
 drivers/usb/host/ohci-hcd.c            |    3 +-
 3 files changed, 63 insertions(+), 1 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
index ca5d987..ad5b4d4 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
@@ -68,10 +68,70 @@ static struct platform_device sci_device = {
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
+static u64 usb_ohci_dma_mask = 0xffffffffUL;
+static struct platform_device usb_ohci_device = {
+	.name		= "sh_ohci",
+	.id		= -1,
+	.dev = {
+		.dma_mask		= &usb_ohci_dma_mask,
+		.coherent_dma_mask	= 0xffffffff,
+	},
+	.num_resources	= ARRAY_SIZE(usb_ohci_resources),
+	.resource	= usb_ohci_resources,
+};
+
 static struct platform_device *sh7786_devices[] __initdata = {
 	&sci_device,
+	&usb_ohci_device,
 };
 
+#define USBPCTL1	0xffe70804
+#define USBST		0xffe70808
+#define USBCTL0		0xffe70858
+int __init sh7786_usb_setup(int exclock)
+{
+	int i;
+	u32 val;
+
+	ctrl_outl(0x00ff0040, 0xffe70094);
+	ctrl_outl(0x00000001, 0xffe7009c);
+
+	val = ctrl_inl(USBCTL0) & 0xffffff7f;
+	if (exclock)
+		val |= 0x00000080;
+	ctrl_outl(val, USBCTL0);
+
+	/* Set the PHY ENB bit */
+	i = 1000000;
+	ctrl_outl(0x00000001, USBPCTL1);
+	while (i-- && !(ctrl_inl(USBST) & (1 << 30)))
+		;
+
+	/* Set the PLL ENB bit */
+	i = 1000000;
+	ctrl_outl(0x00000003, USBPCTL1);
+	while (i-- && ((ctrl_inl(USBST) & (0x3 << 30)) != (0x3 << 30)))
+		;
+
+	/* Set the PHY RST bit */
+	ctrl_outl(0x00000007, USBPCTL1);
+
+	printk(KERN_INFO "sh7786 usb setup done\n");
+}
+
 static int __init sh7786_devices_setup(void)
 {
 	return platform_add_devices(sh7786_devices,
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

