From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 14 Dec 2009 12:30:41 +0000
Subject: [PATCH 07/07] sh: sh5 scif pdata (sh5-101/sh5-103)
Message-Id: <20091214123041.10707.94848.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch breaks out the sh5 scif serial port platform
data from a shared platform device to one platform
device per port. Also, move the serial port to the list
of early platform devices.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh5/setup-sh5.c |   22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

--- 0001/arch/sh/kernel/cpu/sh5/setup-sh5.c
+++ work/arch/sh/kernel/cpu/sh5/setup-sh5.c	2009-12-14 20:54:00.000000000 +0900
@@ -16,22 +16,18 @@
 #include <linux/sh_timer.h>
 #include <asm/addrspace.h>
 
-static struct plat_sci_port sci_platform_data[] = {
-	{
-		.mapbase	= PHYS_PERIPHERAL_BLOCK + 0x01030000,
-		.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,
-		.type		= PORT_SCIF,
-		.irqs		= { 39, 40, 42, 0 },
-	}, {
-		.flags = 0,
-	}
+static struct plat_sci_port scif0_platform_data = {
+	.mapbase	= PHYS_PERIPHERAL_BLOCK + 0x01030000,
+	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,
+	.type		= PORT_SCIF,
+	.irqs		= { 39, 40, 42, 0 },
 };
 
-static struct platform_device sci_device = {
+static struct platform_device scif0_device = {
 	.name		= "sh-sci",
-	.id		= -1,
+	.id		= 0,
 	.dev		= {
-		.platform_data	= sci_platform_data,
+		.platform_data	= &scif0_platform_data,
 	},
 };
 
@@ -164,13 +160,13 @@ static struct platform_device tmu2_devic
 };
 
 static struct platform_device *sh5_early_devices[] __initdata = {
+	&scif0_device,
 	&tmu0_device,
 	&tmu1_device,
 	&tmu2_device,
 };
 
 static struct platform_device *sh5_devices[] __initdata = {
-	&sci_device,
 	&rtc_device,
 };
 
