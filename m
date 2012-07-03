From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
Date: Tue, 03 Jul 2012 06:32:58 +0000
Subject: [RFC][PATCH] ARM: shmobile: kzm9g: add r8a66597_udc support
Message-Id: <4FF2921A.2080803@kmckk.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add r8a66597_udc support for CN6 connector on KZM-A9-GT board.
r8a66597 USB controller can not use host mode and peripheral mode
at the same time. At default r8a66597_udc is disabled.
To use r8a66597_udc define USE_R8A66597_UDC.

Signed-off-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
---
Hello,

This is an experimental patch to test if r8a66597_udc works or not.
I think that using r8a66597_udc is very rare because usually r8a66597_hcd is used
and they can not use at the same time. So this patch is really for test and 
I add this patch code is all inside #ifdef USE_R8A66597_UDC.

My question, this kind of test code should not merge to mainline?
Or, the define USE_R8A66597_UDC should be change to CONFIG_R8A66597_UDC or so, 
and it to Kconfig?

 arch/arm/mach-shmobile/board-kzm9g.c |   40 ++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index 7d4ee5c..af3e110 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -131,6 +131,37 @@ static struct platform_device usb_host_device = {
 	.resource	= usb_resources,
 };
 
+#ifdef USE_R8A66597_UDC
+static struct r8a66597_platdata usb1_gadget_data = {
+	.on_chip = 0,
+	.xtal		= R8A66597_PLATDATA_XTAL_48MHZ,
+};
+
+static struct resource usb1_gadget_resources[] = {
+	[0] = {
+		.start	= 0x10010000,
+		.end	= 0x1001ffff - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= intcs_evt2irq(0x220), /* IRQ1 */
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device usb1_gadget_device = {
+	.name		= "r8a66597_udc",
+	.id		= 1, /* USB1 */
+	.dev = {
+		.dma_mask		= NULL,         /*  not use dma */
+		.coherent_dma_mask	= 0xffffffff,
+		.platform_data		= &usb1_gadget_data,
+	},
+	.num_resources	= ARRAY_SIZE(usb1_gadget_resources),
+	.resource	= usb1_gadget_resources,
+};
+#endif
+
 /* USB Func CN17 */
 struct usbhs_private {
 	unsigned int phy;
@@ -577,8 +608,17 @@ static struct i2c_board_info i2c3_devices[] = {
 
 static struct platform_device *kzm_devices[] __initdata = {
 	&smsc_device,
+#ifdef USE_R8A66597_UDC
+	/*
+	 * Do not enable usb_host_device because r8a66597_udc and r8a66597_hcd
+	 * can not use at the same time.
+	 * Also, do not enable usbhs_device for simplify.
+	 */
+	&usb1_gadget_device,
+#else
 	&usb_host_device,
 	&usbhs_device,
+#endif
 	&lcdc_device,
 	&mmc_device,
 	&sdhi0_device,
-- 
1.7.9.5

