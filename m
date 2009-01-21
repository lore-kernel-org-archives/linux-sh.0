From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 21 Jan 2009 15:14:46 +0000
Subject: [PATCH 009/013] sh-sci: convert sh2 cpu to single port devices
Message-Id: <20090121151446.29269.48937.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Rework sh-sci platform data for sh2 processors such as:
 sh7619

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh2/setup-sh7619.c |   64 +++++++++++++++++++++------------
 1 file changed, 41 insertions(+), 23 deletions(-)

--- 0001/arch/sh/kernel/cpu/sh2/setup-sh7619.c
+++ work/arch/sh/kernel/cpu/sh2/setup-sh7619.c	2009-01-21 22:51:11.000000000 +0900
@@ -67,32 +67,48 @@ static struct intc_prio_reg prio_registe
 static DECLARE_INTC_DESC(intc_desc, "sh7619", vectors, groups,
 			 NULL, prio_registers, NULL);
 
-static struct plat_sci_port sci_platform_data[] = {
-	{
-		.mapbase	= 0xf8400000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		=  { 88, 89, 91, 90},
-	}, {
-		.mapbase	= 0xf8410000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		=  { 92, 93, 95, 94},
-	}, {
-		.mapbase	= 0xf8420000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		=  { 96, 97, 99, 98},
-	}, {
-		.flags = 0,
-	}
+static struct plat_sci_port scif0_platform_data = {
+	.mapbase	= 0xf8400000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		=  { 88, 89, 91, 90 },
 };
 
-static struct platform_device sci_device = {
+static struct platform_device scif0_device = {
 	.name		= "sh-sci",
-	.id		= -1,
+	.id		= 0,
 	.dev		= {
-		.platform_data	= sci_platform_data,
+		.platform_data	= &scif0_platform_data,
+	},
+};
+
+static struct plat_sci_port scif1_platform_data = {
+	.mapbase	= 0xf8410000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		=  { 92, 93, 95, 94 },
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
+	.irqs		=  { 96, 97, 99, 98 },
+};
+
+static struct platform_device scif2_device = {
+	.name		= "sh-sci",
+	.id		= 2,
+	.dev		= {
+		.platform_data	= &scif2_platform_data,
 	},
 };
 
@@ -120,7 +136,9 @@ static struct platform_device eth_device
 };
 
 static struct platform_device *sh7619_devices[] __initdata = {
-	&sci_device,
+	&scif0_device,
+	&scif1_device,
+	&scif2_device,
 	&eth_device,
 };
 
