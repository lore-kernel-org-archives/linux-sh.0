From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 01 Dec 2010 09:13:57 +0000
Subject: [PATCH] SuperH on-chip EHCI glue, v2
Message-Id: <20101201091357.GA2982@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This is a simple patch series for adding EHCI glue for the SuperH on-chip
controller. It's largely modelled after the ohci-sh driver with clock
management added on top, which I plan to move out to be shared between
the two like Octeon presently does in a future patch -- this just hasn't
been done yet since I need to go through and audit all of the SH OHCI
users first.

As before, if you don't have any issues with the series then you can feel
free to pull the topic branch in to one of your trees as-is, or I can
merge it via the SH tree (I don't have anything that depends on it, so
I'm fine with whatever you prefer).

This round includes updates/fixes suggested by Alan Stern and David Daney.

The topic branch itself is at:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git sh/ehci

and contains:

Paul Mundt (6):
      usb: ohci-sh: Set IRQ as shared.
      usb: ehci-hcd: Add support for SuperH EHCI.
      sh: Add EHCI support for SH7786.
      usb: ehci-sh: Fix up fault in shutdown path.
      usb: ehci-sh: Add missing ehci helpers.
      sh: Convert to USB_ARCH_HAS_OHCI/EHCI selects.

 arch/sh/Kconfig                        |    5 +
 arch/sh/kernel/cpu/sh4a/setup-sh7786.c |   35 ++++-
 drivers/usb/Kconfig                    |    5 -
 drivers/usb/host/ehci-hcd.c            |    5 +
 drivers/usb/host/ehci-sh.c             |  243 ++++++++++++++++++++++++++++++++
 drivers/usb/host/ohci-sh.c             |    2 +-
 6 files changed, 285 insertions(+), 10 deletions(-)
 create mode 100644 drivers/usb/host/ehci-sh.c

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 5c075f5..e0e2234 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -344,6 +344,7 @@ config CPU_SUBTYPE_SH7720
 	select CPU_SH3
 	select CPU_HAS_DSP
 	select SYS_SUPPORTS_CMT
+	select USB_ARCH_HAS_OHCI
 	help
 	  Select SH7720 if you have a SH3-DSP SH7720 CPU.
 
@@ -352,6 +353,7 @@ config CPU_SUBTYPE_SH7721
 	select CPU_SH3
 	select CPU_HAS_DSP
 	select SYS_SUPPORTS_CMT
+	select USB_ARCH_HAS_OHCI
 	help
 	  Select SH7721 if you have a SH3-DSP SH7721 CPU.
 
@@ -429,6 +431,7 @@ config CPU_SUBTYPE_SH7757
 config CPU_SUBTYPE_SH7763
 	bool "Support SH7763 processor"
 	select CPU_SH4A
+	select USB_ARCH_HAS_OHCI
 	help
 	  Select SH7763 if you have a SH4A SH7763(R5S77631) CPU.
 
@@ -453,6 +456,8 @@ config CPU_SUBTYPE_SH7786
 	select CPU_SHX3
 	select CPU_HAS_PTEAEX
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
+	select USB_ARCH_HAS_OHCI
+	select USB_ARCH_HAS_EHCI
 
 config CPU_SUBTYPE_SHX3
 	bool "Support SH-X3 processor"
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
index c016c00..0170dbd 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
@@ -522,10 +522,37 @@ static struct platform_device dma0_device = {
 	},
 };
 
+#define USB_EHCI_START 0xffe70000
+#define USB_OHCI_START 0xffe70400
+
+static struct resource usb_ehci_resources[] = {
+	[0] = {
+		.start	= USB_EHCI_START,
+		.end	= USB_EHCI_START + 0x3ff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 77,
+		.end	= 77,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device usb_ehci_device = {
+	.name		= "sh_ehci",
+	.id		= -1,
+	.dev = {
+		.dma_mask		= &usb_ehci_device.dev.coherent_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+	.num_resources	= ARRAY_SIZE(usb_ehci_resources),
+	.resource	= usb_ehci_resources,
+};
+
 static struct resource usb_ohci_resources[] = {
 	[0] = {
-		.start	= 0xffe70400,
-		.end	= 0xffe704ff,
+		.start	= USB_OHCI_START,
+		.end	= USB_OHCI_START + 0x3ff,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
@@ -535,12 +562,11 @@ static struct resource usb_ohci_resources[] = {
 	},
 };
 
-static u64 usb_ohci_dma_mask = DMA_BIT_MASK(32);
 static struct platform_device usb_ohci_device = {
 	.name		= "sh_ohci",
 	.id		= -1,
 	.dev = {
-		.dma_mask		= &usb_ohci_dma_mask,
+		.dma_mask		= &usb_ohci_device.dev.coherent_dma_mask,
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
 	},
 	.num_resources	= ARRAY_SIZE(usb_ohci_resources),
@@ -570,6 +596,7 @@ static struct platform_device *sh7786_early_devices[] __initdata = {
 
 static struct platform_device *sh7786_devices[] __initdata = {
 	&dma0_device,
+	&usb_ehci_device,
 	&usb_ohci_device,
 };
 
diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 67eb377..703a33b 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -47,11 +47,6 @@ config USB_ARCH_HAS_OHCI
 	# MIPS:
 	default y if MIPS_ALCHEMY
 	default y if MACH_JZ4740
-	# SH:
-	default y if CPU_SUBTYPE_SH7720
-	default y if CPU_SUBTYPE_SH7721
-	default y if CPU_SUBTYPE_SH7763
-	default y if CPU_SUBTYPE_SH7786
 	# more:
 	default PCI
 
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 502a7e6..02ffbea 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1166,6 +1166,11 @@ MODULE_LICENSE ("GPL");
 #define PLATFORM_DRIVER		ehci_mxc_driver
 #endif
 
+#ifdef CONFIG_CPU_SUBTYPE_SH7786
+#include "ehci-sh.c"
+#define PLATFORM_DRIVER		ehci_hcd_sh_driver
+#endif
+
 #ifdef CONFIG_SOC_AU1200
 #include "ehci-au1xxx.c"
 #define	PLATFORM_DRIVER		ehci_hcd_au1xxx_driver
diff --git a/drivers/usb/host/ehci-sh.c b/drivers/usb/host/ehci-sh.c
new file mode 100644
index 0000000..595f70f
--- /dev/null
+++ b/drivers/usb/host/ehci-sh.c
@@ -0,0 +1,243 @@
+/*
+ * SuperH EHCI host controller driver
+ *
+ * Copyright (C) 2010  Paul Mundt
+ *
+ * Based on ohci-sh.c and ehci-atmel.c.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+
+struct ehci_sh_priv {
+	struct clk *iclk, *fclk;
+	struct usb_hcd *hcd;
+};
+
+static int ehci_sh_reset(struct usb_hcd *hcd)
+{
+	struct ehci_hcd	*ehci = hcd_to_ehci(hcd);
+	int ret;
+
+	ehci->caps = hcd->regs;
+	ehci->regs = hcd->regs + HC_LENGTH(ehci_readl(ehci,
+		&ehci->caps->hc_capbase));
+
+	dbg_hcs_params(ehci, "reset");
+	dbg_hcc_params(ehci, "reset");
+
+	ehci->hcs_params = ehci_readl(ehci, &ehci->caps->hcs_params);
+
+	ret = ehci_halt(ehci);
+	if (unlikely(ret))
+		return ret;
+
+	ret = ehci_init(hcd);
+	if (unlikely(ret))
+		return ret;
+
+	ehci->sbrn = 0x20;
+
+	ehci_reset(ehci);
+	ehci_port_power(ehci, 0);
+
+	return ret;
+}
+
+static const struct hc_driver ehci_sh_hc_driver = {
+	.description			= hcd_name,
+	.product_desc			= "SuperH EHCI",
+	.hcd_priv_size			= sizeof(struct ehci_hcd),
+
+	/*
+	 * generic hardware linkage
+	 */
+	.irq				= ehci_irq,
+	.flags				= HCD_USB2 | HCD_MEMORY,
+
+	/*
+	 * basic lifecycle operations
+	 */
+	.reset				= ehci_sh_reset,
+	.start				= ehci_run,
+	.stop				= ehci_stop,
+	.shutdown			= ehci_shutdown,
+
+	/*
+	 * managing i/o requests and associated device resources
+	 */
+	.urb_enqueue			= ehci_urb_enqueue,
+	.urb_dequeue			= ehci_urb_dequeue,
+	.endpoint_disable		= ehci_endpoint_disable,
+	.endpoint_reset			= ehci_endpoint_reset,
+
+	/*
+	 * scheduling support
+	 */
+	.get_frame_number		= ehci_get_frame,
+
+	/*
+	 * root hub support
+	 */
+	.hub_status_data		= ehci_hub_status_data,
+	.hub_control			= ehci_hub_control,
+
+#ifdef CONFIG_PM
+	.bus_suspend			= ehci_bus_suspend,
+	.bus_resume			= ehci_bus_resume,
+#endif
+
+	.relinquish_port		= ehci_relinquish_port,
+	.port_handed_over		= ehci_port_handed_over,
+	.clear_tt_buffer_complete	= ehci_clear_tt_buffer_complete,
+};
+
+static int ehci_hcd_sh_probe(struct platform_device *pdev)
+{
+	const struct hc_driver *driver = &ehci_sh_hc_driver;
+	struct resource *res;
+	struct ehci_sh_priv *priv;
+	struct usb_hcd *hcd;
+	int irq, ret;
+
+	if (usb_disabled())
+		return -ENODEV;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev,
+			"Found HC with no register addr. Check %s setup!\n",
+			dev_name(&pdev->dev));
+		ret = -ENODEV;
+		goto fail_create_hcd;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0) {
+		dev_err(&pdev->dev,
+			"Found HC with no IRQ. Check %s setup!\n",
+			dev_name(&pdev->dev));
+		ret = -ENODEV;
+		goto fail_create_hcd;
+	}
+
+	/* initialize hcd */
+	hcd = usb_create_hcd(&ehci_sh_hc_driver, &pdev->dev,
+			     dev_name(&pdev->dev));
+	if (!hcd) {
+		ret = -ENOMEM;
+		goto fail_create_hcd;
+	}
+
+	hcd->rsrc_start = res->start;
+	hcd->rsrc_len = resource_size(res);
+
+	if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len,
+				driver->description)) {
+		dev_dbg(&pdev->dev, "controller already in use\n");
+		ret = -EBUSY;
+		goto fail_request_resource;
+	}
+
+	hcd->regs = ioremap_nocache(hcd->rsrc_start, hcd->rsrc_len);
+	if (hcd->regs = NULL) {
+		dev_dbg(&pdev->dev, "error mapping memory\n");
+		ret = -ENXIO;
+		goto fail_ioremap;
+	}
+
+	priv = kmalloc(sizeof(struct ehci_sh_priv), GFP_KERNEL);
+	if (!priv) {
+		dev_dbg(&pdev->dev, "error allocating priv data\n");
+		ret = -ENOMEM;
+		goto fail_alloc;
+	}
+
+	/* These are optional, we don't care if they fail */
+	priv->fclk = clk_get(&pdev->dev, "usb_fck");
+	if (IS_ERR(priv->fclk))
+		priv->fclk = NULL;
+
+	priv->iclk = clk_get(&pdev->dev, "usb_ick");
+	if (IS_ERR(priv->iclk))
+		priv->iclk = NULL;
+
+	clk_enable(priv->fclk);
+	clk_enable(priv->iclk);
+
+	ret = usb_add_hcd(hcd, irq, IRQF_DISABLED | IRQF_SHARED);
+	if (ret != 0) {
+		dev_err(&pdev->dev, "Failed to add hcd");
+		goto fail_add_hcd;
+	}
+
+	priv->hcd = hcd;
+	platform_set_drvdata(pdev, priv);
+
+	return ret;
+
+fail_add_hcd:
+	clk_disable(priv->iclk);
+	clk_disable(priv->fclk);
+
+	clk_put(priv->iclk);
+	clk_put(priv->fclk);
+
+	kfree(priv);
+fail_alloc:
+	iounmap(hcd->regs);
+fail_ioremap:
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+fail_request_resource:
+	usb_put_hcd(hcd);
+fail_create_hcd:
+	dev_err(&pdev->dev, "init %s fail, %d\n", dev_name(&pdev->dev), ret);
+
+	return ret;
+}
+
+static int __exit ehci_hcd_sh_remove(struct platform_device *pdev)
+{
+	struct ehci_sh_priv *priv = platform_get_drvdata(pdev);
+	struct usb_hcd *hcd = priv->hcd;
+
+	usb_remove_hcd(hcd);
+	iounmap(hcd->regs);
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+	usb_put_hcd(hcd);
+	platform_set_drvdata(pdev, NULL);
+
+	clk_disable(priv->fclk);
+	clk_disable(priv->iclk);
+
+	clk_put(priv->fclk);
+	clk_put(priv->iclk);
+
+	kfree(priv);
+
+	return 0;
+}
+
+static void ehci_hcd_sh_shutdown(struct platform_device *pdev)
+{
+	struct ehci_sh_priv *priv = platform_get_drvdata(pdev);
+	struct usb_hcd *hcd = priv->hcd;
+
+	if (hcd->driver->shutdown)
+		hcd->driver->shutdown(hcd);
+}
+
+static struct platform_driver ehci_hcd_sh_driver = {
+	.probe		= ehci_hcd_sh_probe,
+	.remove		= __exit_p(ehci_hcd_sh_remove),
+	.shutdown	= ehci_hcd_sh_shutdown,
+	.driver		= {
+		.name	= "sh_ehci",
+		.owner	= THIS_MODULE,
+	},
+};
+
+MODULE_ALIAS("platform:sh_ehci");
diff --git a/drivers/usb/host/ohci-sh.c b/drivers/usb/host/ohci-sh.c
index 0b35d22..f47867f 100644
--- a/drivers/usb/host/ohci-sh.c
+++ b/drivers/usb/host/ohci-sh.c
@@ -109,7 +109,7 @@ static int ohci_hcd_sh_probe(struct platform_device *pdev)
 	hcd->regs = (void __iomem *)res->start;
 	hcd->rsrc_start = res->start;
 	hcd->rsrc_len = resource_size(res);
-	ret = usb_add_hcd(hcd, irq, IRQF_DISABLED);
+	ret = usb_add_hcd(hcd, irq, IRQF_DISABLED | IRQF_SHARED);
 	if (ret != 0) {
 		err("Failed to add hcd");
 		usb_put_hcd(hcd);
