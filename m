From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Tue, 26 May 2009 03:09:48 +0000
Subject: [PATCH] usb: r8a66597-hcd: use platform_data instead of module_param
Message-Id: <4A1B5D7C.6070205@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

CPU/board specific parameters (PLL clock, irq sense etc...) can be set
by platform_data instead of module_param.

Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
---
 drivers/usb/host/r8a66597-hcd.c |   59 ++++++++------------------------------
 drivers/usb/host/r8a66597.h     |   37 +++++++++++++++++++++--
 include/linux/usb/r8a66597.h    |   47 +++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+), 50 deletions(-)
 create mode 100644 include/linux/usb/r8a66597.h

diff --git a/drivers/usb/host/r8a66597-hcd.c b/drivers/usb/host/r8a66597-hcd.c
index 3e1216a..af073e4 100644
--- a/drivers/usb/host/r8a66597-hcd.c
+++ b/drivers/usb/host/r8a66597-hcd.c
@@ -46,31 +46,10 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Yoshihiro Shimoda");
 MODULE_ALIAS("platform:r8a66597_hcd");

-#define DRIVER_VERSION	"10 Apr 2008"
+#define DRIVER_VERSION	"2009-05-25"

 static const char hcd_name[] = "r8a66597_hcd";

-/* module parameters */
-#if !defined(CONFIG_SUPERH_ON_CHIP_R8A66597)
-static unsigned short clock = XTAL12;
-module_param(clock, ushort, 0644);
-MODULE_PARM_DESC(clock, "input clock: 48MHz2768, 24MHz384, 12MHz=0 "
-		"(default=0)");
-#endif
-
-static unsigned short vif = LDRV;
-module_param(vif, ushort, 0644);
-MODULE_PARM_DESC(vif, "input VIF: 3.3V2768, 1.5V=0(default2768)");
-
-static unsigned short endian;
-module_param(endian, ushort, 0644);
-MODULE_PARM_DESC(endian, "data endian: big%6, little=0 (default=0)");
-
-static unsigned short irq_sense = 0xff;
-module_param(irq_sense, ushort, 0644);
-MODULE_PARM_DESC(irq_sense, "IRQ sense: low level2, falling edge=0 "
-		"(default2)");
-
 static void packet_write(struct r8a66597 *r8a66597, u16 pipenum);
 static int r8a66597_get_frame(struct usb_hcd *hcd);

@@ -136,7 +115,8 @@ static int r8a66597_clock_enable(struct r8a66597 *r8a66597)
 		}
 	} while ((tmp & USBE) != USBE);
 	r8a66597_bclr(r8a66597, USBE, SYSCFG0);
-	r8a66597_mdfy(r8a66597, clock, XTAL, SYSCFG0);
+	r8a66597_mdfy(r8a66597, get_xtal_from_pdata(r8a66597->pdata), XTAL,
+			SYSCFG0);

 	i = 0;
 	r8a66597_bset(r8a66597, XCKE, SYSCFG0);
@@ -203,6 +183,9 @@ static void r8a66597_disable_port(struct r8a66597 *r8a66597, int port)
 static int enable_controller(struct r8a66597 *r8a66597)
 {
 	int ret, port;
+	u16 vif = r8a66597->pdata->vif ? LDRV : 0;
+	u16 irq_sense = r8a66597->pdata->irq_sense ? INTL : 0;
+	u16 endian = r8a66597->pdata->endian ? BIGEND : 0;

 	ret = r8a66597_clock_enable(r8a66597);
 	if (ret < 0)
@@ -2418,6 +2401,12 @@ static int __devinit r8a66597_probe(struct platform_device *pdev)
 		goto clean_up;
 	}

+	if (pdev->dev.platform_data = NULL) {
+		dev_err(&pdev->dev, "no platform data\n");
+		ret = -ENODEV;
+		goto clean_up;
+	}
+
 	/* initialize hcd */
 	hcd = usb_create_hcd(&r8a66597_hc_driver, &pdev->dev, (char *)hcd_name);
 	if (!hcd) {
@@ -2428,6 +2417,7 @@ static int __devinit r8a66597_probe(struct platform_device *pdev)
 	r8a66597 = hcd_to_r8a66597(hcd);
 	memset(r8a66597, 0, sizeof(struct r8a66597));
 	dev_set_drvdata(&pdev->dev, r8a66597);
+	r8a66597->pdata = pdev->dev.platform_data;

 #if defined(CONFIG_SUPERH_ON_CHIP_R8A66597) && defined(CONFIG_HAVE_CLK)
 	snprintf(clk_name, sizeof(clk_name), "usb%d", pdev->id);
@@ -2458,29 +2448,6 @@ static int __devinit r8a66597_probe(struct platform_device *pdev)

 	hcd->rsrc_start = res->start;

-	/* irq_sense setting on cmdline takes precedence over resource
-	 * settings, so the introduction of irqflags in IRQ resourse
-	 * won't disturb existing setups */
-	switch (irq_sense) {
-		case INTL:
-			irq_trigger = IRQF_TRIGGER_LOW;
-			break;
-		case 0:
-			irq_trigger = IRQF_TRIGGER_FALLING;
-			break;
-		case 0xff:
-			if (irq_trigger)
-				irq_sense = (irq_trigger & IRQF_TRIGGER_LOW) ?
-					    INTL : 0;
-			else {
-				irq_sense = INTL;
-				irq_trigger = IRQF_TRIGGER_LOW;
-			}
-			break;
-		default:
-			dev_err(&pdev->dev, "Unknown irq_sense value.\n");
-	}
-
 	ret = usb_add_hcd(hcd, irq, IRQF_DISABLED | irq_trigger);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "Failed to add hcd\n");
diff --git a/drivers/usb/host/r8a66597.h b/drivers/usb/host/r8a66597.h
index f49208f..4d1203e 100644
--- a/drivers/usb/host/r8a66597.h
+++ b/drivers/usb/host/r8a66597.h
@@ -30,6 +30,8 @@
 #include <linux/clk.h>
 #endif

+#include <linux/usb/r8a66597.h>
+
 #define SYSCFG0		0x00
 #define SYSCFG1		0x02
 #define SYSSTS0		0x04
@@ -488,6 +490,7 @@ struct r8a66597 {
 #if defined(CONFIG_SUPERH_ON_CHIP_R8A66597) && defined(CONFIG_HAVE_CLK)
 	struct clk *clk;
 #endif
+	struct r8a66597_platdata	*pdata;
 	struct r8a66597_device		device0;
 	struct r8a66597_root_hub	root_hub[R8A66597_MAX_ROOT_HUB];
 	struct list_head		pipe_queue[R8A66597_MAX_NUM_PIPE];
@@ -660,10 +663,36 @@ static inline void r8a66597_port_power(struct r8a66597 *r8a66597, int port,
 {
 	unsigned long dvstctr_reg = get_dvstctr_reg(port);

-	if (power)
-		r8a66597_bset(r8a66597, VBOUT, dvstctr_reg);
-	else
-		r8a66597_bclr(r8a66597, VBOUT, dvstctr_reg);
+	if (r8a66597->pdata->port_power) {
+		r8a66597->pdata->port_power(port, power);
+	} else {
+		if (power)
+			r8a66597_bset(r8a66597, VBOUT, dvstctr_reg);
+		else
+			r8a66597_bclr(r8a66597, VBOUT, dvstctr_reg);
+	}
+}
+
+static inline u16 get_xtal_from_pdata(struct r8a66597_platdata *pdata)
+{
+	u16 clock = 0;
+
+	switch (pdata->xtal) {
+	case R8A66597_PLATDATA_XTAL_12MHZ:
+		clock = XTAL12;
+		break;
+	case R8A66597_PLATDATA_XTAL_24MHZ:
+		clock = XTAL24;
+		break;
+	case R8A66597_PLATDATA_XTAL_48MHZ:
+		clock = XTAL48;
+		break;
+	default:
+		printk(KERN_ERR "r8a66597: platdata clock is wrong.\n");
+		break;
+	}
+
+	return clock;
 }

 #define get_pipectr_addr(pipenum)	(PIPE1CTR + (pipenum - 1) * 2)
diff --git a/include/linux/usb/r8a66597.h b/include/linux/usb/r8a66597.h
new file mode 100644
index 0000000..7322ff3
--- /dev/null
+++ b/include/linux/usb/r8a66597.h
@@ -0,0 +1,47 @@
+/*
+ * R8A66597 driver platform data
+ *
+ * Copyright (C) 2009  Renesas Solutions Corp.
+ *
+ * Author : Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifndef __LINUX_USB_R8A66597_H
+#define __LINUX_USB_R8A66597_H
+
+#define R8A66597_PLATDATA_XTAL_12MHZ	0x01
+#define R8A66597_PLATDATA_XTAL_24MHZ	0x02
+#define R8A66597_PLATDATA_XTAL_48MHZ	0x03
+
+struct r8a66597_platdata {
+	/* This ops can controll port power instead of DVSTCTR register. */
+	void (*port_power)(int port, int power);
+
+	/* (external controller only) set R8A66597_PLATDATA_XTAL_nnMHZ */
+	unsigned	xtal:2;
+
+	/* set one = 3.3V, set zero = 1.5V */
+	unsigned	vif:1;
+
+	/* set one = big endian, set zero = little endian */
+	unsigned	endian:1;
+
+	/* set one = low level, set zero = falling edge */
+	unsigned	irq_sense:1;
+};
+#endif
+
-- 
1.5.5


