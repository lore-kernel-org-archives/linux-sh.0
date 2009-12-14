From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 14 Dec 2009 12:29:48 +0000
Subject: [PATCH 01/07] sh: sh2 scif pdata (sh7616)
Message-Id: <20091214122948.10707.58674.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch breaks out the sh2 scif serial port platform
data from a shared platform device to one platform
device per port. Also, add serial ports to the list of
early platform devices.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh2/setup-sh7619.c |   67 +++++++++++++++++++++------------
 1 file changed, 44 insertions(+), 23 deletions(-)

--- 0001/arch/sh/kernel/cpu/sh2/setup-sh7619.c
+++ work/arch/sh/kernel/cpu/sh2/setup-sh7619.c	2009-12-14 19:43:25.000000000 +0900
@@ -59,32 +59,48 @@ static struct intc_prio_reg prio_registe
 static DECLARE_INTC_DESC(intc_desc, "sh7619", vectors, NULL,
 			 NULL, prio_registers, NULL);
 
-static struct plat_sci_port sci_platform_data[] = {
-	{
-		.mapbase	= 0xf8400000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 88, 88, 88, 88 },
-	}, {
-		.mapbase	= 0xf8410000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 92, 92, 92, 92 },
-	}, {
-		.mapbase	= 0xf8420000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 96, 96, 96, 96 },
-	}, {
-		.flags = 0,
-	}
+static struct plat_sci_port scif0_platform_data = {
+	.mapbase	= 0xf8400000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 88, 88, 88, 88 },
 };
 
-static struct platform_device sci_device = {
+static struct platform_device scif0_device = {
 	.name		= "sh-sci",
-	.id		= -1,
+	.id		= 0,
+	.dev		= {
+		.platform_data	= &scif0_platform_data,
+	},
+};
+
+static struct plat_sci_port scif1_platform_data = {
+	.mapbase	= 0xf8410000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 92, 92, 92, 92 },
+};
+
+static struct platform_device scif1_device = {
+	.name		= "sh-sci",
+	.id		= 1,
+	.dev		= {
+		.platform_data	= &scif1_platform_data,
+	},
+};
+
+static struct plat_sci_port scif2_platform_data = {
+	.mapbase	= 0xf8420000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 96, 96, 96, 96 },
+};
+
+static struct platform_device scif2_device = {
+	.name		= "sh-sci",
+	.id		= 2,
 	.dev		= {
-		.platform_data	= sci_platform_data,
+		.platform_data	= &scif2_platform_data,
 	},
 };
 
@@ -176,7 +192,9 @@ static struct platform_device cmt1_devic
 };
 
 static struct platform_device *sh7619_devices[] __initdata = {
-	&sci_device,
+	&scif0_device,
+	&scif1_device,
+	&scif2_device,
 	&eth_device,
 	&cmt0_device,
 	&cmt1_device,
@@ -195,6 +213,9 @@ void __init plat_irq_setup(void)
 }
 
 static struct platform_device *sh7619_early_devices[] __initdata = {
+	&scif0_device,
+	&scif1_device,
+	&scif2_device,
 	&cmt0_device,
 	&cmt1_device,
 };
