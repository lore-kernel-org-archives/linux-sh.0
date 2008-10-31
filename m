From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 31 Oct 2008 11:22:13 +0000
Subject: [PATCH] sh: sh_mobile usbf clock framework support
Message-Id: <20081031112213.2991.98406.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add clock framework support to the usbf/m66592 driver and
adjust the cpu specific code accordingly.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |    3 --
 drivers/usb/gadget/m66592-udc.c        |   34 +++++++++++++++++++++++---------
 drivers/usb/gadget/m66592-udc.h        |   27 ++++++-------------------
 3 files changed, 33 insertions(+), 31 deletions(-)

--- 0005/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7722.c	2008-10-28 17:50:47.000000000 +0900
@@ -32,7 +32,7 @@ static struct resource usbf_resources[] 
 
 static struct platform_device usbf_device = {
 	.name		= "m66592_udc",
-	.id		= -1,
+	.id             = 0, /* "usbf0" clock */
 	.dev = {
 		.dma_mask		= NULL,
 		.coherent_dma_mask	= 0xffffffff,
@@ -167,7 +167,6 @@ static int __init sh7722_devices_setup(v
 	clk_always_enable("mstp026"); /* XYMEM */
 	clk_always_enable("mstp022"); /* INTC */
 	clk_always_enable("mstp020"); /* SuperHyway */
-	clk_always_enable("mstp211"); /* USB */
 	clk_always_enable("mstp202"); /* VEU */
 	clk_always_enable("mstp201"); /* VPU */
 
--- 0001/drivers/usb/gadget/m66592-udc.c
+++ work/drivers/usb/gadget/m66592-udc.c	2008-10-28 17:55:17.000000000 +0900
@@ -623,7 +623,6 @@ static void start_ep0(struct m66592_ep *
 #if defined(CONFIG_SUPERH_BUILT_IN_M66592)
 static void init_controller(struct m66592 *m66592)
 {
-	usbf_start_clock();
 	m66592_bset(m66592, M66592_HSE, M66592_SYSCFG);		/* High spd */
 	m66592_bclr(m66592, M66592_USBE, M66592_SYSCFG);
 	m66592_bclr(m66592, M66592_DPRPU, M66592_SYSCFG);
@@ -671,9 +670,7 @@ static void init_controller(struct m6659
 
 static void disable_controller(struct m66592 *m66592)
 {
-#if defined(CONFIG_SUPERH_BUILT_IN_M66592)
-	usbf_stop_clock();
-#else
+#if !defined(CONFIG_SUPERH_BUILT_IN_M66592)
 	m66592_bclr(m66592, M66592_SCKE, M66592_SYSCFG);
 	udelay(1);
 	m66592_bclr(m66592, M66592_PLLC, M66592_SYSCFG);
@@ -686,9 +683,7 @@ static void disable_controller(struct m6
 
 static void m66592_start_xclock(struct m66592 *m66592)
 {
-#if defined(CONFIG_SUPERH_BUILT_IN_M66592)
-	usbf_start_clock();
-#else
+#if !defined(CONFIG_SUPERH_BUILT_IN_M66592)
 	u16 tmp;
 
 	tmp = m66592_read(m66592, M66592_SYSCFG);
@@ -1539,7 +1534,10 @@ static int __exit m66592_remove(struct p
 	iounmap(m66592->reg);
 	free_irq(platform_get_irq(pdev, 0), m66592);
 	m66592_free_request(&m66592->ep[0].ep, m66592->ep0_req);
-	usbf_stop_clock();
+#if defined(CONFIG_SUPERH_BUILT_IN_M66592) && defined(CONFIG_HAVE_CLK)
+	clk_disable(m66592->clk);
+	clk_put(m66592->clk);
+#endif
 	kfree(m66592);
 	return 0;
 }
@@ -1556,6 +1554,9 @@ static int __init m66592_probe(struct pl
 	int irq;
 	void __iomem *reg = NULL;
 	struct m66592 *m66592 = NULL;
+#if defined(CONFIG_SUPERH_BUILT_IN_M66592) && defined(CONFIG_HAVE_CLK)
+	char clk_name[8];
+#endif
 	int ret = 0;
 	int i;
 
@@ -1614,6 +1615,16 @@ static int __init m66592_probe(struct pl
 		goto clean_up;
 	}
 
+#if defined(CONFIG_SUPERH_BUILT_IN_M66592) && defined(CONFIG_HAVE_CLK)
+	snprintf(clk_name, sizeof(clk_name), "usbf%d", pdev->id);
+	m66592->clk = clk_get(&pdev->dev, clk_name);
+	if (IS_ERR(m66592->clk)) {
+		dev_err(&pdev->dev, "cannot get clock \"%s\"\n", clk_name);
+		ret = PTR_ERR(m66592->clk);
+		goto clean_up2;
+	}
+	clk_enable(m66592->clk);
+#endif
 	INIT_LIST_HEAD(&m66592->gadget.ep_list);
 	m66592->gadget.ep0 = &m66592->ep[0].ep;
 	INIT_LIST_HEAD(&m66592->gadget.ep0->ep_list);
@@ -1645,7 +1656,7 @@ static int __init m66592_probe(struct pl
 
 	m66592->ep0_req = m66592_alloc_request(&m66592->ep[0].ep, GFP_KERNEL);
 	if (m66592->ep0_req = NULL)
-		goto clean_up2;
+		goto clean_up3;
 	m66592->ep0_req->complete = nop_completion;
 
 	init_controller(m66592);
@@ -1653,6 +1664,11 @@ static int __init m66592_probe(struct pl
 	dev_info(&pdev->dev, "version %s\n", DRIVER_VERSION);
 	return 0;
 
+clean_up3:
+#if defined(CONFIG_SUPERH_BUILT_IN_M66592) && defined(CONFIG_HAVE_CLK)
+	clk_disable(m66592->clk);
+	clk_put(m66592->clk);
+#endif
 clean_up2:
 	free_irq(irq, m66592);
 clean_up:
--- 0001/drivers/usb/gadget/m66592-udc.h
+++ work/drivers/usb/gadget/m66592-udc.h	2008-10-28 17:42:11.000000000 +0900
@@ -23,6 +23,10 @@
 #ifndef __M66592_UDC_H__
 #define __M66592_UDC_H__
 
+#if defined(CONFIG_SUPERH_BUILT_IN_M66592) && defined(CONFIG_HAVE_CLK)
+#include <linux/clk.h>
+#endif
+
 #define M66592_SYSCFG		0x00
 #define M66592_XTAL		0xC000	/* b15-14: Crystal selection */
 #define   M66592_XTAL48		 0x8000		/* 48MHz */
@@ -476,6 +480,9 @@ struct m66592_ep {
 struct m66592 {
 	spinlock_t		lock;
 	void __iomem		*reg;
+#if defined(CONFIG_SUPERH_BUILT_IN_M66592) && defined(CONFIG_HAVE_CLK)
+	struct clk *clk;
+#endif
 
 	struct usb_gadget		gadget;
 	struct usb_gadget_driver	*driver;
@@ -604,26 +611,6 @@ static inline void m66592_mdfy(struct m6
 #define m66592_bset(m66592, val, offset)	\
 			m66592_mdfy(m66592, val, 0, offset)
 
-#if defined(CONFIG_SUPERH_BUILT_IN_M66592)
-#include <asm/io.h>
-#define MSTPCR2		0xA4150038	/* for SH7722 */
-#define MSTPCR2_USB	0x00000800
-
-static inline void usbf_start_clock(void)
-{
-	ctrl_outl(ctrl_inl(MSTPCR2) & ~MSTPCR2_USB, MSTPCR2);
-}
-
-static inline void usbf_stop_clock(void)
-{
-	ctrl_outl(ctrl_inl(MSTPCR2) | MSTPCR2_USB, MSTPCR2);
-}
-
-#else
-#define usbf_start_clock(x)
-#define usbf_stop_clock(x)
-#endif	/* if defined(CONFIG_SUPERH_BUILT_IN_M66592) */
-
 #endif	/* ifndef __M66592_UDC_H__ */
 
 
