From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 17 Jul 2008 10:20:11 +0000
Subject: [PATCH] sh: Use clk_always_enable() on sh7366
Message-Id: <20080717102011.19638.9134.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
References: <20080717101334.19615.87712.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080717101334.19615.87712.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Use clk_always_enable() in the sh7366 processor code.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4a/setup-sh7366.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7366.c	2008-07-17 18:33:51.000000000 +0900
@@ -14,6 +14,7 @@
 #include <linux/serial.h>
 #include <linux/serial_sci.h>
 #include <linux/uio_driver.h>
+#include <asm/clock.h>
 
 static struct resource iic_resources[] = {
 	[0] = {
@@ -148,9 +149,23 @@ static struct platform_device *sh7366_de
 
 static int __init sh7366_devices_setup(void)
 {
+	clk_always_enable("mstp031"); /* TLB */
+	clk_always_enable("mstp030"); /* IC */
+	clk_always_enable("mstp029"); /* OC */
+	clk_always_enable("mstp028"); /* RSMEM */
+	clk_always_enable("mstp026"); /* XYMEM */
+	clk_always_enable("mstp023"); /* INTC3 */
+	clk_always_enable("mstp022"); /* INTC */
+	clk_always_enable("mstp020"); /* SuperHyway */
+	clk_always_enable("mstp109"); /* I2C */
+	clk_always_enable("mstp207"); /* VEU-2 */
+	clk_always_enable("mstp202"); /* VEU-1 */
+	clk_always_enable("mstp201"); /* VPU */
+
 	platform_resource_setup_memory(&vpu_device, "vpu", 2 << 20);
 	platform_resource_setup_memory(&veu0_device, "veu0", 2 << 20);
 	platform_resource_setup_memory(&veu1_device, "veu1", 2 << 20);
+
 	return platform_add_devices(sh7366_devices,
 				    ARRAY_SIZE(sh7366_devices));
 }
