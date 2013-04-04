From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 04 Apr 2013 23:01:59 +0000
Subject: [PATCH 3/8] ARM: shmobile: R8A7779: setup EHCI internal buffer
Message-Id: <201304050301.59961.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Setup the EHCI internal buffer (before EHCI driver has a chance to touch the
registers) using the init() method in 'struct usb_ehci_pdata'.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/mach-shmobile/setup-r8a7779.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

Index: renesas/arch/arm/mach-shmobile/setup-r8a7779.c
=================================--- renesas.orig/arch/arm/mach-shmobile/setup-r8a7779.c
+++ renesas/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -445,10 +445,26 @@ static void usb_power_off(struct platfor
 	pm_runtime_disable(&pdev->dev);
 }
 
+static int ehci_init_internal_buffer(struct platform_device *pdev,
+				     void __iomem *regs)
+{
+	/*
+	 * Below are recommended values from the datasheet;
+	 * see [USB :: Setting of EHCI Internal Buffer].
+	 */
+	/* EHCI IP internal buffer setting */
+	iowrite32(0x00ff0040, regs + 0x0094);
+	/* EHCI IP internal buffer enable */
+	iowrite32(0x00000001, regs + 0x009C);
+
+	return 0;
+}
+
 static struct usb_ehci_pdata ehcix_pdata = {
 	.power_on	= usb_power_on,
 	.power_off	= usb_power_off,
 	.power_suspend	= usb_power_off,
+	.init		= ehci_init_internal_buffer,
 };
 
 static struct resource ehci0_resources[] = {
