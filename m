From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 31 Oct 2008 11:22:38 +0000
Subject: [PATCH] sh: sh_mobile usb clock framework support
Message-Id: <20081031112238.2993.72468.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add clock framework support to the usb/r8a66597 driver and
adjust the cpu specific code accordingly.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4a/setup-sh7366.c |    1 
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |    1 
 drivers/usb/host/r8a66597-hcd.c        |   35 ++++++++++++++++++++++++++++++--
 drivers/usb/host/r8a66597.h            |    8 ++++++-
 4 files changed, 40 insertions(+), 5 deletions(-)

--- 0011/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7366.c	2008-10-31 19:16:32.000000000 +0900
@@ -185,7 +185,6 @@ static int __init sh7366_devices_setup(v
 	clk_always_enable("mstp023"); /* INTC3 */
 	clk_always_enable("mstp022"); /* INTC */
 	clk_always_enable("mstp020"); /* SuperHyway */
-	clk_always_enable("mstp211"); /* USB */
 	clk_always_enable("mstp207"); /* VEU-2 */
 	clk_always_enable("mstp202"); /* VEU-1 */
 	clk_always_enable("mstp201"); /* VPU */
--- 0011/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7723.c	2008-10-31 19:15:52.000000000 +0900
@@ -240,7 +240,6 @@ static int __init sh7723_devices_setup(v
 	clk_always_enable("mstp020"); /* SuperHyway */
 	clk_always_enable("mstp000"); /* MERAM */
 	clk_always_enable("mstp108"); /* RTC */
-	clk_always_enable("mstp211"); /* USB */
 	clk_always_enable("mstp206"); /* VEU2H1 */
 	clk_always_enable("mstp202"); /* VEU2H0 */
 	clk_always_enable("mstp201"); /* VPU */
--- 0001/drivers/usb/host/r8a66597-hcd.c
+++ work/drivers/usb/host/r8a66597-hcd.c	2008-10-31 19:15:53.000000000 +0900
@@ -114,6 +114,9 @@ static int r8a66597_clock_enable(struct 
 	int i = 0;
 
 #if defined(CONFIG_SUPERH_ON_CHIP_R8A66597)
+#if defined(CONFIG_HAVE_CLK)
+	clk_enable(r8a66597->clk);
+#endif
 	do {
 		r8a66597_write(r8a66597, SCKE, SYSCFG0);
 		tmp = r8a66597_read(r8a66597, SYSCFG0);
@@ -154,7 +157,11 @@ static void r8a66597_clock_disable(struc
 {
 	r8a66597_bclr(r8a66597, SCKE, SYSCFG0);
 	udelay(1);
-#if !defined(CONFIG_SUPERH_ON_CHIP_R8A66597)
+#if defined(CONFIG_SUPERH_ON_CHIP_R8A66597)
+#if defined(CONFIG_HAVE_CLK)
+	clk_disable(r8a66597->clk);
+#endif
+#else
 	r8a66597_bclr(r8a66597, PLLC, SYSCFG0);
 	r8a66597_bclr(r8a66597, XCKE, SYSCFG0);
 	r8a66597_bclr(r8a66597, USBE, SYSCFG0);
@@ -2260,6 +2267,9 @@ static int __init_or_module r8a66597_rem
 	del_timer_sync(&r8a66597->rh_timer);
 	usb_remove_hcd(hcd);
 	iounmap((void *)r8a66597->reg);
+#if defined(CONFIG_SUPERH_ON_CHIP_R8A66597) && defined(CONFIG_HAVE_CLK)
+	clk_put(r8a66597->clk);
+#endif
 	usb_put_hcd(hcd);
 	return 0;
 }
@@ -2267,6 +2277,9 @@ static int __init_or_module r8a66597_rem
 #define resource_len(r) (((r)->end - (r)->start) + 1)
 static int __init r8a66597_probe(struct platform_device *pdev)
 {
+#if defined(CONFIG_SUPERH_ON_CHIP_R8A66597) && defined(CONFIG_HAVE_CLK)
+	char clk_name[8];
+#endif
 	struct resource *res = NULL, *ires;
 	int irq = -1;
 	void __iomem *reg = NULL;
@@ -2319,6 +2332,16 @@ static int __init r8a66597_probe(struct 
 	memset(r8a66597, 0, sizeof(struct r8a66597));
 	dev_set_drvdata(&pdev->dev, r8a66597);
 
+#if defined(CONFIG_SUPERH_ON_CHIP_R8A66597) && defined(CONFIG_HAVE_CLK)
+	snprintf(clk_name, sizeof(clk_name), "usb%d", pdev->id);
+	r8a66597->clk = clk_get(&pdev->dev, clk_name);
+	if (IS_ERR(r8a66597->clk)) {
+		dev_err(&pdev->dev, "cannot get clock \"%s\"\n", clk_name);
+		ret = PTR_ERR(r8a66597->clk);
+		goto clean_up2;
+	}
+#endif
+
 	spin_lock_init(&r8a66597->lock);
 	init_timer(&r8a66597->rh_timer);
 	r8a66597->rh_timer.function = r8a66597_timer;
@@ -2364,11 +2387,19 @@ static int __init r8a66597_probe(struct 
 	ret = usb_add_hcd(hcd, irq, IRQF_DISABLED | irq_trigger);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "Failed to add hcd\n");
-		goto clean_up;
+		goto clean_up3;
 	}
 
 	return 0;
 
+clean_up3:
+#if defined(CONFIG_SUPERH_ON_CHIP_R8A66597) && defined(CONFIG_HAVE_CLK)
+	clk_put(r8a66597->clk);
+#endif
+
+clean_up2:
+	usb_put_hcd(hcd);
+
 clean_up:
 	if (reg)
 		iounmap(reg);
--- 0001/drivers/usb/host/r8a66597.h
+++ work/drivers/usb/host/r8a66597.h	2008-10-31 19:15:53.000000000 +0900
@@ -26,6 +26,10 @@
 #ifndef __R8A66597_H__
 #define __R8A66597_H__
 
+#if defined(CONFIG_SUPERH_ON_CHIP_R8A66597) && defined(CONFIG_HAVE_CLK)
+#include <linux/clk.h>
+#endif
+
 #define SYSCFG0		0x00
 #define SYSCFG1		0x02
 #define SYSSTS0		0x04
@@ -481,7 +485,9 @@ struct r8a66597_root_hub {
 struct r8a66597 {
 	spinlock_t lock;
 	unsigned long reg;
-
+#if defined(CONFIG_SUPERH_ON_CHIP_R8A66597) && defined(CONFIG_HAVE_CLK)
+	struct clk *clk;
+#endif
 	struct r8a66597_device		device0;
 	struct r8a66597_root_hub	root_hub[R8A66597_MAX_ROOT_HUB];
 	struct list_head		pipe_queue[R8A66597_MAX_NUM_PIPE];
